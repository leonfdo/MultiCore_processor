package testbench

import chisel3._
import chisel3.util._
import chisel3.experimental.BundleLiterals._
import chisel3.experimental.IO

import pipeline.ports._
import common.coreConfiguration._
import cache.AXI
import os.read
import os.readLink
import os.write

class uart extends Module {
  val client = IO(Flipped(new AXI))

  val readRequestBuffer = RegInit(new Bundle {
    val valid = Bool()
    val address = UInt(32.W)
    val size = UInt(3.W)
    val len = UInt(8.W)
    val id = client.ARID.cloneType
  } Lit(_.valid -> false.B))

  val writeRequestBuffer = RegInit(new Bundle {
    val address = new Bundle {
      val valid = Bool()
      val offset = UInt(32.W)
      val size = UInt(3.W)
      val len = UInt(8.W)
      val id = client.AWID.cloneType
    }
    val data = new Bundle {
      val valid = Bool()
      val data = UInt(32.W)
      val last = Bool()
      val strb = UInt(4.W)
    }
  } Lit(_.address.valid -> false.B, _.data.valid -> false.B))

  when(client.ARREADY && client.ARVALID) { 
    readRequestBuffer.valid := true.B
    readRequestBuffer.address := client.ARADDR
    readRequestBuffer.len := client.ARLEN
    readRequestBuffer.size := client.ARSIZE
    readRequestBuffer.id := client.ARID
  }

  when(readRequestBuffer.valid && client.RREADY) {
    readRequestBuffer.len := readRequestBuffer.len - 1.U
    when(!readRequestBuffer.len.orR) { readRequestBuffer.valid := false.B }
  }
  val mtime = RegInit(0.U(64.W))
  val mtimecmp = RegInit(0.U(64.W))
  val mtimecmplowtemp = Reg(UInt(32.W))
  val couter_wrap = RegInit(0.U(4.W))
  couter_wrap := couter_wrap + 1.U
  mtime := mtime + couter_wrap.andR.asUInt
  val mtimeRead = Reg(UInt(64.W))
  when(client.ARREADY && client.ARVALID) {
    mtimeRead := mtime
  }

  // we don't expect writes larger than 64-bits to uart or clint
  val writeData = Reg(UInt(64.W))

  // client.RDATA := Mux((readRequestBuffer.address&("hff".U)) === ("h2c".U), 8.U, 0.U)
  val ps_stat = RegInit(0.U(32.W))
  client.RDATA := 8.U
  switch(readRequestBuffer.address) {
    is("he000002c".U) { client.RDATA := 2.U }
    is("he000102c".U) { client.RDATA := 2.U }
    is("h0200bff8".U) { client.RDATA := Mux(readRequestBuffer.len.orR, mtimeRead(31, 0), mtimeRead(63, 32)) }
    is("h04000000".U) { client.RDATA := ps_stat }
  }
  client.RID := readRequestBuffer.id
  client.RLAST := !readRequestBuffer.len.orR
  client.RRESP := 0.U
  client.RVALID := readRequestBuffer.valid

  val putChar = Wire(new Bundle {
    val valid = Bool()
    val byte = UInt(8.W)
  })
  putChar.valid := Seq((writeRequestBuffer.address.offset&("hff".U)) === ("h30".U), writeRequestBuffer.address.valid, writeRequestBuffer.data.valid).reduce(_ && _)
  putChar.byte := writeRequestBuffer.data.data(7, 0)

  val lastUartChars = RegInit(VecInit(Seq.fill(17)(0.U(8.W))))
  when(putChar.valid) {
    lastUartChars.zip(putChar.byte +: lastUartChars.dropRight(1))
    .foreach { case(buffer, next) => { buffer := next } }  
  }

  val terminalReady = RegInit(false.B)
  when(!terminalReady) {
    terminalReady := "buildroot login: ".reverse.toCharArray().toSeq.zip(lastUartChars.toSeq) map { case(char, uchar) => (char.U === uchar)} reduce(_ && _)
  }

  val afterLogin = RegInit(false.B)
  when(!afterLogin) {
    afterLogin := "~ # ".reverse.toCharArray().toSeq.zip(lastUartChars.toSeq) map { case(char, uchar) => (char.U === uchar)} reduce(_ && _)
  }

  val hardInput = RegInit(VecInit("root\nls ..".map(c => new Bundle {
    val valid = Bool()
    val char = UInt(8.W)
  } Lit(_.valid -> true.B, _.char -> c.U))))

  val command = RegInit(VecInit("ls .. && poweroff\n".map(c => new Bundle {
    val valid = Bool()
    val char = UInt(8.W)
  } Lit(_.valid -> true.B, _.char -> c.U))))

  when(
    ((readRequestBuffer.address & "hffff0fff".U) === "he000002c".U) && 
    readRequestBuffer.valid && terminalReady && !afterLogin
  ) {
    client.RDATA := (8.U(32.W) | Cat(!(hardInput(0).valid.asUInt),0.U(1.W)))
  }

  when(
    ((readRequestBuffer.address & "hffff0fff".U) === "he0000030".U) && 
    readRequestBuffer.valid && terminalReady && !afterLogin
  ) {
    client.RDATA := hardInput(0).char
    when(client.RREADY) {
      hardInput.dropRight(1).zip(hardInput.drop(1)).foreach { case(curr, next) => curr := next }
      hardInput.last.valid := false.B
    }
  }

  when(
    ((readRequestBuffer.address & "hffff0fff".U) === "he000002c".U) && 
    readRequestBuffer.valid && afterLogin
  ) {
    client.RDATA := (8.U(32.W) | Cat(!(command(0).valid.asUInt),0.U(1.W)))
  }

  when(
    ((readRequestBuffer.address & "hffff0fff".U) === "he0000030".U) && 
    readRequestBuffer.valid && afterLogin
  ) {
    client.RDATA := command(0).char
    when(client.RREADY) {
      command.dropRight(1).zip(command.drop(1)).foreach { case(curr, next) => curr := next }
      command.last.valid := false.B
    }
  }

  when(writeRequestBuffer.address.valid && writeRequestBuffer.data.valid) {
    writeRequestBuffer.data.valid := false.B
    when(writeRequestBuffer.data.last) {
      writeRequestBuffer.address.valid := false.B
    }
  }

  when(client.AWREADY && client.AWVALID) {
    writeRequestBuffer.address.valid := true.B
    writeRequestBuffer.address.offset := client.AWADDR
    writeRequestBuffer.address.id := client.AWID
    writeRequestBuffer.address.len := client.AWLEN
    writeRequestBuffer.address.size := client.AWSIZE
  }

  when(client.WREADY && client.WVALID) {
    writeRequestBuffer.data.valid := true.B
    writeRequestBuffer.data.data := client.WDATA
    writeRequestBuffer.data.last := client.WLAST
    writeRequestBuffer.data.strb := client.WSTRB
  }

  when(writeRequestBuffer.data.valid && !writeRequestBuffer.data.last) { mtimecmplowtemp := writeRequestBuffer.data.data }
  when(
    writeRequestBuffer.address.valid && 
    (writeRequestBuffer.address.offset === "h02004000".U) &&
    writeRequestBuffer.data.valid &&
    writeRequestBuffer.data.last
  ) {
    mtimecmp := Cat(writeRequestBuffer.data.data, mtimecmplowtemp)
  }

  client.ARREADY := !readRequestBuffer.valid

  client.AWREADY := !writeRequestBuffer.address.valid
  client.WREADY := !writeRequestBuffer.data.valid || writeRequestBuffer.address.valid

  client.BID := writeRequestBuffer.address.id
  client.BRESP := 0.U
  client.BVALID := writeRequestBuffer.address.valid && writeRequestBuffer.data.valid && writeRequestBuffer.data.last

  val MTIP = IO(Output(Bool()))
  MTIP := (mtime > mtimecmp)
}

object uart extends App {
  emitVerilog(new uart)
}

class psClint extends uart {
  val psMaster = IO(Flipped(new AXI))

  val awFired, wFired, bValid, finished = RegInit(false.B)
  psMaster.AWREADY := !awFired
  psMaster.WREADY := !wFired
  psMaster.BVALID := awFired && wFired

  when(psMaster.AWVALID && psMaster.AWREADY) { awFired := true.B }
  when(psMaster.WVALID && psMaster.WREADY) { wFired := true.B }
  when(psMaster.BVALID && psMaster.BREADY) { finished := true.B }

  when(finished) {
    psMaster.AWREADY := false.B
    psMaster.WREADY := false.B
    psMaster.BVALID := false.B
  }
  val bid = Reg(psMaster.AWID.cloneType)
  when(psMaster.AWREADY && psMaster.AWVALID) { bid := psMaster.AWID }
  psMaster.BID := bid
  psMaster.BRESP := 0.U

  psMaster.ARREADY := false.B

  psMaster.RVALID := false.B
  psMaster.RDATA := 0.U
  psMaster.RID := 0.U
  psMaster.RLAST := false.B
  psMaster.RRESP := 0.U
  when(psMaster.WREADY && psMaster.WVALID) { ps_stat := psMaster.WDATA }

  val STANDBY, RUNNING = IO(Output(Bool()))
  STANDBY := !ps_stat.orR
  RUNNING := ps_stat.orR
}

object psClint extends App {
  emitVerilog(new psClint)
}