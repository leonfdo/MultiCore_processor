module Memory(
  input          clock,
  input  [31:0]  io_addr,
  output [511:0] io_readData_0,
  output [511:0] io_readData_1,
  output [511:0] io_readData_2,
  output [511:0] io_readData_3,
  input  [511:0] io_writeData_0,
  input  [511:0] io_writeData_1,
  input  [511:0] io_writeData_2,
  input  [511:0] io_writeData_3,
  input          io_writeEnable,
  output         io_hit,
  input          io_hit_ready,
  input          io_replace_ready,
  output         io_replace,
  output [31:0]  io_replace_addr,
  input          io_full_line
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_3;
  reg [511:0] _RAND_6;
  reg [511:0] _RAND_9;
  reg [511:0] _RAND_12;
  reg [511:0] _RAND_15;
  reg [31:0] _RAND_18;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
`endif // RANDOMIZE_REG_INIT
  reg  mem_valid [0:8191]; // @[cache_mem.scala 28:24]
  wire  mem_valid_cacheLineRead_en; // @[cache_mem.scala 28:24]
  wire [12:0] mem_valid_cacheLineRead_addr; // @[cache_mem.scala 28:24]
  wire  mem_valid_cacheLineRead_data; // @[cache_mem.scala 28:24]
  wire  mem_valid_MPORT_data; // @[cache_mem.scala 28:24]
  wire [12:0] mem_valid_MPORT_addr; // @[cache_mem.scala 28:24]
  wire  mem_valid_MPORT_mask; // @[cache_mem.scala 28:24]
  wire  mem_valid_MPORT_en; // @[cache_mem.scala 28:24]
  reg  mem_valid_cacheLineRead_en_pipe_0;
  reg [12:0] mem_valid_cacheLineRead_addr_pipe_0;
  reg [10:0] mem_tag [0:8191]; // @[cache_mem.scala 28:24]
  wire  mem_tag_cacheLineRead_en; // @[cache_mem.scala 28:24]
  wire [12:0] mem_tag_cacheLineRead_addr; // @[cache_mem.scala 28:24]
  wire [10:0] mem_tag_cacheLineRead_data; // @[cache_mem.scala 28:24]
  wire [10:0] mem_tag_MPORT_data; // @[cache_mem.scala 28:24]
  wire [12:0] mem_tag_MPORT_addr; // @[cache_mem.scala 28:24]
  wire  mem_tag_MPORT_mask; // @[cache_mem.scala 28:24]
  wire  mem_tag_MPORT_en; // @[cache_mem.scala 28:24]
  reg  mem_tag_cacheLineRead_en_pipe_0;
  reg [12:0] mem_tag_cacheLineRead_addr_pipe_0;
  reg [511:0] mem_data_0 [0:8191]; // @[cache_mem.scala 28:24]
  wire  mem_data_0_cacheLineRead_en; // @[cache_mem.scala 28:24]
  wire [12:0] mem_data_0_cacheLineRead_addr; // @[cache_mem.scala 28:24]
  wire [511:0] mem_data_0_cacheLineRead_data; // @[cache_mem.scala 28:24]
  wire [511:0] mem_data_0_MPORT_data; // @[cache_mem.scala 28:24]
  wire [12:0] mem_data_0_MPORT_addr; // @[cache_mem.scala 28:24]
  wire  mem_data_0_MPORT_mask; // @[cache_mem.scala 28:24]
  wire  mem_data_0_MPORT_en; // @[cache_mem.scala 28:24]
  reg  mem_data_0_cacheLineRead_en_pipe_0;
  reg [12:0] mem_data_0_cacheLineRead_addr_pipe_0;
  reg [511:0] mem_data_1 [0:8191]; // @[cache_mem.scala 28:24]
  wire  mem_data_1_cacheLineRead_en; // @[cache_mem.scala 28:24]
  wire [12:0] mem_data_1_cacheLineRead_addr; // @[cache_mem.scala 28:24]
  wire [511:0] mem_data_1_cacheLineRead_data; // @[cache_mem.scala 28:24]
  wire [511:0] mem_data_1_MPORT_data; // @[cache_mem.scala 28:24]
  wire [12:0] mem_data_1_MPORT_addr; // @[cache_mem.scala 28:24]
  wire  mem_data_1_MPORT_mask; // @[cache_mem.scala 28:24]
  wire  mem_data_1_MPORT_en; // @[cache_mem.scala 28:24]
  reg  mem_data_1_cacheLineRead_en_pipe_0;
  reg [12:0] mem_data_1_cacheLineRead_addr_pipe_0;
  reg [511:0] mem_data_2 [0:8191]; // @[cache_mem.scala 28:24]
  wire  mem_data_2_cacheLineRead_en; // @[cache_mem.scala 28:24]
  wire [12:0] mem_data_2_cacheLineRead_addr; // @[cache_mem.scala 28:24]
  wire [511:0] mem_data_2_cacheLineRead_data; // @[cache_mem.scala 28:24]
  wire [511:0] mem_data_2_MPORT_data; // @[cache_mem.scala 28:24]
  wire [12:0] mem_data_2_MPORT_addr; // @[cache_mem.scala 28:24]
  wire  mem_data_2_MPORT_mask; // @[cache_mem.scala 28:24]
  wire  mem_data_2_MPORT_en; // @[cache_mem.scala 28:24]
  reg  mem_data_2_cacheLineRead_en_pipe_0;
  reg [12:0] mem_data_2_cacheLineRead_addr_pipe_0;
  reg [511:0] mem_data_3 [0:8191]; // @[cache_mem.scala 28:24]
  wire  mem_data_3_cacheLineRead_en; // @[cache_mem.scala 28:24]
  wire [12:0] mem_data_3_cacheLineRead_addr; // @[cache_mem.scala 28:24]
  wire [511:0] mem_data_3_cacheLineRead_data; // @[cache_mem.scala 28:24]
  wire [511:0] mem_data_3_MPORT_data; // @[cache_mem.scala 28:24]
  wire [12:0] mem_data_3_MPORT_addr; // @[cache_mem.scala 28:24]
  wire  mem_data_3_MPORT_mask; // @[cache_mem.scala 28:24]
  wire  mem_data_3_MPORT_en; // @[cache_mem.scala 28:24]
  reg  mem_data_3_cacheLineRead_en_pipe_0;
  reg [12:0] mem_data_3_cacheLineRead_addr_pipe_0;
  reg  mem_dirty [0:8191]; // @[cache_mem.scala 28:24]
  wire  mem_dirty_cacheLineRead_en; // @[cache_mem.scala 28:24]
  wire [12:0] mem_dirty_cacheLineRead_addr; // @[cache_mem.scala 28:24]
  wire  mem_dirty_cacheLineRead_data; // @[cache_mem.scala 28:24]
  wire  mem_dirty_MPORT_data; // @[cache_mem.scala 28:24]
  wire [12:0] mem_dirty_MPORT_addr; // @[cache_mem.scala 28:24]
  wire  mem_dirty_MPORT_mask; // @[cache_mem.scala 28:24]
  wire  mem_dirty_MPORT_en; // @[cache_mem.scala 28:24]
  reg  mem_dirty_cacheLineRead_en_pipe_0;
  reg [12:0] mem_dirty_cacheLineRead_addr_pipe_0;
  wire [12:0] index = io_addr[20:8]; // @[cache_mem.scala 31:22]
  wire [10:0] tag = io_addr[31:21]; // @[cache_mem.scala 32:20]
  wire  _io_hit_T_1 = mem_tag_cacheLineRead_data == tag; // @[cache_mem.scala 38:71]
  wire [23:0] io_replace_addr_hi = {mem_tag_cacheLineRead_data,index}; // @[Cat.scala 33:92]
  assign mem_valid_cacheLineRead_en = mem_valid_cacheLineRead_en_pipe_0;
  assign mem_valid_cacheLineRead_addr = mem_valid_cacheLineRead_addr_pipe_0;
  assign mem_valid_cacheLineRead_data = mem_valid[mem_valid_cacheLineRead_addr]; // @[cache_mem.scala 28:24]
  assign mem_valid_MPORT_data = 1'h1;
  assign mem_valid_MPORT_addr = io_addr[20:8];
  assign mem_valid_MPORT_mask = 1'h1;
  assign mem_valid_MPORT_en = io_writeEnable;
  assign mem_tag_cacheLineRead_en = mem_tag_cacheLineRead_en_pipe_0;
  assign mem_tag_cacheLineRead_addr = mem_tag_cacheLineRead_addr_pipe_0;
  assign mem_tag_cacheLineRead_data = mem_tag[mem_tag_cacheLineRead_addr]; // @[cache_mem.scala 28:24]
  assign mem_tag_MPORT_data = io_addr[31:21];
  assign mem_tag_MPORT_addr = io_addr[20:8];
  assign mem_tag_MPORT_mask = 1'h1;
  assign mem_tag_MPORT_en = io_writeEnable;
  assign mem_data_0_cacheLineRead_en = mem_data_0_cacheLineRead_en_pipe_0;
  assign mem_data_0_cacheLineRead_addr = mem_data_0_cacheLineRead_addr_pipe_0;
  assign mem_data_0_cacheLineRead_data = mem_data_0[mem_data_0_cacheLineRead_addr]; // @[cache_mem.scala 28:24]
  assign mem_data_0_MPORT_data = io_writeData_0;
  assign mem_data_0_MPORT_addr = io_addr[20:8];
  assign mem_data_0_MPORT_mask = 1'h1;
  assign mem_data_0_MPORT_en = io_writeEnable;
  assign mem_data_1_cacheLineRead_en = mem_data_1_cacheLineRead_en_pipe_0;
  assign mem_data_1_cacheLineRead_addr = mem_data_1_cacheLineRead_addr_pipe_0;
  assign mem_data_1_cacheLineRead_data = mem_data_1[mem_data_1_cacheLineRead_addr]; // @[cache_mem.scala 28:24]
  assign mem_data_1_MPORT_data = io_writeData_1;
  assign mem_data_1_MPORT_addr = io_addr[20:8];
  assign mem_data_1_MPORT_mask = 1'h1;
  assign mem_data_1_MPORT_en = io_writeEnable;
  assign mem_data_2_cacheLineRead_en = mem_data_2_cacheLineRead_en_pipe_0;
  assign mem_data_2_cacheLineRead_addr = mem_data_2_cacheLineRead_addr_pipe_0;
  assign mem_data_2_cacheLineRead_data = mem_data_2[mem_data_2_cacheLineRead_addr]; // @[cache_mem.scala 28:24]
  assign mem_data_2_MPORT_data = io_writeData_2;
  assign mem_data_2_MPORT_addr = io_addr[20:8];
  assign mem_data_2_MPORT_mask = 1'h1;
  assign mem_data_2_MPORT_en = io_writeEnable;
  assign mem_data_3_cacheLineRead_en = mem_data_3_cacheLineRead_en_pipe_0;
  assign mem_data_3_cacheLineRead_addr = mem_data_3_cacheLineRead_addr_pipe_0;
  assign mem_data_3_cacheLineRead_data = mem_data_3[mem_data_3_cacheLineRead_addr]; // @[cache_mem.scala 28:24]
  assign mem_data_3_MPORT_data = io_writeData_3;
  assign mem_data_3_MPORT_addr = io_addr[20:8];
  assign mem_data_3_MPORT_mask = 1'h1;
  assign mem_data_3_MPORT_en = io_writeEnable;
  assign mem_dirty_cacheLineRead_en = mem_dirty_cacheLineRead_en_pipe_0;
  assign mem_dirty_cacheLineRead_addr = mem_dirty_cacheLineRead_addr_pipe_0;
  assign mem_dirty_cacheLineRead_data = mem_dirty[mem_dirty_cacheLineRead_addr]; // @[cache_mem.scala 28:24]
  assign mem_dirty_MPORT_data = io_full_line ? 1'h0 : 1'h1;
  assign mem_dirty_MPORT_addr = io_addr[20:8];
  assign mem_dirty_MPORT_mask = 1'h1;
  assign mem_dirty_MPORT_en = io_writeEnable;
  assign io_readData_0 = mem_data_0_cacheLineRead_data; // @[cache_mem.scala 36:15]
  assign io_readData_1 = mem_data_1_cacheLineRead_data; // @[cache_mem.scala 36:15]
  assign io_readData_2 = mem_data_2_cacheLineRead_data; // @[cache_mem.scala 36:15]
  assign io_readData_3 = mem_data_3_cacheLineRead_data; // @[cache_mem.scala 36:15]
  assign io_hit = io_hit_ready & mem_valid_cacheLineRead_data & mem_tag_cacheLineRead_data == tag; // @[cache_mem.scala 38:49]
  assign io_replace = mem_valid_cacheLineRead_data & io_replace_ready & ~_io_hit_T_1 & mem_dirty_cacheLineRead_data; // @[cache_mem.scala 41:87]
  assign io_replace_addr = {io_replace_addr_hi,8'h0}; // @[Cat.scala 33:92]
  always @(posedge clock) begin
    if (mem_valid_MPORT_en & mem_valid_MPORT_mask) begin
      mem_valid[mem_valid_MPORT_addr] <= mem_valid_MPORT_data; // @[cache_mem.scala 28:24]
    end
    mem_valid_cacheLineRead_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_valid_cacheLineRead_addr_pipe_0 <= io_addr[20:8];
    end
    if (mem_tag_MPORT_en & mem_tag_MPORT_mask) begin
      mem_tag[mem_tag_MPORT_addr] <= mem_tag_MPORT_data; // @[cache_mem.scala 28:24]
    end
    mem_tag_cacheLineRead_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_tag_cacheLineRead_addr_pipe_0 <= io_addr[20:8];
    end
    if (mem_data_0_MPORT_en & mem_data_0_MPORT_mask) begin
      mem_data_0[mem_data_0_MPORT_addr] <= mem_data_0_MPORT_data; // @[cache_mem.scala 28:24]
    end
    mem_data_0_cacheLineRead_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_data_0_cacheLineRead_addr_pipe_0 <= io_addr[20:8];
    end
    if (mem_data_1_MPORT_en & mem_data_1_MPORT_mask) begin
      mem_data_1[mem_data_1_MPORT_addr] <= mem_data_1_MPORT_data; // @[cache_mem.scala 28:24]
    end
    mem_data_1_cacheLineRead_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_data_1_cacheLineRead_addr_pipe_0 <= io_addr[20:8];
    end
    if (mem_data_2_MPORT_en & mem_data_2_MPORT_mask) begin
      mem_data_2[mem_data_2_MPORT_addr] <= mem_data_2_MPORT_data; // @[cache_mem.scala 28:24]
    end
    mem_data_2_cacheLineRead_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_data_2_cacheLineRead_addr_pipe_0 <= io_addr[20:8];
    end
    if (mem_data_3_MPORT_en & mem_data_3_MPORT_mask) begin
      mem_data_3[mem_data_3_MPORT_addr] <= mem_data_3_MPORT_data; // @[cache_mem.scala 28:24]
    end
    mem_data_3_cacheLineRead_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_data_3_cacheLineRead_addr_pipe_0 <= io_addr[20:8];
    end
    if (mem_dirty_MPORT_en & mem_dirty_MPORT_mask) begin
      mem_dirty[mem_dirty_MPORT_addr] <= mem_dirty_MPORT_data; // @[cache_mem.scala 28:24]
    end
    mem_dirty_cacheLineRead_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_dirty_cacheLineRead_addr_pipe_0 <= io_addr[20:8];
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8192; initvar = initvar+1)
    mem_valid[initvar] = _RAND_0[0:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8192; initvar = initvar+1)
    mem_tag[initvar] = _RAND_3[10:0];
  _RAND_6 = {16{`RANDOM}};
  for (initvar = 0; initvar < 8192; initvar = initvar+1)
    mem_data_0[initvar] = _RAND_6[511:0];
  _RAND_9 = {16{`RANDOM}};
  for (initvar = 0; initvar < 8192; initvar = initvar+1)
    mem_data_1[initvar] = _RAND_9[511:0];
  _RAND_12 = {16{`RANDOM}};
  for (initvar = 0; initvar < 8192; initvar = initvar+1)
    mem_data_2[initvar] = _RAND_12[511:0];
  _RAND_15 = {16{`RANDOM}};
  for (initvar = 0; initvar < 8192; initvar = initvar+1)
    mem_data_3[initvar] = _RAND_15[511:0];
  _RAND_18 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8192; initvar = initvar+1)
    mem_dirty[initvar] = _RAND_18[0:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_valid_cacheLineRead_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_valid_cacheLineRead_addr_pipe_0 = _RAND_2[12:0];
  _RAND_4 = {1{`RANDOM}};
  mem_tag_cacheLineRead_en_pipe_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  mem_tag_cacheLineRead_addr_pipe_0 = _RAND_5[12:0];
  _RAND_7 = {1{`RANDOM}};
  mem_data_0_cacheLineRead_en_pipe_0 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  mem_data_0_cacheLineRead_addr_pipe_0 = _RAND_8[12:0];
  _RAND_10 = {1{`RANDOM}};
  mem_data_1_cacheLineRead_en_pipe_0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  mem_data_1_cacheLineRead_addr_pipe_0 = _RAND_11[12:0];
  _RAND_13 = {1{`RANDOM}};
  mem_data_2_cacheLineRead_en_pipe_0 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  mem_data_2_cacheLineRead_addr_pipe_0 = _RAND_14[12:0];
  _RAND_16 = {1{`RANDOM}};
  mem_data_3_cacheLineRead_en_pipe_0 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  mem_data_3_cacheLineRead_addr_pipe_0 = _RAND_17[12:0];
  _RAND_19 = {1{`RANDOM}};
  mem_dirty_cacheLineRead_en_pipe_0 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  mem_dirty_cacheLineRead_addr_pipe_0 = _RAND_20[12:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Level2_cache(
  input          clock,
  input          reset,
  input  [1:0]   io_axi_AWID,
  input  [31:0]  io_axi_AWADDR,
  input          io_axi_AWVALID,
  output         io_axi_AWREADY,
  input          io_axi_WVALID,
  input  [63:0]  io_axi_WDATA,
  output         io_axi_WREADY,
  input          io_axi_WLAST,
  output [1:0]   io_axi_BRESP,
  input          io_axi_BREADY,
  output         io_axi_BVALID,
  input  [1:0]   io_axi_ARID,
  input  [31:0]  io_axi_ARADDR,
  input          io_axi_ARVALID,
  output         io_axi_ARREADY,
  output [63:0]  io_axi_RDATA,
  output [1:0]   io_axi_RID,
  input          io_axi_RREADY,
  output         io_axi_RVALID,
  output [1:0]   io_axi_RRESP,
  output         io_axi_RLAST,
  output [31:0]  io_mem_axi_AWADDR,
  output         io_mem_axi_AWVALID,
  input          io_mem_axi_AWREADY,
  output [3:0]   io_mem_axi_AWCACHE,
  output [7:0]   io_mem_axi_AWLEN,
  output [2:0]   io_mem_axi_AWSIZE,
  output [1:0]   io_mem_axi_AWLOCK,
  output [2:0]   io_mem_axi_AWPROT,
  output [3:0]   io_mem_axi_AWQOS,
  output [1:0]   io_mem_axi_AWBURST,
  output [1:0]   io_mem_axi_AWID,
  output         io_mem_axi_WVALID,
  output [255:0] io_mem_axi_WDATA,
  input          io_mem_axi_WREADY,
  output [31:0]  io_mem_axi_WSTRB,
  output         io_mem_axi_WLAST,
  input  [1:0]   io_mem_axi_BRESP,
  input          io_mem_axi_BVALID,
  output         io_mem_axi_BREADY,
  output [1:0]   io_mem_axi_ARID,
  output [31:0]  io_mem_axi_ARADDR,
  output         io_mem_axi_ARVALID,
  input          io_mem_axi_ARREADY,
  output [7:0]   io_mem_axi_ARLEN,
  output [2:0]   io_mem_axi_ARSIZE,
  output [1:0]   io_mem_axi_ARBURST,
  output [1:0]   io_mem_axi_ARLOCK,
  output [3:0]   io_mem_axi_ARCACHE,
  output [2:0]   io_mem_axi_ARPROT,
  output [3:0]   io_mem_axi_ARQOS,
  input  [1:0]   io_mem_axi_RID,
  input  [255:0] io_mem_axi_RDATA,
  input  [1:0]   io_mem_axi_RRESP,
  input          io_mem_axi_RLAST,
  input          io_mem_axi_RVALID,
  output         io_mem_axi_RREADY
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [255:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [255:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [255:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [255:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [255:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [255:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [255:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [255:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [63:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [63:0] _RAND_28;
  reg [63:0] _RAND_29;
  reg [63:0] _RAND_30;
  reg [63:0] _RAND_31;
  reg [63:0] _RAND_32;
  reg [63:0] _RAND_33;
  reg [63:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [255:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [255:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [255:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [255:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [255:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [255:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [255:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [255:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [63:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [63:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [63:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [63:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [63:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [63:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [63:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [63:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
`endif // RANDOMIZE_REG_INIT
  wire  cacheMem_clock; // @[cache_phase1.scala 18:26]
  wire [31:0] cacheMem_io_addr; // @[cache_phase1.scala 18:26]
  wire [511:0] cacheMem_io_readData_0; // @[cache_phase1.scala 18:26]
  wire [511:0] cacheMem_io_readData_1; // @[cache_phase1.scala 18:26]
  wire [511:0] cacheMem_io_readData_2; // @[cache_phase1.scala 18:26]
  wire [511:0] cacheMem_io_readData_3; // @[cache_phase1.scala 18:26]
  wire [511:0] cacheMem_io_writeData_0; // @[cache_phase1.scala 18:26]
  wire [511:0] cacheMem_io_writeData_1; // @[cache_phase1.scala 18:26]
  wire [511:0] cacheMem_io_writeData_2; // @[cache_phase1.scala 18:26]
  wire [511:0] cacheMem_io_writeData_3; // @[cache_phase1.scala 18:26]
  wire  cacheMem_io_writeEnable; // @[cache_phase1.scala 18:26]
  wire  cacheMem_io_hit; // @[cache_phase1.scala 18:26]
  wire  cacheMem_io_hit_ready; // @[cache_phase1.scala 18:26]
  wire  cacheMem_io_replace_ready; // @[cache_phase1.scala 18:26]
  wire  cacheMem_io_replace; // @[cache_phase1.scala 18:26]
  wire [31:0] cacheMem_io_replace_addr; // @[cache_phase1.scala 18:26]
  wire  cacheMem_io_full_line; // @[cache_phase1.scala 18:26]
  reg [3:0] state; // @[cache_phase1.scala 25:22]
  reg [2:0] memReadBeatCounter; // @[cache_phase1.scala 28:37]
  reg [2:0] coreReadBeatCounter; // @[cache_phase1.scala 29:38]
  reg [2:0] coreDataWriteCounter; // @[cache_phase1.scala 32:39]
  reg [2:0] memDataWriteCounter; // @[cache_phase1.scala 33:38]
  reg [31:0] replace_address_Buffer_addr; // @[cache_phase1.scala 36:39]
  reg  replace_address_Buffer_valid; // @[cache_phase1.scala 36:39]
  reg [255:0] replace_data_buffer_0_data; // @[cache_phase1.scala 44:36]
  reg  replace_data_buffer_0_valid; // @[cache_phase1.scala 44:36]
  reg [255:0] replace_data_buffer_1_data; // @[cache_phase1.scala 44:36]
  reg  replace_data_buffer_1_valid; // @[cache_phase1.scala 44:36]
  reg [255:0] replace_data_buffer_2_data; // @[cache_phase1.scala 44:36]
  reg  replace_data_buffer_2_valid; // @[cache_phase1.scala 44:36]
  reg [255:0] replace_data_buffer_3_data; // @[cache_phase1.scala 44:36]
  reg  replace_data_buffer_3_valid; // @[cache_phase1.scala 44:36]
  reg [255:0] replace_data_buffer_4_data; // @[cache_phase1.scala 44:36]
  reg  replace_data_buffer_4_valid; // @[cache_phase1.scala 44:36]
  reg [255:0] replace_data_buffer_5_data; // @[cache_phase1.scala 44:36]
  reg  replace_data_buffer_5_valid; // @[cache_phase1.scala 44:36]
  reg [255:0] replace_data_buffer_6_data; // @[cache_phase1.scala 44:36]
  reg  replace_data_buffer_6_valid; // @[cache_phase1.scala 44:36]
  reg [255:0] replace_data_buffer_7_data; // @[cache_phase1.scala 44:36]
  reg  replace_data_buffer_7_valid; // @[cache_phase1.scala 44:36]
  reg [1:0] inputReadAddrBuffer_id; // @[cache_phase1.scala 54:38]
  reg [31:0] inputReadAddrBuffer_addr; // @[cache_phase1.scala 54:38]
  reg  inputReadAddrBuffer_valid; // @[cache_phase1.scala 54:38]
  reg [63:0] inputDataBuffer_0_data; // @[cache_phase1.scala 79:32]
  reg  inputDataBuffer_0_valid; // @[cache_phase1.scala 79:32]
  reg [63:0] inputDataBuffer_1_data; // @[cache_phase1.scala 79:32]
  reg [63:0] inputDataBuffer_2_data; // @[cache_phase1.scala 79:32]
  reg [63:0] inputDataBuffer_3_data; // @[cache_phase1.scala 79:32]
  reg [63:0] inputDataBuffer_4_data; // @[cache_phase1.scala 79:32]
  reg [63:0] inputDataBuffer_5_data; // @[cache_phase1.scala 79:32]
  reg [63:0] inputDataBuffer_6_data; // @[cache_phase1.scala 79:32]
  reg [63:0] inputDataBuffer_7_data; // @[cache_phase1.scala 79:32]
  reg [1:0] memDataReadAddressBuffer_id; // @[cache_phase1.scala 90:41]
  reg [31:0] memDataReadAddressBuffer_addr; // @[cache_phase1.scala 90:41]
  reg  memDataReadAddressBuffer_addr_valid; // @[cache_phase1.scala 90:41]
  reg [255:0] memDataReadBuffer_0_data; // @[cache_phase1.scala 115:34]
  reg  memDataReadBuffer_0_valid; // @[cache_phase1.scala 115:34]
  reg [255:0] memDataReadBuffer_1_data; // @[cache_phase1.scala 115:34]
  reg  memDataReadBuffer_1_valid; // @[cache_phase1.scala 115:34]
  reg [255:0] memDataReadBuffer_2_data; // @[cache_phase1.scala 115:34]
  reg  memDataReadBuffer_2_valid; // @[cache_phase1.scala 115:34]
  reg [255:0] memDataReadBuffer_3_data; // @[cache_phase1.scala 115:34]
  reg  memDataReadBuffer_3_valid; // @[cache_phase1.scala 115:34]
  reg [255:0] memDataReadBuffer_4_data; // @[cache_phase1.scala 115:34]
  reg  memDataReadBuffer_4_valid; // @[cache_phase1.scala 115:34]
  reg [255:0] memDataReadBuffer_5_data; // @[cache_phase1.scala 115:34]
  reg  memDataReadBuffer_5_valid; // @[cache_phase1.scala 115:34]
  reg [255:0] memDataReadBuffer_6_data; // @[cache_phase1.scala 115:34]
  reg  memDataReadBuffer_6_valid; // @[cache_phase1.scala 115:34]
  reg [255:0] memDataReadBuffer_7_data; // @[cache_phase1.scala 115:34]
  reg  memDataReadBuffer_7_valid; // @[cache_phase1.scala 115:34]
  reg [1:0] memDataReadBufferID; // @[cache_phase1.scala 125:36]
  reg [1:0] B_data; // @[cache_phase1.scala 128:24]
  reg [63:0] DataReadBuffer_0_data; // @[cache_phase1.scala 131:31]
  reg  DataReadBuffer_0_valid; // @[cache_phase1.scala 131:31]
  reg [63:0] DataReadBuffer_1_data; // @[cache_phase1.scala 131:31]
  reg  DataReadBuffer_1_valid; // @[cache_phase1.scala 131:31]
  reg [63:0] DataReadBuffer_2_data; // @[cache_phase1.scala 131:31]
  reg  DataReadBuffer_2_valid; // @[cache_phase1.scala 131:31]
  reg [63:0] DataReadBuffer_3_data; // @[cache_phase1.scala 131:31]
  reg  DataReadBuffer_3_valid; // @[cache_phase1.scala 131:31]
  reg [63:0] DataReadBuffer_4_data; // @[cache_phase1.scala 131:31]
  reg  DataReadBuffer_4_valid; // @[cache_phase1.scala 131:31]
  reg [63:0] DataReadBuffer_5_data; // @[cache_phase1.scala 131:31]
  reg  DataReadBuffer_5_valid; // @[cache_phase1.scala 131:31]
  reg [63:0] DataReadBuffer_6_data; // @[cache_phase1.scala 131:31]
  reg  DataReadBuffer_6_valid; // @[cache_phase1.scala 131:31]
  reg [63:0] DataReadBuffer_7_data; // @[cache_phase1.scala 131:31]
  reg  DataReadBuffer_7_valid; // @[cache_phase1.scala 131:31]
  wire [1:0] offset = inputReadAddrBuffer_addr[7:6]; // @[cache_phase1.scala 141:42]
  wire [511:0] _GEN_8 = cacheMem_io_readData_0; // @[cache_phase1.scala 182:{75,75}]
  wire [511:0] _GEN_9 = 2'h1 == offset ? cacheMem_io_readData_1 : _GEN_8; // @[cache_phase1.scala 182:{75,75}]
  wire [511:0] _GEN_10 = 2'h2 == offset ? cacheMem_io_readData_2 : _GEN_9; // @[cache_phase1.scala 182:{75,75}]
  wire [511:0] _GEN_11 = 2'h3 == offset ? cacheMem_io_readData_3 : _GEN_10; // @[cache_phase1.scala 182:{75,75}]
  wire [63:0] _GEN_12 = cacheMem_io_hit ? _GEN_11[511:448] : DataReadBuffer_0_data; // @[cache_phase1.scala 131:31 179:34 182:44]
  wire  _GEN_13 = cacheMem_io_hit | DataReadBuffer_0_valid; // @[cache_phase1.scala 131:31 179:34 183:45]
  wire [63:0] _GEN_15 = cacheMem_io_hit ? _GEN_11[447:384] : DataReadBuffer_1_data; // @[cache_phase1.scala 131:31 179:34 182:44]
  wire  _GEN_16 = cacheMem_io_hit | DataReadBuffer_1_valid; // @[cache_phase1.scala 131:31 179:34 183:45]
  wire [63:0] _GEN_18 = cacheMem_io_hit ? _GEN_11[383:320] : DataReadBuffer_2_data; // @[cache_phase1.scala 131:31 179:34 182:44]
  wire  _GEN_19 = cacheMem_io_hit | DataReadBuffer_2_valid; // @[cache_phase1.scala 131:31 179:34 183:45]
  wire [63:0] _GEN_21 = cacheMem_io_hit ? _GEN_11[319:256] : DataReadBuffer_3_data; // @[cache_phase1.scala 131:31 179:34 182:44]
  wire  _GEN_22 = cacheMem_io_hit | DataReadBuffer_3_valid; // @[cache_phase1.scala 131:31 179:34 183:45]
  wire [63:0] _GEN_24 = cacheMem_io_hit ? _GEN_11[255:192] : DataReadBuffer_4_data; // @[cache_phase1.scala 131:31 179:34 182:44]
  wire  _GEN_25 = cacheMem_io_hit | DataReadBuffer_4_valid; // @[cache_phase1.scala 131:31 179:34 183:45]
  wire [63:0] _GEN_27 = cacheMem_io_hit ? _GEN_11[191:128] : DataReadBuffer_5_data; // @[cache_phase1.scala 131:31 179:34 182:44]
  wire  _GEN_28 = cacheMem_io_hit | DataReadBuffer_5_valid; // @[cache_phase1.scala 131:31 179:34 183:45]
  wire [63:0] _GEN_30 = cacheMem_io_hit ? _GEN_11[127:64] : DataReadBuffer_6_data; // @[cache_phase1.scala 131:31 179:34 182:44]
  wire  _GEN_31 = cacheMem_io_hit | DataReadBuffer_6_valid; // @[cache_phase1.scala 131:31 179:34 183:45]
  wire [63:0] _GEN_33 = cacheMem_io_hit ? _GEN_11[63:0] : DataReadBuffer_7_data; // @[cache_phase1.scala 131:31 179:34 182:44]
  wire  _GEN_34 = cacheMem_io_hit | DataReadBuffer_7_valid; // @[cache_phase1.scala 131:31 179:34 183:45]
  wire [3:0] _GEN_36 = cacheMem_io_hit ? 4'h3 : state; // @[cache_phase1.scala 179:34 186:27 25:22]
  wire  _GEN_39 = cacheMem_io_replace | replace_data_buffer_0_valid; // @[cache_phase1.scala 189:38 193:52 44:36]
  wire  _GEN_40 = cacheMem_io_replace | replace_data_buffer_1_valid; // @[cache_phase1.scala 189:38 194:54 44:36]
  wire  _GEN_43 = cacheMem_io_replace | replace_data_buffer_2_valid; // @[cache_phase1.scala 189:38 193:52 44:36]
  wire  _GEN_44 = cacheMem_io_replace | replace_data_buffer_3_valid; // @[cache_phase1.scala 189:38 194:54 44:36]
  wire  _GEN_47 = cacheMem_io_replace | replace_data_buffer_4_valid; // @[cache_phase1.scala 189:38 193:52 44:36]
  wire  _GEN_48 = cacheMem_io_replace | replace_data_buffer_5_valid; // @[cache_phase1.scala 189:38 194:54 44:36]
  wire  _GEN_51 = cacheMem_io_replace | replace_data_buffer_6_valid; // @[cache_phase1.scala 189:38 193:52 44:36]
  wire  _GEN_52 = cacheMem_io_replace | replace_data_buffer_7_valid; // @[cache_phase1.scala 189:38 194:54 44:36]
  wire  _GEN_53 = cacheMem_io_replace | replace_address_Buffer_valid; // @[cache_phase1.scala 189:38 197:45 36:39]
  wire [255:0] _GEN_56 = 3'h0 == memReadBeatCounter ? io_mem_axi_RDATA : memDataReadBuffer_0_data; // @[cache_phase1.scala 115:34 208:{59,59}]
  wire [255:0] _GEN_57 = 3'h1 == memReadBeatCounter ? io_mem_axi_RDATA : memDataReadBuffer_1_data; // @[cache_phase1.scala 115:34 208:{59,59}]
  wire [255:0] _GEN_58 = 3'h2 == memReadBeatCounter ? io_mem_axi_RDATA : memDataReadBuffer_2_data; // @[cache_phase1.scala 115:34 208:{59,59}]
  wire [255:0] _GEN_59 = 3'h3 == memReadBeatCounter ? io_mem_axi_RDATA : memDataReadBuffer_3_data; // @[cache_phase1.scala 115:34 208:{59,59}]
  wire [255:0] _GEN_60 = 3'h4 == memReadBeatCounter ? io_mem_axi_RDATA : memDataReadBuffer_4_data; // @[cache_phase1.scala 115:34 208:{59,59}]
  wire [255:0] _GEN_61 = 3'h5 == memReadBeatCounter ? io_mem_axi_RDATA : memDataReadBuffer_5_data; // @[cache_phase1.scala 115:34 208:{59,59}]
  wire [255:0] _GEN_62 = 3'h6 == memReadBeatCounter ? io_mem_axi_RDATA : memDataReadBuffer_6_data; // @[cache_phase1.scala 115:34 208:{59,59}]
  wire [255:0] _GEN_63 = 3'h7 == memReadBeatCounter ? io_mem_axi_RDATA : memDataReadBuffer_7_data; // @[cache_phase1.scala 115:34 208:{59,59}]
  wire  _GEN_64 = 3'h0 == memReadBeatCounter ? io_mem_axi_RVALID : memDataReadBuffer_0_valid; // @[cache_phase1.scala 115:34 209:{60,60}]
  wire  _GEN_65 = 3'h1 == memReadBeatCounter ? io_mem_axi_RVALID : memDataReadBuffer_1_valid; // @[cache_phase1.scala 115:34 209:{60,60}]
  wire  _GEN_66 = 3'h2 == memReadBeatCounter ? io_mem_axi_RVALID : memDataReadBuffer_2_valid; // @[cache_phase1.scala 115:34 209:{60,60}]
  wire  _GEN_67 = 3'h3 == memReadBeatCounter ? io_mem_axi_RVALID : memDataReadBuffer_3_valid; // @[cache_phase1.scala 115:34 209:{60,60}]
  wire  _GEN_68 = 3'h4 == memReadBeatCounter ? io_mem_axi_RVALID : memDataReadBuffer_4_valid; // @[cache_phase1.scala 115:34 209:{60,60}]
  wire  _GEN_69 = 3'h5 == memReadBeatCounter ? io_mem_axi_RVALID : memDataReadBuffer_5_valid; // @[cache_phase1.scala 115:34 209:{60,60}]
  wire  _GEN_70 = 3'h6 == memReadBeatCounter ? io_mem_axi_RVALID : memDataReadBuffer_6_valid; // @[cache_phase1.scala 115:34 209:{60,60}]
  wire  _GEN_71 = 3'h7 == memReadBeatCounter ? io_mem_axi_RVALID : memDataReadBuffer_7_valid; // @[cache_phase1.scala 115:34 209:{60,60}]
  wire [2:0] _memReadBeatCounter_T_1 = memReadBeatCounter + 3'h1; // @[cache_phase1.scala 211:57]
  wire  _T_7 = ~replace_address_Buffer_valid; // @[cache_phase1.scala 216:30]
  wire [3:0] _GEN_80 = ~replace_address_Buffer_valid ? 4'h0 : 4'h5; // @[cache_phase1.scala 216:60 217:34 219:34]
  wire [3:0] _GEN_81 = inputDataBuffer_0_valid ? _GEN_80 : 4'h3; // @[cache_phase1.scala 215:51 222:30]
  wire [3:0] _GEN_82 = io_mem_axi_RLAST ? _GEN_81 : state; // @[cache_phase1.scala 214:39 25:22]
  wire [255:0] _GEN_83 = io_mem_axi_RVALID & io_mem_axi_RREADY ? _GEN_56 : memDataReadBuffer_0_data; // @[cache_phase1.scala 115:34 207:57]
  wire [255:0] _GEN_84 = io_mem_axi_RVALID & io_mem_axi_RREADY ? _GEN_57 : memDataReadBuffer_1_data; // @[cache_phase1.scala 115:34 207:57]
  wire [255:0] _GEN_85 = io_mem_axi_RVALID & io_mem_axi_RREADY ? _GEN_58 : memDataReadBuffer_2_data; // @[cache_phase1.scala 115:34 207:57]
  wire [255:0] _GEN_86 = io_mem_axi_RVALID & io_mem_axi_RREADY ? _GEN_59 : memDataReadBuffer_3_data; // @[cache_phase1.scala 115:34 207:57]
  wire [255:0] _GEN_87 = io_mem_axi_RVALID & io_mem_axi_RREADY ? _GEN_60 : memDataReadBuffer_4_data; // @[cache_phase1.scala 115:34 207:57]
  wire [255:0] _GEN_88 = io_mem_axi_RVALID & io_mem_axi_RREADY ? _GEN_61 : memDataReadBuffer_5_data; // @[cache_phase1.scala 115:34 207:57]
  wire [255:0] _GEN_89 = io_mem_axi_RVALID & io_mem_axi_RREADY ? _GEN_62 : memDataReadBuffer_6_data; // @[cache_phase1.scala 115:34 207:57]
  wire [255:0] _GEN_90 = io_mem_axi_RVALID & io_mem_axi_RREADY ? _GEN_63 : memDataReadBuffer_7_data; // @[cache_phase1.scala 115:34 207:57]
  wire  _GEN_91 = io_mem_axi_RVALID & io_mem_axi_RREADY ? _GEN_64 : memDataReadBuffer_0_valid; // @[cache_phase1.scala 115:34 207:57]
  wire  _GEN_92 = io_mem_axi_RVALID & io_mem_axi_RREADY ? _GEN_65 : memDataReadBuffer_1_valid; // @[cache_phase1.scala 115:34 207:57]
  wire  _GEN_93 = io_mem_axi_RVALID & io_mem_axi_RREADY ? _GEN_66 : memDataReadBuffer_2_valid; // @[cache_phase1.scala 115:34 207:57]
  wire  _GEN_94 = io_mem_axi_RVALID & io_mem_axi_RREADY ? _GEN_67 : memDataReadBuffer_3_valid; // @[cache_phase1.scala 115:34 207:57]
  wire  _GEN_95 = io_mem_axi_RVALID & io_mem_axi_RREADY ? _GEN_68 : memDataReadBuffer_4_valid; // @[cache_phase1.scala 115:34 207:57]
  wire  _GEN_96 = io_mem_axi_RVALID & io_mem_axi_RREADY ? _GEN_69 : memDataReadBuffer_5_valid; // @[cache_phase1.scala 115:34 207:57]
  wire  _GEN_97 = io_mem_axi_RVALID & io_mem_axi_RREADY ? _GEN_70 : memDataReadBuffer_6_valid; // @[cache_phase1.scala 115:34 207:57]
  wire  _GEN_98 = io_mem_axi_RVALID & io_mem_axi_RREADY ? _GEN_71 : memDataReadBuffer_7_valid; // @[cache_phase1.scala 115:34 207:57]
  wire [2:0] _GEN_107 = io_mem_axi_RVALID & io_mem_axi_RREADY ? _memReadBeatCounter_T_1 : memReadBeatCounter; // @[cache_phase1.scala 207:57 211:36 28:37]
  wire [1:0] _GEN_108 = io_mem_axi_RVALID & io_mem_axi_RREADY ? io_mem_axi_RID : memDataReadBufferID; // @[cache_phase1.scala 125:36 207:57 212:36]
  wire [3:0] _GEN_109 = io_mem_axi_RVALID & io_mem_axi_RREADY ? _GEN_82 : state; // @[cache_phase1.scala 207:57 25:22]
  wire [2:0] _coreReadBeatCounter_T_1 = coreReadBeatCounter + 3'h1; // @[cache_phase1.scala 233:60]
  wire  _GEN_112 = io_axi_RLAST ? 1'h0 : inputReadAddrBuffer_valid; // @[cache_phase1.scala 235:35 237:47 54:38]
  wire  _GEN_113 = io_axi_RLAST ? 1'h0 : memDataReadBuffer_0_valid; // @[cache_phase1.scala 115:34 235:35]
  wire  _GEN_114 = io_axi_RLAST ? 1'h0 : memDataReadBuffer_1_valid; // @[cache_phase1.scala 115:34 235:35]
  wire  _GEN_115 = io_axi_RLAST ? 1'h0 : memDataReadBuffer_2_valid; // @[cache_phase1.scala 115:34 235:35]
  wire  _GEN_116 = io_axi_RLAST ? 1'h0 : memDataReadBuffer_3_valid; // @[cache_phase1.scala 115:34 235:35]
  wire  _GEN_117 = io_axi_RLAST ? 1'h0 : memDataReadBuffer_4_valid; // @[cache_phase1.scala 115:34 235:35]
  wire  _GEN_118 = io_axi_RLAST ? 1'h0 : memDataReadBuffer_5_valid; // @[cache_phase1.scala 115:34 235:35]
  wire  _GEN_119 = io_axi_RLAST ? 1'h0 : memDataReadBuffer_6_valid; // @[cache_phase1.scala 115:34 235:35]
  wire  _GEN_120 = io_axi_RLAST ? 1'h0 : memDataReadBuffer_7_valid; // @[cache_phase1.scala 115:34 235:35]
  wire [3:0] _GEN_121 = io_axi_RLAST ? _GEN_80 : state; // @[cache_phase1.scala 235:35 25:22]
  wire [2:0] _GEN_122 = io_axi_RVALID & io_axi_RREADY ? _coreReadBeatCounter_T_1 : coreReadBeatCounter; // @[cache_phase1.scala 232:50 233:37 29:38]
  wire  _GEN_123 = io_axi_RVALID & io_axi_RREADY ? _GEN_112 : inputReadAddrBuffer_valid; // @[cache_phase1.scala 232:50 54:38]
  wire  _GEN_124 = io_axi_RVALID & io_axi_RREADY ? _GEN_113 : memDataReadBuffer_0_valid; // @[cache_phase1.scala 115:34 232:50]
  wire  _GEN_125 = io_axi_RVALID & io_axi_RREADY ? _GEN_114 : memDataReadBuffer_1_valid; // @[cache_phase1.scala 115:34 232:50]
  wire  _GEN_126 = io_axi_RVALID & io_axi_RREADY ? _GEN_115 : memDataReadBuffer_2_valid; // @[cache_phase1.scala 115:34 232:50]
  wire  _GEN_127 = io_axi_RVALID & io_axi_RREADY ? _GEN_116 : memDataReadBuffer_3_valid; // @[cache_phase1.scala 115:34 232:50]
  wire  _GEN_128 = io_axi_RVALID & io_axi_RREADY ? _GEN_117 : memDataReadBuffer_4_valid; // @[cache_phase1.scala 115:34 232:50]
  wire  _GEN_129 = io_axi_RVALID & io_axi_RREADY ? _GEN_118 : memDataReadBuffer_5_valid; // @[cache_phase1.scala 115:34 232:50]
  wire  _GEN_130 = io_axi_RVALID & io_axi_RREADY ? _GEN_119 : memDataReadBuffer_6_valid; // @[cache_phase1.scala 115:34 232:50]
  wire  _GEN_131 = io_axi_RVALID & io_axi_RREADY ? _GEN_120 : memDataReadBuffer_7_valid; // @[cache_phase1.scala 115:34 232:50]
  wire [3:0] _GEN_132 = io_axi_RVALID & io_axi_RREADY ? _GEN_121 : state; // @[cache_phase1.scala 232:50 25:22]
  wire [63:0] _GEN_133 = 3'h0 == coreDataWriteCounter ? io_axi_WDATA : inputDataBuffer_0_data; // @[cache_phase1.scala 252:{59,59} 79:32]
  wire [63:0] _GEN_134 = 3'h1 == coreDataWriteCounter ? io_axi_WDATA : inputDataBuffer_1_data; // @[cache_phase1.scala 252:{59,59} 79:32]
  wire [63:0] _GEN_135 = 3'h2 == coreDataWriteCounter ? io_axi_WDATA : inputDataBuffer_2_data; // @[cache_phase1.scala 252:{59,59} 79:32]
  wire [63:0] _GEN_136 = 3'h3 == coreDataWriteCounter ? io_axi_WDATA : inputDataBuffer_3_data; // @[cache_phase1.scala 252:{59,59} 79:32]
  wire [63:0] _GEN_137 = 3'h4 == coreDataWriteCounter ? io_axi_WDATA : inputDataBuffer_4_data; // @[cache_phase1.scala 252:{59,59} 79:32]
  wire [63:0] _GEN_138 = 3'h5 == coreDataWriteCounter ? io_axi_WDATA : inputDataBuffer_5_data; // @[cache_phase1.scala 252:{59,59} 79:32]
  wire [63:0] _GEN_139 = 3'h6 == coreDataWriteCounter ? io_axi_WDATA : inputDataBuffer_6_data; // @[cache_phase1.scala 252:{59,59} 79:32]
  wire [63:0] _GEN_140 = 3'h7 == coreDataWriteCounter ? io_axi_WDATA : inputDataBuffer_7_data; // @[cache_phase1.scala 252:{59,59} 79:32]
  wire  _GEN_141 = 3'h0 == coreDataWriteCounter ? io_axi_WVALID : inputDataBuffer_0_valid; // @[cache_phase1.scala 253:{61,61} 79:32]
  wire [2:0] _coreDataWriteCounter_T_1 = coreDataWriteCounter + 3'h1; // @[cache_phase1.scala 255:62]
  wire [3:0] _GEN_149 = io_axi_WLAST ? 4'h8 : state; // @[cache_phase1.scala 25:22 257:35 258:31]
  wire [63:0] _GEN_150 = io_axi_WREADY & io_axi_WVALID ? _GEN_133 : inputDataBuffer_0_data; // @[cache_phase1.scala 251:49 79:32]
  wire [63:0] _GEN_151 = io_axi_WREADY & io_axi_WVALID ? _GEN_134 : inputDataBuffer_1_data; // @[cache_phase1.scala 251:49 79:32]
  wire [63:0] _GEN_152 = io_axi_WREADY & io_axi_WVALID ? _GEN_135 : inputDataBuffer_2_data; // @[cache_phase1.scala 251:49 79:32]
  wire [63:0] _GEN_153 = io_axi_WREADY & io_axi_WVALID ? _GEN_136 : inputDataBuffer_3_data; // @[cache_phase1.scala 251:49 79:32]
  wire [63:0] _GEN_154 = io_axi_WREADY & io_axi_WVALID ? _GEN_137 : inputDataBuffer_4_data; // @[cache_phase1.scala 251:49 79:32]
  wire [63:0] _GEN_155 = io_axi_WREADY & io_axi_WVALID ? _GEN_138 : inputDataBuffer_5_data; // @[cache_phase1.scala 251:49 79:32]
  wire [63:0] _GEN_156 = io_axi_WREADY & io_axi_WVALID ? _GEN_139 : inputDataBuffer_6_data; // @[cache_phase1.scala 251:49 79:32]
  wire [63:0] _GEN_157 = io_axi_WREADY & io_axi_WVALID ? _GEN_140 : inputDataBuffer_7_data; // @[cache_phase1.scala 251:49 79:32]
  wire  _GEN_158 = io_axi_WREADY & io_axi_WVALID ? _GEN_141 : inputDataBuffer_0_valid; // @[cache_phase1.scala 251:49 79:32]
  wire [2:0] _GEN_166 = io_axi_WREADY & io_axi_WVALID ? _coreDataWriteCounter_T_1 : coreDataWriteCounter; // @[cache_phase1.scala 251:49 255:38 32:39]
  wire [3:0] _GEN_167 = io_axi_WREADY & io_axi_WVALID ? _GEN_149 : state; // @[cache_phase1.scala 25:22 251:49]
  wire [3:0] _GEN_168 = io_mem_axi_AWREADY & io_mem_axi_AWVALID ? 4'h6 : state; // @[cache_phase1.scala 25:22 267:59 268:23]
  wire [2:0] _memDataWriteCounter_T_1 = memDataWriteCounter + 3'h1; // @[cache_phase1.scala 274:60]
  wire [3:0] _GEN_169 = io_mem_axi_WLAST ? 4'h7 : state; // @[cache_phase1.scala 25:22 276:39 277:27]
  wire [2:0] _GEN_170 = io_mem_axi_WREADY & io_mem_axi_WVALID ? _memDataWriteCounter_T_1 : memDataWriteCounter; // @[cache_phase1.scala 273:57 274:37 33:38]
  wire [3:0] _GEN_171 = io_mem_axi_WREADY & io_mem_axi_WVALID ? _GEN_169 : state; // @[cache_phase1.scala 25:22 273:57]
  wire [1:0] _GEN_172 = io_mem_axi_BREADY & io_mem_axi_BVALID ? io_mem_axi_BRESP : B_data; // @[cache_phase1.scala 128:24 283:57 284:24]
  wire [3:0] _GEN_173 = io_mem_axi_BREADY & io_mem_axi_BVALID ? 4'h0 : state; // @[cache_phase1.scala 25:22 283:57 285:23]
  wire  _GEN_174 = io_mem_axi_BREADY & io_mem_axi_BVALID ? 1'h0 : replace_address_Buffer_valid; // @[cache_phase1.scala 283:57 286:45 36:39]
  wire  _GEN_175 = io_mem_axi_BREADY & io_mem_axi_BVALID ? 1'h0 : replace_data_buffer_0_valid; // @[cache_phase1.scala 283:57 287:53 44:36]
  wire  _GEN_176 = io_mem_axi_BREADY & io_mem_axi_BVALID ? 1'h0 : replace_data_buffer_1_valid; // @[cache_phase1.scala 283:57 287:53 44:36]
  wire  _GEN_177 = io_mem_axi_BREADY & io_mem_axi_BVALID ? 1'h0 : replace_data_buffer_2_valid; // @[cache_phase1.scala 283:57 287:53 44:36]
  wire  _GEN_178 = io_mem_axi_BREADY & io_mem_axi_BVALID ? 1'h0 : replace_data_buffer_3_valid; // @[cache_phase1.scala 283:57 287:53 44:36]
  wire  _GEN_179 = io_mem_axi_BREADY & io_mem_axi_BVALID ? 1'h0 : replace_data_buffer_4_valid; // @[cache_phase1.scala 283:57 287:53 44:36]
  wire  _GEN_180 = io_mem_axi_BREADY & io_mem_axi_BVALID ? 1'h0 : replace_data_buffer_5_valid; // @[cache_phase1.scala 283:57 287:53 44:36]
  wire  _GEN_181 = io_mem_axi_BREADY & io_mem_axi_BVALID ? 1'h0 : replace_data_buffer_6_valid; // @[cache_phase1.scala 283:57 287:53 44:36]
  wire  _GEN_182 = io_mem_axi_BREADY & io_mem_axi_BVALID ? 1'h0 : replace_data_buffer_7_valid; // @[cache_phase1.scala 283:57 287:53 44:36]
  wire [1:0] _GEN_183 = cacheMem_io_hit ? 2'h0 : B_data; // @[cache_phase1.scala 128:24 294:38 295:31]
  wire [3:0] _GEN_184 = cacheMem_io_hit ? 4'h0 : 4'h1; // @[cache_phase1.scala 294:38 296:31 298:31]
  wire [1:0] _GEN_185 = io_axi_BREADY & io_axi_BVALID ? _GEN_183 : B_data; // @[cache_phase1.scala 128:24 293:49]
  wire [3:0] _GEN_186 = io_axi_BREADY & io_axi_BVALID ? _GEN_184 : state; // @[cache_phase1.scala 25:22 293:49]
  wire [1:0] _GEN_187 = 4'h8 == state ? _GEN_185 : B_data; // @[cache_phase1.scala 145:18 128:24]
  wire [3:0] _GEN_188 = 4'h8 == state ? _GEN_186 : state; // @[cache_phase1.scala 145:18 25:22]
  wire [1:0] _GEN_189 = 4'h7 == state ? _GEN_172 : _GEN_187; // @[cache_phase1.scala 145:18]
  wire [3:0] _GEN_190 = 4'h7 == state ? _GEN_173 : _GEN_188; // @[cache_phase1.scala 145:18]
  wire  _GEN_191 = 4'h7 == state ? _GEN_174 : replace_address_Buffer_valid; // @[cache_phase1.scala 145:18 36:39]
  wire  _GEN_192 = 4'h7 == state ? _GEN_175 : replace_data_buffer_0_valid; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_193 = 4'h7 == state ? _GEN_176 : replace_data_buffer_1_valid; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_194 = 4'h7 == state ? _GEN_177 : replace_data_buffer_2_valid; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_195 = 4'h7 == state ? _GEN_178 : replace_data_buffer_3_valid; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_196 = 4'h7 == state ? _GEN_179 : replace_data_buffer_4_valid; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_197 = 4'h7 == state ? _GEN_180 : replace_data_buffer_5_valid; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_198 = 4'h7 == state ? _GEN_181 : replace_data_buffer_6_valid; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_199 = 4'h7 == state ? _GEN_182 : replace_data_buffer_7_valid; // @[cache_phase1.scala 145:18 44:36]
  wire [2:0] _GEN_200 = 4'h6 == state ? _GEN_170 : memDataWriteCounter; // @[cache_phase1.scala 145:18 33:38]
  wire [3:0] _GEN_201 = 4'h6 == state ? _GEN_171 : _GEN_190; // @[cache_phase1.scala 145:18]
  wire [1:0] _GEN_202 = 4'h6 == state ? B_data : _GEN_189; // @[cache_phase1.scala 145:18 128:24]
  wire  _GEN_203 = 4'h6 == state ? replace_address_Buffer_valid : _GEN_191; // @[cache_phase1.scala 145:18 36:39]
  wire  _GEN_204 = 4'h6 == state ? replace_data_buffer_0_valid : _GEN_192; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_205 = 4'h6 == state ? replace_data_buffer_1_valid : _GEN_193; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_206 = 4'h6 == state ? replace_data_buffer_2_valid : _GEN_194; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_207 = 4'h6 == state ? replace_data_buffer_3_valid : _GEN_195; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_208 = 4'h6 == state ? replace_data_buffer_4_valid : _GEN_196; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_209 = 4'h6 == state ? replace_data_buffer_5_valid : _GEN_197; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_210 = 4'h6 == state ? replace_data_buffer_6_valid : _GEN_198; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_211 = 4'h6 == state ? replace_data_buffer_7_valid : _GEN_199; // @[cache_phase1.scala 145:18 44:36]
  wire [3:0] _GEN_212 = 4'h5 == state ? _GEN_168 : _GEN_201; // @[cache_phase1.scala 145:18]
  wire [2:0] _GEN_213 = 4'h5 == state ? memDataWriteCounter : _GEN_200; // @[cache_phase1.scala 145:18 33:38]
  wire [1:0] _GEN_214 = 4'h5 == state ? B_data : _GEN_202; // @[cache_phase1.scala 145:18 128:24]
  wire  _GEN_215 = 4'h5 == state ? replace_address_Buffer_valid : _GEN_203; // @[cache_phase1.scala 145:18 36:39]
  wire  _GEN_216 = 4'h5 == state ? replace_data_buffer_0_valid : _GEN_204; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_217 = 4'h5 == state ? replace_data_buffer_1_valid : _GEN_205; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_218 = 4'h5 == state ? replace_data_buffer_2_valid : _GEN_206; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_219 = 4'h5 == state ? replace_data_buffer_3_valid : _GEN_207; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_220 = 4'h5 == state ? replace_data_buffer_4_valid : _GEN_208; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_221 = 4'h5 == state ? replace_data_buffer_5_valid : _GEN_209; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_222 = 4'h5 == state ? replace_data_buffer_6_valid : _GEN_210; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_223 = 4'h5 == state ? replace_data_buffer_7_valid : _GEN_211; // @[cache_phase1.scala 145:18 44:36]
  wire [63:0] _GEN_224 = 4'h4 == state ? _GEN_150 : inputDataBuffer_0_data; // @[cache_phase1.scala 145:18 79:32]
  wire [63:0] _GEN_225 = 4'h4 == state ? _GEN_151 : inputDataBuffer_1_data; // @[cache_phase1.scala 145:18 79:32]
  wire [63:0] _GEN_226 = 4'h4 == state ? _GEN_152 : inputDataBuffer_2_data; // @[cache_phase1.scala 145:18 79:32]
  wire [63:0] _GEN_227 = 4'h4 == state ? _GEN_153 : inputDataBuffer_3_data; // @[cache_phase1.scala 145:18 79:32]
  wire [63:0] _GEN_228 = 4'h4 == state ? _GEN_154 : inputDataBuffer_4_data; // @[cache_phase1.scala 145:18 79:32]
  wire [63:0] _GEN_229 = 4'h4 == state ? _GEN_155 : inputDataBuffer_5_data; // @[cache_phase1.scala 145:18 79:32]
  wire [63:0] _GEN_230 = 4'h4 == state ? _GEN_156 : inputDataBuffer_6_data; // @[cache_phase1.scala 145:18 79:32]
  wire [63:0] _GEN_231 = 4'h4 == state ? _GEN_157 : inputDataBuffer_7_data; // @[cache_phase1.scala 145:18 79:32]
  wire  _GEN_232 = 4'h4 == state ? _GEN_158 : inputDataBuffer_0_valid; // @[cache_phase1.scala 145:18 79:32]
  wire [2:0] _GEN_240 = 4'h4 == state ? _GEN_166 : coreDataWriteCounter; // @[cache_phase1.scala 145:18 32:39]
  wire [3:0] _GEN_241 = 4'h4 == state ? _GEN_167 : _GEN_212; // @[cache_phase1.scala 145:18]
  wire [2:0] _GEN_242 = 4'h4 == state ? memDataWriteCounter : _GEN_213; // @[cache_phase1.scala 145:18 33:38]
  wire [1:0] _GEN_243 = 4'h4 == state ? B_data : _GEN_214; // @[cache_phase1.scala 145:18 128:24]
  wire  _GEN_244 = 4'h4 == state ? replace_address_Buffer_valid : _GEN_215; // @[cache_phase1.scala 145:18 36:39]
  wire  _GEN_245 = 4'h4 == state ? replace_data_buffer_0_valid : _GEN_216; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_246 = 4'h4 == state ? replace_data_buffer_1_valid : _GEN_217; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_247 = 4'h4 == state ? replace_data_buffer_2_valid : _GEN_218; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_248 = 4'h4 == state ? replace_data_buffer_3_valid : _GEN_219; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_249 = 4'h4 == state ? replace_data_buffer_4_valid : _GEN_220; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_250 = 4'h4 == state ? replace_data_buffer_5_valid : _GEN_221; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_251 = 4'h4 == state ? replace_data_buffer_6_valid : _GEN_222; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_252 = 4'h4 == state ? replace_data_buffer_7_valid : _GEN_223; // @[cache_phase1.scala 145:18 44:36]
  wire [2:0] _GEN_253 = 4'h3 == state ? _GEN_122 : coreReadBeatCounter; // @[cache_phase1.scala 145:18 29:38]
  wire  _GEN_254 = 4'h3 == state ? _GEN_123 : inputReadAddrBuffer_valid; // @[cache_phase1.scala 145:18 54:38]
  wire  _GEN_255 = 4'h3 == state ? _GEN_124 : memDataReadBuffer_0_valid; // @[cache_phase1.scala 145:18 115:34]
  wire  _GEN_256 = 4'h3 == state ? _GEN_125 : memDataReadBuffer_1_valid; // @[cache_phase1.scala 145:18 115:34]
  wire  _GEN_257 = 4'h3 == state ? _GEN_126 : memDataReadBuffer_2_valid; // @[cache_phase1.scala 145:18 115:34]
  wire  _GEN_258 = 4'h3 == state ? _GEN_127 : memDataReadBuffer_3_valid; // @[cache_phase1.scala 145:18 115:34]
  wire  _GEN_259 = 4'h3 == state ? _GEN_128 : memDataReadBuffer_4_valid; // @[cache_phase1.scala 145:18 115:34]
  wire  _GEN_260 = 4'h3 == state ? _GEN_129 : memDataReadBuffer_5_valid; // @[cache_phase1.scala 145:18 115:34]
  wire  _GEN_261 = 4'h3 == state ? _GEN_130 : memDataReadBuffer_6_valid; // @[cache_phase1.scala 145:18 115:34]
  wire  _GEN_262 = 4'h3 == state ? _GEN_131 : memDataReadBuffer_7_valid; // @[cache_phase1.scala 145:18 115:34]
  wire [3:0] _GEN_263 = 4'h3 == state ? _GEN_132 : _GEN_241; // @[cache_phase1.scala 145:18]
  wire [63:0] _GEN_264 = 4'h3 == state ? inputDataBuffer_0_data : _GEN_224; // @[cache_phase1.scala 145:18 79:32]
  wire [63:0] _GEN_265 = 4'h3 == state ? inputDataBuffer_1_data : _GEN_225; // @[cache_phase1.scala 145:18 79:32]
  wire [63:0] _GEN_266 = 4'h3 == state ? inputDataBuffer_2_data : _GEN_226; // @[cache_phase1.scala 145:18 79:32]
  wire [63:0] _GEN_267 = 4'h3 == state ? inputDataBuffer_3_data : _GEN_227; // @[cache_phase1.scala 145:18 79:32]
  wire [63:0] _GEN_268 = 4'h3 == state ? inputDataBuffer_4_data : _GEN_228; // @[cache_phase1.scala 145:18 79:32]
  wire [63:0] _GEN_269 = 4'h3 == state ? inputDataBuffer_5_data : _GEN_229; // @[cache_phase1.scala 145:18 79:32]
  wire [63:0] _GEN_270 = 4'h3 == state ? inputDataBuffer_6_data : _GEN_230; // @[cache_phase1.scala 145:18 79:32]
  wire [63:0] _GEN_271 = 4'h3 == state ? inputDataBuffer_7_data : _GEN_231; // @[cache_phase1.scala 145:18 79:32]
  wire  _GEN_272 = 4'h3 == state ? inputDataBuffer_0_valid : _GEN_232; // @[cache_phase1.scala 145:18 79:32]
  wire [2:0] _GEN_280 = 4'h3 == state ? coreDataWriteCounter : _GEN_240; // @[cache_phase1.scala 145:18 32:39]
  wire [2:0] _GEN_281 = 4'h3 == state ? memDataWriteCounter : _GEN_242; // @[cache_phase1.scala 145:18 33:38]
  wire [1:0] _GEN_282 = 4'h3 == state ? B_data : _GEN_243; // @[cache_phase1.scala 145:18 128:24]
  wire  _GEN_283 = 4'h3 == state ? replace_address_Buffer_valid : _GEN_244; // @[cache_phase1.scala 145:18 36:39]
  wire  _GEN_284 = 4'h3 == state ? replace_data_buffer_0_valid : _GEN_245; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_285 = 4'h3 == state ? replace_data_buffer_1_valid : _GEN_246; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_286 = 4'h3 == state ? replace_data_buffer_2_valid : _GEN_247; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_287 = 4'h3 == state ? replace_data_buffer_3_valid : _GEN_248; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_288 = 4'h3 == state ? replace_data_buffer_4_valid : _GEN_249; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_289 = 4'h3 == state ? replace_data_buffer_5_valid : _GEN_250; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_290 = 4'h3 == state ? replace_data_buffer_6_valid : _GEN_251; // @[cache_phase1.scala 145:18 44:36]
  wire  _GEN_291 = 4'h3 == state ? replace_data_buffer_7_valid : _GEN_252; // @[cache_phase1.scala 145:18 44:36]
  wire  _io_mem_axi_ARVALID_T = state == 4'h1; // @[cache_phase1.scala 310:33]
  wire [63:0] _GEN_532 = 3'h1 == coreReadBeatCounter ? DataReadBuffer_1_data : DataReadBuffer_0_data; // @[cache_phase1.scala 322:{18,18}]
  wire [63:0] _GEN_533 = 3'h2 == coreReadBeatCounter ? DataReadBuffer_2_data : _GEN_532; // @[cache_phase1.scala 322:{18,18}]
  wire [63:0] _GEN_534 = 3'h3 == coreReadBeatCounter ? DataReadBuffer_3_data : _GEN_533; // @[cache_phase1.scala 322:{18,18}]
  wire [63:0] _GEN_535 = 3'h4 == coreReadBeatCounter ? DataReadBuffer_4_data : _GEN_534; // @[cache_phase1.scala 322:{18,18}]
  wire [63:0] _GEN_536 = 3'h5 == coreReadBeatCounter ? DataReadBuffer_5_data : _GEN_535; // @[cache_phase1.scala 322:{18,18}]
  wire [63:0] _GEN_537 = 3'h6 == coreReadBeatCounter ? DataReadBuffer_6_data : _GEN_536; // @[cache_phase1.scala 322:{18,18}]
  wire  _io_axi_RVALID_T = state == 4'h3; // @[cache_phase1.scala 324:28]
  wire  _GEN_540 = 3'h1 == coreReadBeatCounter ? DataReadBuffer_1_valid : DataReadBuffer_0_valid; // @[cache_phase1.scala 324:{40,40}]
  wire  _GEN_541 = 3'h2 == coreReadBeatCounter ? DataReadBuffer_2_valid : _GEN_540; // @[cache_phase1.scala 324:{40,40}]
  wire  _GEN_542 = 3'h3 == coreReadBeatCounter ? DataReadBuffer_3_valid : _GEN_541; // @[cache_phase1.scala 324:{40,40}]
  wire  _GEN_543 = 3'h4 == coreReadBeatCounter ? DataReadBuffer_4_valid : _GEN_542; // @[cache_phase1.scala 324:{40,40}]
  wire  _GEN_544 = 3'h5 == coreReadBeatCounter ? DataReadBuffer_5_valid : _GEN_543; // @[cache_phase1.scala 324:{40,40}]
  wire  _GEN_545 = 3'h6 == coreReadBeatCounter ? DataReadBuffer_6_valid : _GEN_544; // @[cache_phase1.scala 324:{40,40}]
  wire  _GEN_546 = 3'h7 == coreReadBeatCounter ? DataReadBuffer_7_valid : _GEN_545; // @[cache_phase1.scala 324:{40,40}]
  wire [7:0] _GEN_743 = {{5'd0}, coreReadBeatCounter}; // @[cache_phase1.scala 326:41]
  wire [255:0] _GEN_556 = 3'h1 == memDataWriteCounter ? replace_data_buffer_1_data : replace_data_buffer_0_data; // @[cache_phase1.scala 334:{21,21}]
  wire [255:0] _GEN_557 = 3'h2 == memDataWriteCounter ? replace_data_buffer_2_data : _GEN_556; // @[cache_phase1.scala 334:{21,21}]
  wire [255:0] _GEN_558 = 3'h3 == memDataWriteCounter ? replace_data_buffer_3_data : _GEN_557; // @[cache_phase1.scala 334:{21,21}]
  wire [255:0] _GEN_559 = 3'h4 == memDataWriteCounter ? replace_data_buffer_4_data : _GEN_558; // @[cache_phase1.scala 334:{21,21}]
  wire [255:0] _GEN_560 = 3'h5 == memDataWriteCounter ? replace_data_buffer_5_data : _GEN_559; // @[cache_phase1.scala 334:{21,21}]
  wire [255:0] _GEN_561 = 3'h6 == memDataWriteCounter ? replace_data_buffer_6_data : _GEN_560; // @[cache_phase1.scala 334:{21,21}]
  wire  _GEN_564 = 3'h1 == memDataWriteCounter ? replace_data_buffer_1_valid : replace_data_buffer_0_valid; // @[cache_phase1.scala 335:{43,43}]
  wire  _GEN_565 = 3'h2 == memDataWriteCounter ? replace_data_buffer_2_valid : _GEN_564; // @[cache_phase1.scala 335:{43,43}]
  wire  _GEN_566 = 3'h3 == memDataWriteCounter ? replace_data_buffer_3_valid : _GEN_565; // @[cache_phase1.scala 335:{43,43}]
  wire  _GEN_567 = 3'h4 == memDataWriteCounter ? replace_data_buffer_4_valid : _GEN_566; // @[cache_phase1.scala 335:{43,43}]
  wire  _GEN_568 = 3'h5 == memDataWriteCounter ? replace_data_buffer_5_valid : _GEN_567; // @[cache_phase1.scala 335:{43,43}]
  wire  _GEN_569 = 3'h6 == memDataWriteCounter ? replace_data_buffer_6_valid : _GEN_568; // @[cache_phase1.scala 335:{43,43}]
  wire  _GEN_570 = 3'h7 == memDataWriteCounter ? replace_data_buffer_7_valid : _GEN_569; // @[cache_phase1.scala 335:{43,43}]
  wire [7:0] _GEN_744 = {{5'd0}, memDataWriteCounter}; // @[cache_phase1.scala 337:44]
  wire  _io_axi_BVALID_T = state == 4'h8; // @[cache_phase1.scala 354:28]
  reg  delay_RLAST; // @[cache_phase1.scala 377:30]
  reg  delay_WLAST; // @[cache_phase1.scala 378:30]
  wire [511:0] _temp_T = {inputDataBuffer_0_data,inputDataBuffer_1_data,inputDataBuffer_2_data,inputDataBuffer_3_data,
    inputDataBuffer_4_data,inputDataBuffer_5_data,inputDataBuffer_6_data,inputDataBuffer_7_data}; // @[Cat.scala 33:92]
  wire [511:0] temp_0 = 2'h0 == offset ? _temp_T : cacheMem_io_readData_0; // @[cache_phase1.scala 388:10 390:{18,18}]
  wire [511:0] temp_1 = 2'h1 == offset ? _temp_T : cacheMem_io_readData_1; // @[cache_phase1.scala 388:10 390:{18,18}]
  wire [511:0] temp_2 = 2'h2 == offset ? _temp_T : cacheMem_io_readData_2; // @[cache_phase1.scala 388:10 390:{18,18}]
  wire [511:0] temp_3 = 2'h3 == offset ? _temp_T : cacheMem_io_readData_3; // @[cache_phase1.scala 388:10 390:{18,18}]
  wire [511:0] _data_wire_0_T_2 = {memDataReadBuffer_0_data,memDataReadBuffer_1_data}; // @[Cat.scala 33:92]
  wire  data_wire_valid_0 = memDataReadBuffer_0_valid & memDataReadBuffer_1_valid; // @[cache_phase1.scala 408:75]
  wire [511:0] _data_wire_1_T_2 = {memDataReadBuffer_2_data,memDataReadBuffer_3_data}; // @[Cat.scala 33:92]
  wire  data_wire_valid_1 = memDataReadBuffer_2_valid & memDataReadBuffer_3_valid; // @[cache_phase1.scala 408:75]
  wire [511:0] _data_wire_2_T_2 = {memDataReadBuffer_4_data,memDataReadBuffer_5_data}; // @[Cat.scala 33:92]
  wire  data_wire_valid_2 = memDataReadBuffer_4_valid & memDataReadBuffer_5_valid; // @[cache_phase1.scala 408:75]
  wire [511:0] _data_wire_3_T_2 = {memDataReadBuffer_6_data,memDataReadBuffer_7_data}; // @[Cat.scala 33:92]
  wire  data_wire_valid_3 = memDataReadBuffer_6_valid & memDataReadBuffer_7_valid; // @[cache_phase1.scala 408:75]
  wire [511:0] _GEN_703 = 2'h0 == offset ? _temp_T : _data_wire_0_T_2; // @[cache_phase1.scala 407:22 414:{27,27}]
  wire [511:0] _GEN_704 = 2'h1 == offset ? _temp_T : _data_wire_1_T_2; // @[cache_phase1.scala 407:22 414:{27,27}]
  wire [511:0] _GEN_705 = 2'h2 == offset ? _temp_T : _data_wire_2_T_2; // @[cache_phase1.scala 407:22 414:{27,27}]
  wire [511:0] _GEN_706 = 2'h3 == offset ? _temp_T : _data_wire_3_T_2; // @[cache_phase1.scala 407:22 414:{27,27}]
  wire [511:0] data_wire_0 = inputDataBuffer_0_valid ? _GEN_703 : _data_wire_0_T_2; // @[cache_phase1.scala 407:22 412:35]
  wire [511:0] data_wire_1 = inputDataBuffer_0_valid ? _GEN_704 : _data_wire_1_T_2; // @[cache_phase1.scala 407:22 412:35]
  wire [511:0] data_wire_2 = inputDataBuffer_0_valid ? _GEN_705 : _data_wire_2_T_2; // @[cache_phase1.scala 407:22 412:35]
  wire [511:0] data_wire_3 = inputDataBuffer_0_valid ? _GEN_706 : _data_wire_3_T_2; // @[cache_phase1.scala 407:22 412:35]
  wire  _GEN_712 = 2'h1 == offset ? data_wire_valid_1 : data_wire_valid_0; // @[cache_phase1.scala 428:{34,34}]
  wire  _GEN_713 = 2'h2 == offset ? data_wire_valid_2 : _GEN_712; // @[cache_phase1.scala 428:{34,34}]
  wire  _GEN_714 = 2'h3 == offset ? data_wire_valid_3 : _GEN_713; // @[cache_phase1.scala 428:{34,34}]
  wire [511:0] _GEN_716 = 2'h1 == offset ? data_wire_1 : data_wire_0; // @[cache_phase1.scala 430:{56,56}]
  wire [511:0] _GEN_717 = 2'h2 == offset ? data_wire_2 : _GEN_716; // @[cache_phase1.scala 430:{56,56}]
  wire [511:0] _GEN_718 = 2'h3 == offset ? data_wire_3 : _GEN_717; // @[cache_phase1.scala 430:{56,56}]
  Memory cacheMem ( // @[cache_phase1.scala 18:26]
    .clock(cacheMem_clock),
    .io_addr(cacheMem_io_addr),
    .io_readData_0(cacheMem_io_readData_0),
    .io_readData_1(cacheMem_io_readData_1),
    .io_readData_2(cacheMem_io_readData_2),
    .io_readData_3(cacheMem_io_readData_3),
    .io_writeData_0(cacheMem_io_writeData_0),
    .io_writeData_1(cacheMem_io_writeData_1),
    .io_writeData_2(cacheMem_io_writeData_2),
    .io_writeData_3(cacheMem_io_writeData_3),
    .io_writeEnable(cacheMem_io_writeEnable),
    .io_hit(cacheMem_io_hit),
    .io_hit_ready(cacheMem_io_hit_ready),
    .io_replace_ready(cacheMem_io_replace_ready),
    .io_replace(cacheMem_io_replace),
    .io_replace_addr(cacheMem_io_replace_addr),
    .io_full_line(cacheMem_io_full_line)
  );
  assign io_axi_AWREADY = state == 4'h0; // @[cache_phase1.scala 330:29]
  assign io_axi_WREADY = state == 4'h4; // @[cache_phase1.scala 332:28]
  assign io_axi_BRESP = B_data; // @[cache_phase1.scala 353:18]
  assign io_axi_BVALID = state == 4'h8; // @[cache_phase1.scala 354:28]
  assign io_axi_ARREADY = state == 4'h0; // @[cache_phase1.scala 305:29]
  assign io_axi_RDATA = 3'h7 == coreReadBeatCounter ? DataReadBuffer_7_data : _GEN_537; // @[cache_phase1.scala 322:{18,18}]
  assign io_axi_RID = memDataReadBufferID; // @[cache_phase1.scala 323:16]
  assign io_axi_RVALID = state == 4'h3 & _GEN_546; // @[cache_phase1.scala 324:40]
  assign io_axi_RRESP = 2'h0; // @[cache_phase1.scala 325:{18,18}]
  assign io_axi_RLAST = _GEN_743 == 8'h7 & _io_axi_RVALID_T; // @[cache_phase1.scala 326:68]
  assign io_mem_axi_AWADDR = replace_address_Buffer_addr; // @[cache_phase1.scala 339:23]
  assign io_mem_axi_AWVALID = state == 4'h5 & replace_address_Buffer_valid; // @[cache_phase1.scala 340:46]
  assign io_mem_axi_AWCACHE = 4'h2; // @[cache_phase1.scala 344:24]
  assign io_mem_axi_AWLEN = 8'h7; // @[cache_phase1.scala 343:22]
  assign io_mem_axi_AWSIZE = 3'h5; // @[cache_phase1.scala 346:23]
  assign io_mem_axi_AWLOCK = 2'h0; // @[cache_phase1.scala 345:23]
  assign io_mem_axi_AWPROT = 3'h0; // @[cache_phase1.scala 347:23]
  assign io_mem_axi_AWQOS = 4'h0; // @[cache_phase1.scala 348:22]
  assign io_mem_axi_AWBURST = 2'h1; // @[cache_phase1.scala 341:24]
  assign io_mem_axi_AWID = 2'h0; // @[cache_phase1.scala 342:21]
  assign io_mem_axi_WVALID = state == 4'h6 & _GEN_570; // @[cache_phase1.scala 335:43]
  assign io_mem_axi_WDATA = 3'h7 == memDataWriteCounter ? replace_data_buffer_7_data : _GEN_561; // @[cache_phase1.scala 334:{21,21}]
  assign io_mem_axi_WSTRB = 32'hff; // @[cache_phase1.scala 336:22]
  assign io_mem_axi_WLAST = _GEN_744 == 8'h7; // @[cache_phase1.scala 337:44]
  assign io_mem_axi_BREADY = state == 4'h7; // @[cache_phase1.scala 351:32]
  assign io_mem_axi_ARID = memDataReadAddressBuffer_id; // @[cache_phase1.scala 308:21]
  assign io_mem_axi_ARADDR = memDataReadAddressBuffer_addr; // @[cache_phase1.scala 309:23]
  assign io_mem_axi_ARVALID = state == 4'h1 & memDataReadAddressBuffer_addr_valid & ~cacheMem_io_hit; // @[cache_phase1.scala 310:84]
  assign io_mem_axi_ARLEN = 8'h7; // @[cache_phase1.scala 311:22]
  assign io_mem_axi_ARSIZE = 3'h5; // @[cache_phase1.scala 312:23]
  assign io_mem_axi_ARBURST = 2'h1; // @[cache_phase1.scala 313:24]
  assign io_mem_axi_ARLOCK = 2'h0; // @[cache_phase1.scala 315:23]
  assign io_mem_axi_ARCACHE = 4'h2; // @[cache_phase1.scala 314:24]
  assign io_mem_axi_ARPROT = 3'h0; // @[cache_phase1.scala 316:23]
  assign io_mem_axi_ARQOS = 4'h0; // @[cache_phase1.scala 317:22]
  assign io_mem_axi_RREADY = state == 4'h2; // @[cache_phase1.scala 320:32]
  assign cacheMem_clock = clock;
  assign cacheMem_io_addr = inputReadAddrBuffer_addr; // @[cache_phase1.scala 374:22]
  assign cacheMem_io_writeData_0 = delay_RLAST ? data_wire_0 : temp_0; // @[cache_phase1.scala 438:33]
  assign cacheMem_io_writeData_1 = delay_RLAST ? data_wire_1 : temp_1; // @[cache_phase1.scala 438:33]
  assign cacheMem_io_writeData_2 = delay_RLAST ? data_wire_2 : temp_2; // @[cache_phase1.scala 438:33]
  assign cacheMem_io_writeData_3 = delay_RLAST ? data_wire_3 : temp_3; // @[cache_phase1.scala 438:33]
  assign cacheMem_io_writeEnable = delay_RLAST | delay_WLAST & cacheMem_io_hit; // @[cache_phase1.scala 385:44]
  assign cacheMem_io_hit_ready = _io_mem_axi_ARVALID_T | _io_axi_BVALID_T; // @[cache_phase1.scala 442:48]
  assign cacheMem_io_replace_ready = _io_mem_axi_ARVALID_T & _T_7; // @[cache_phase1.scala 443:53]
  assign cacheMem_io_full_line = delay_RLAST; // @[cache_phase1.scala 384:27]
  always @(posedge clock) begin
    if (reset) begin // @[cache_phase1.scala 25:22]
      state <= 4'h0; // @[cache_phase1.scala 25:22]
    end else if (4'h0 == state) begin // @[cache_phase1.scala 145:18]
      if (io_axi_AWREADY & io_axi_AWVALID) begin // @[cache_phase1.scala 162:51]
        state <= 4'h4; // @[cache_phase1.scala 173:22]
      end else if (io_axi_ARREADY & io_axi_ARVALID) begin // @[cache_phase1.scala 148:51]
        state <= 4'h1; // @[cache_phase1.scala 159:22]
      end
    end else if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
      if (io_mem_axi_ARREADY & io_mem_axi_ARVALID) begin // @[cache_phase1.scala 201:60]
        state <= 4'h2; // @[cache_phase1.scala 202:23]
      end else begin
        state <= _GEN_36;
      end
    end else if (4'h2 == state) begin // @[cache_phase1.scala 145:18]
      state <= _GEN_109;
    end else begin
      state <= _GEN_263;
    end
    if (reset) begin // @[cache_phase1.scala 28:37]
      memReadBeatCounter <= 3'h0; // @[cache_phase1.scala 28:37]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (4'h2 == state) begin // @[cache_phase1.scala 145:18]
          memReadBeatCounter <= _GEN_107;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 29:38]
      coreReadBeatCounter <= 3'h0; // @[cache_phase1.scala 29:38]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
          coreReadBeatCounter <= _GEN_253;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 32:39]
      coreDataWriteCounter <= 3'h0; // @[cache_phase1.scala 32:39]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
          coreDataWriteCounter <= _GEN_280;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 33:38]
      memDataWriteCounter <= 3'h0; // @[cache_phase1.scala 33:38]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
          memDataWriteCounter <= _GEN_281;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 36:39]
      replace_address_Buffer_addr <= 32'h0; // @[cache_phase1.scala 36:39]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        if (cacheMem_io_replace) begin // @[cache_phase1.scala 189:38]
          replace_address_Buffer_addr <= cacheMem_io_replace_addr; // @[cache_phase1.scala 198:45]
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 36:39]
      replace_address_Buffer_valid <= 1'h0; // @[cache_phase1.scala 36:39]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        replace_address_Buffer_valid <= _GEN_53;
      end else if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
        replace_address_Buffer_valid <= _GEN_283;
      end
    end
    if (reset) begin // @[cache_phase1.scala 44:36]
      replace_data_buffer_0_data <= 256'h0; // @[cache_phase1.scala 44:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        if (cacheMem_io_replace) begin // @[cache_phase1.scala 189:38]
          replace_data_buffer_0_data <= cacheMem_io_readData_0[511:256]; // @[cache_phase1.scala 191:51]
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 44:36]
      replace_data_buffer_0_valid <= 1'h0; // @[cache_phase1.scala 44:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        replace_data_buffer_0_valid <= _GEN_39;
      end else if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
        replace_data_buffer_0_valid <= _GEN_284;
      end
    end
    if (reset) begin // @[cache_phase1.scala 44:36]
      replace_data_buffer_1_data <= 256'h0; // @[cache_phase1.scala 44:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        if (cacheMem_io_replace) begin // @[cache_phase1.scala 189:38]
          replace_data_buffer_1_data <= cacheMem_io_readData_0[255:0]; // @[cache_phase1.scala 192:53]
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 44:36]
      replace_data_buffer_1_valid <= 1'h0; // @[cache_phase1.scala 44:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        replace_data_buffer_1_valid <= _GEN_40;
      end else if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
        replace_data_buffer_1_valid <= _GEN_285;
      end
    end
    if (reset) begin // @[cache_phase1.scala 44:36]
      replace_data_buffer_2_data <= 256'h0; // @[cache_phase1.scala 44:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        if (cacheMem_io_replace) begin // @[cache_phase1.scala 189:38]
          replace_data_buffer_2_data <= cacheMem_io_readData_1[511:256]; // @[cache_phase1.scala 191:51]
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 44:36]
      replace_data_buffer_2_valid <= 1'h0; // @[cache_phase1.scala 44:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        replace_data_buffer_2_valid <= _GEN_43;
      end else if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
        replace_data_buffer_2_valid <= _GEN_286;
      end
    end
    if (reset) begin // @[cache_phase1.scala 44:36]
      replace_data_buffer_3_data <= 256'h0; // @[cache_phase1.scala 44:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        if (cacheMem_io_replace) begin // @[cache_phase1.scala 189:38]
          replace_data_buffer_3_data <= cacheMem_io_readData_1[255:0]; // @[cache_phase1.scala 192:53]
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 44:36]
      replace_data_buffer_3_valid <= 1'h0; // @[cache_phase1.scala 44:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        replace_data_buffer_3_valid <= _GEN_44;
      end else if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
        replace_data_buffer_3_valid <= _GEN_287;
      end
    end
    if (reset) begin // @[cache_phase1.scala 44:36]
      replace_data_buffer_4_data <= 256'h0; // @[cache_phase1.scala 44:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        if (cacheMem_io_replace) begin // @[cache_phase1.scala 189:38]
          replace_data_buffer_4_data <= cacheMem_io_readData_2[511:256]; // @[cache_phase1.scala 191:51]
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 44:36]
      replace_data_buffer_4_valid <= 1'h0; // @[cache_phase1.scala 44:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        replace_data_buffer_4_valid <= _GEN_47;
      end else if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
        replace_data_buffer_4_valid <= _GEN_288;
      end
    end
    if (reset) begin // @[cache_phase1.scala 44:36]
      replace_data_buffer_5_data <= 256'h0; // @[cache_phase1.scala 44:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        if (cacheMem_io_replace) begin // @[cache_phase1.scala 189:38]
          replace_data_buffer_5_data <= cacheMem_io_readData_2[255:0]; // @[cache_phase1.scala 192:53]
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 44:36]
      replace_data_buffer_5_valid <= 1'h0; // @[cache_phase1.scala 44:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        replace_data_buffer_5_valid <= _GEN_48;
      end else if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
        replace_data_buffer_5_valid <= _GEN_289;
      end
    end
    if (reset) begin // @[cache_phase1.scala 44:36]
      replace_data_buffer_6_data <= 256'h0; // @[cache_phase1.scala 44:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        if (cacheMem_io_replace) begin // @[cache_phase1.scala 189:38]
          replace_data_buffer_6_data <= cacheMem_io_readData_3[511:256]; // @[cache_phase1.scala 191:51]
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 44:36]
      replace_data_buffer_6_valid <= 1'h0; // @[cache_phase1.scala 44:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        replace_data_buffer_6_valid <= _GEN_51;
      end else if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
        replace_data_buffer_6_valid <= _GEN_290;
      end
    end
    if (reset) begin // @[cache_phase1.scala 44:36]
      replace_data_buffer_7_data <= 256'h0; // @[cache_phase1.scala 44:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        if (cacheMem_io_replace) begin // @[cache_phase1.scala 189:38]
          replace_data_buffer_7_data <= cacheMem_io_readData_3[255:0]; // @[cache_phase1.scala 192:53]
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 44:36]
      replace_data_buffer_7_valid <= 1'h0; // @[cache_phase1.scala 44:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        replace_data_buffer_7_valid <= _GEN_52;
      end else if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
        replace_data_buffer_7_valid <= _GEN_291;
      end
    end
    if (reset) begin // @[cache_phase1.scala 54:38]
      inputReadAddrBuffer_id <= 2'h0; // @[cache_phase1.scala 54:38]
    end else if (4'h0 == state) begin // @[cache_phase1.scala 145:18]
      if (io_axi_AWREADY & io_axi_AWVALID) begin // @[cache_phase1.scala 162:51]
        inputReadAddrBuffer_id <= io_axi_AWID; // @[cache_phase1.scala 167:40]
      end else if (io_axi_ARREADY & io_axi_ARVALID) begin // @[cache_phase1.scala 148:51]
        inputReadAddrBuffer_id <= io_axi_ARID; // @[cache_phase1.scala 153:40]
      end
    end
    if (reset) begin // @[cache_phase1.scala 54:38]
      inputReadAddrBuffer_addr <= 32'h569adf; // @[cache_phase1.scala 54:38]
    end else if (4'h0 == state) begin // @[cache_phase1.scala 145:18]
      if (io_axi_AWREADY & io_axi_AWVALID) begin // @[cache_phase1.scala 162:51]
        inputReadAddrBuffer_addr <= io_axi_AWADDR; // @[cache_phase1.scala 163:41]
      end else if (io_axi_ARREADY & io_axi_ARVALID) begin // @[cache_phase1.scala 148:51]
        inputReadAddrBuffer_addr <= io_axi_ARADDR; // @[cache_phase1.scala 149:41]
      end
    end
    if (reset) begin // @[cache_phase1.scala 54:38]
      inputReadAddrBuffer_valid <= 1'h0; // @[cache_phase1.scala 54:38]
    end else if (4'h0 == state) begin // @[cache_phase1.scala 145:18]
      if (io_axi_AWREADY & io_axi_AWVALID) begin // @[cache_phase1.scala 162:51]
        inputReadAddrBuffer_valid <= io_axi_AWVALID; // @[cache_phase1.scala 164:43]
      end else if (io_axi_ARREADY & io_axi_ARVALID) begin // @[cache_phase1.scala 148:51]
        inputReadAddrBuffer_valid <= io_axi_ARVALID; // @[cache_phase1.scala 150:43]
      end
    end else if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
        inputReadAddrBuffer_valid <= _GEN_254;
      end
    end
    if (reset) begin // @[cache_phase1.scala 79:32]
      inputDataBuffer_0_data <= 64'h0; // @[cache_phase1.scala 79:32]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
          inputDataBuffer_0_data <= _GEN_264;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 79:32]
      inputDataBuffer_0_valid <= 1'h0; // @[cache_phase1.scala 79:32]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
          inputDataBuffer_0_valid <= _GEN_272;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 79:32]
      inputDataBuffer_1_data <= 64'h0; // @[cache_phase1.scala 79:32]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
          inputDataBuffer_1_data <= _GEN_265;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 79:32]
      inputDataBuffer_2_data <= 64'h0; // @[cache_phase1.scala 79:32]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
          inputDataBuffer_2_data <= _GEN_266;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 79:32]
      inputDataBuffer_3_data <= 64'h0; // @[cache_phase1.scala 79:32]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
          inputDataBuffer_3_data <= _GEN_267;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 79:32]
      inputDataBuffer_4_data <= 64'h0; // @[cache_phase1.scala 79:32]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
          inputDataBuffer_4_data <= _GEN_268;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 79:32]
      inputDataBuffer_5_data <= 64'h0; // @[cache_phase1.scala 79:32]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
          inputDataBuffer_5_data <= _GEN_269;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 79:32]
      inputDataBuffer_6_data <= 64'h0; // @[cache_phase1.scala 79:32]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
          inputDataBuffer_6_data <= _GEN_270;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 79:32]
      inputDataBuffer_7_data <= 64'h0; // @[cache_phase1.scala 79:32]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
          inputDataBuffer_7_data <= _GEN_271;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 90:41]
      memDataReadAddressBuffer_id <= 2'h0; // @[cache_phase1.scala 90:41]
    end else begin
      memDataReadAddressBuffer_id <= inputReadAddrBuffer_id; // @[cache_phase1.scala 362:33]
    end
    if (reset) begin // @[cache_phase1.scala 90:41]
      memDataReadAddressBuffer_addr <= 32'h0; // @[cache_phase1.scala 90:41]
    end else begin
      memDataReadAddressBuffer_addr <= inputReadAddrBuffer_addr; // @[cache_phase1.scala 357:35]
    end
    if (reset) begin // @[cache_phase1.scala 90:41]
      memDataReadAddressBuffer_addr_valid <= 1'h0; // @[cache_phase1.scala 90:41]
    end else begin
      memDataReadAddressBuffer_addr_valid <= inputReadAddrBuffer_valid; // @[cache_phase1.scala 358:41]
    end
    if (reset) begin // @[cache_phase1.scala 115:34]
      memDataReadBuffer_0_data <= 256'h0; // @[cache_phase1.scala 115:34]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (4'h2 == state) begin // @[cache_phase1.scala 145:18]
          memDataReadBuffer_0_data <= _GEN_83;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 115:34]
      memDataReadBuffer_0_valid <= 1'h0; // @[cache_phase1.scala 115:34]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (4'h2 == state) begin // @[cache_phase1.scala 145:18]
          memDataReadBuffer_0_valid <= _GEN_91;
        end else begin
          memDataReadBuffer_0_valid <= _GEN_255;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 115:34]
      memDataReadBuffer_1_data <= 256'h0; // @[cache_phase1.scala 115:34]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (4'h2 == state) begin // @[cache_phase1.scala 145:18]
          memDataReadBuffer_1_data <= _GEN_84;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 115:34]
      memDataReadBuffer_1_valid <= 1'h0; // @[cache_phase1.scala 115:34]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (4'h2 == state) begin // @[cache_phase1.scala 145:18]
          memDataReadBuffer_1_valid <= _GEN_92;
        end else begin
          memDataReadBuffer_1_valid <= _GEN_256;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 115:34]
      memDataReadBuffer_2_data <= 256'h0; // @[cache_phase1.scala 115:34]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (4'h2 == state) begin // @[cache_phase1.scala 145:18]
          memDataReadBuffer_2_data <= _GEN_85;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 115:34]
      memDataReadBuffer_2_valid <= 1'h0; // @[cache_phase1.scala 115:34]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (4'h2 == state) begin // @[cache_phase1.scala 145:18]
          memDataReadBuffer_2_valid <= _GEN_93;
        end else begin
          memDataReadBuffer_2_valid <= _GEN_257;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 115:34]
      memDataReadBuffer_3_data <= 256'h0; // @[cache_phase1.scala 115:34]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (4'h2 == state) begin // @[cache_phase1.scala 145:18]
          memDataReadBuffer_3_data <= _GEN_86;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 115:34]
      memDataReadBuffer_3_valid <= 1'h0; // @[cache_phase1.scala 115:34]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (4'h2 == state) begin // @[cache_phase1.scala 145:18]
          memDataReadBuffer_3_valid <= _GEN_94;
        end else begin
          memDataReadBuffer_3_valid <= _GEN_258;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 115:34]
      memDataReadBuffer_4_data <= 256'h0; // @[cache_phase1.scala 115:34]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (4'h2 == state) begin // @[cache_phase1.scala 145:18]
          memDataReadBuffer_4_data <= _GEN_87;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 115:34]
      memDataReadBuffer_4_valid <= 1'h0; // @[cache_phase1.scala 115:34]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (4'h2 == state) begin // @[cache_phase1.scala 145:18]
          memDataReadBuffer_4_valid <= _GEN_95;
        end else begin
          memDataReadBuffer_4_valid <= _GEN_259;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 115:34]
      memDataReadBuffer_5_data <= 256'h0; // @[cache_phase1.scala 115:34]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (4'h2 == state) begin // @[cache_phase1.scala 145:18]
          memDataReadBuffer_5_data <= _GEN_88;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 115:34]
      memDataReadBuffer_5_valid <= 1'h0; // @[cache_phase1.scala 115:34]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (4'h2 == state) begin // @[cache_phase1.scala 145:18]
          memDataReadBuffer_5_valid <= _GEN_96;
        end else begin
          memDataReadBuffer_5_valid <= _GEN_260;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 115:34]
      memDataReadBuffer_6_data <= 256'h0; // @[cache_phase1.scala 115:34]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (4'h2 == state) begin // @[cache_phase1.scala 145:18]
          memDataReadBuffer_6_data <= _GEN_89;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 115:34]
      memDataReadBuffer_6_valid <= 1'h0; // @[cache_phase1.scala 115:34]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (4'h2 == state) begin // @[cache_phase1.scala 145:18]
          memDataReadBuffer_6_valid <= _GEN_97;
        end else begin
          memDataReadBuffer_6_valid <= _GEN_261;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 115:34]
      memDataReadBuffer_7_data <= 256'h0; // @[cache_phase1.scala 115:34]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (4'h2 == state) begin // @[cache_phase1.scala 145:18]
          memDataReadBuffer_7_data <= _GEN_90;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 115:34]
      memDataReadBuffer_7_valid <= 1'h0; // @[cache_phase1.scala 115:34]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (4'h2 == state) begin // @[cache_phase1.scala 145:18]
          memDataReadBuffer_7_valid <= _GEN_98;
        end else begin
          memDataReadBuffer_7_valid <= _GEN_262;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 125:36]
      memDataReadBufferID <= 2'h0; // @[cache_phase1.scala 125:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (4'h2 == state) begin // @[cache_phase1.scala 145:18]
          memDataReadBufferID <= _GEN_108;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 128:24]
      B_data <= 2'h0; // @[cache_phase1.scala 128:24]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (!(4'h1 == state)) begin // @[cache_phase1.scala 145:18]
        if (!(4'h2 == state)) begin // @[cache_phase1.scala 145:18]
          B_data <= _GEN_282;
        end
      end
    end
    if (reset) begin // @[cache_phase1.scala 131:31]
      DataReadBuffer_0_data <= 64'h0; // @[cache_phase1.scala 131:31]
    end else if (_GEN_714) begin // @[cache_phase1.scala 428:34]
      DataReadBuffer_0_data <= _GEN_718[511:448]; // @[cache_phase1.scala 430:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        DataReadBuffer_0_data <= _GEN_12;
      end
    end
    if (reset) begin // @[cache_phase1.scala 131:31]
      DataReadBuffer_0_valid <= 1'h0; // @[cache_phase1.scala 131:31]
    end else if (_GEN_714) begin // @[cache_phase1.scala 428:34]
      if (2'h3 == offset) begin // @[cache_phase1.scala 428:34]
        DataReadBuffer_0_valid <= data_wire_valid_3; // @[cache_phase1.scala 428:34]
      end else if (2'h2 == offset) begin // @[cache_phase1.scala 428:34]
        DataReadBuffer_0_valid <= data_wire_valid_2; // @[cache_phase1.scala 428:34]
      end else begin
        DataReadBuffer_0_valid <= _GEN_712;
      end
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        DataReadBuffer_0_valid <= _GEN_13;
      end
    end
    if (reset) begin // @[cache_phase1.scala 131:31]
      DataReadBuffer_1_data <= 64'h0; // @[cache_phase1.scala 131:31]
    end else if (_GEN_714) begin // @[cache_phase1.scala 428:34]
      DataReadBuffer_1_data <= _GEN_718[447:384]; // @[cache_phase1.scala 430:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        DataReadBuffer_1_data <= _GEN_15;
      end
    end
    if (reset) begin // @[cache_phase1.scala 131:31]
      DataReadBuffer_1_valid <= 1'h0; // @[cache_phase1.scala 131:31]
    end else if (_GEN_714) begin // @[cache_phase1.scala 428:34]
      if (2'h3 == offset) begin // @[cache_phase1.scala 428:34]
        DataReadBuffer_1_valid <= data_wire_valid_3; // @[cache_phase1.scala 428:34]
      end else if (2'h2 == offset) begin // @[cache_phase1.scala 428:34]
        DataReadBuffer_1_valid <= data_wire_valid_2; // @[cache_phase1.scala 428:34]
      end else begin
        DataReadBuffer_1_valid <= _GEN_712;
      end
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        DataReadBuffer_1_valid <= _GEN_16;
      end
    end
    if (reset) begin // @[cache_phase1.scala 131:31]
      DataReadBuffer_2_data <= 64'h0; // @[cache_phase1.scala 131:31]
    end else if (_GEN_714) begin // @[cache_phase1.scala 428:34]
      DataReadBuffer_2_data <= _GEN_718[383:320]; // @[cache_phase1.scala 430:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        DataReadBuffer_2_data <= _GEN_18;
      end
    end
    if (reset) begin // @[cache_phase1.scala 131:31]
      DataReadBuffer_2_valid <= 1'h0; // @[cache_phase1.scala 131:31]
    end else if (_GEN_714) begin // @[cache_phase1.scala 428:34]
      if (2'h3 == offset) begin // @[cache_phase1.scala 428:34]
        DataReadBuffer_2_valid <= data_wire_valid_3; // @[cache_phase1.scala 428:34]
      end else if (2'h2 == offset) begin // @[cache_phase1.scala 428:34]
        DataReadBuffer_2_valid <= data_wire_valid_2; // @[cache_phase1.scala 428:34]
      end else begin
        DataReadBuffer_2_valid <= _GEN_712;
      end
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        DataReadBuffer_2_valid <= _GEN_19;
      end
    end
    if (reset) begin // @[cache_phase1.scala 131:31]
      DataReadBuffer_3_data <= 64'h0; // @[cache_phase1.scala 131:31]
    end else if (_GEN_714) begin // @[cache_phase1.scala 428:34]
      DataReadBuffer_3_data <= _GEN_718[319:256]; // @[cache_phase1.scala 430:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        DataReadBuffer_3_data <= _GEN_21;
      end
    end
    if (reset) begin // @[cache_phase1.scala 131:31]
      DataReadBuffer_3_valid <= 1'h0; // @[cache_phase1.scala 131:31]
    end else if (_GEN_714) begin // @[cache_phase1.scala 428:34]
      if (2'h3 == offset) begin // @[cache_phase1.scala 428:34]
        DataReadBuffer_3_valid <= data_wire_valid_3; // @[cache_phase1.scala 428:34]
      end else if (2'h2 == offset) begin // @[cache_phase1.scala 428:34]
        DataReadBuffer_3_valid <= data_wire_valid_2; // @[cache_phase1.scala 428:34]
      end else begin
        DataReadBuffer_3_valid <= _GEN_712;
      end
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        DataReadBuffer_3_valid <= _GEN_22;
      end
    end
    if (reset) begin // @[cache_phase1.scala 131:31]
      DataReadBuffer_4_data <= 64'h0; // @[cache_phase1.scala 131:31]
    end else if (_GEN_714) begin // @[cache_phase1.scala 428:34]
      DataReadBuffer_4_data <= _GEN_718[255:192]; // @[cache_phase1.scala 430:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        DataReadBuffer_4_data <= _GEN_24;
      end
    end
    if (reset) begin // @[cache_phase1.scala 131:31]
      DataReadBuffer_4_valid <= 1'h0; // @[cache_phase1.scala 131:31]
    end else if (_GEN_714) begin // @[cache_phase1.scala 428:34]
      if (2'h3 == offset) begin // @[cache_phase1.scala 428:34]
        DataReadBuffer_4_valid <= data_wire_valid_3; // @[cache_phase1.scala 428:34]
      end else if (2'h2 == offset) begin // @[cache_phase1.scala 428:34]
        DataReadBuffer_4_valid <= data_wire_valid_2; // @[cache_phase1.scala 428:34]
      end else begin
        DataReadBuffer_4_valid <= _GEN_712;
      end
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        DataReadBuffer_4_valid <= _GEN_25;
      end
    end
    if (reset) begin // @[cache_phase1.scala 131:31]
      DataReadBuffer_5_data <= 64'h0; // @[cache_phase1.scala 131:31]
    end else if (_GEN_714) begin // @[cache_phase1.scala 428:34]
      DataReadBuffer_5_data <= _GEN_718[191:128]; // @[cache_phase1.scala 430:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        DataReadBuffer_5_data <= _GEN_27;
      end
    end
    if (reset) begin // @[cache_phase1.scala 131:31]
      DataReadBuffer_5_valid <= 1'h0; // @[cache_phase1.scala 131:31]
    end else if (_GEN_714) begin // @[cache_phase1.scala 428:34]
      if (2'h3 == offset) begin // @[cache_phase1.scala 428:34]
        DataReadBuffer_5_valid <= data_wire_valid_3; // @[cache_phase1.scala 428:34]
      end else if (2'h2 == offset) begin // @[cache_phase1.scala 428:34]
        DataReadBuffer_5_valid <= data_wire_valid_2; // @[cache_phase1.scala 428:34]
      end else begin
        DataReadBuffer_5_valid <= _GEN_712;
      end
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        DataReadBuffer_5_valid <= _GEN_28;
      end
    end
    if (reset) begin // @[cache_phase1.scala 131:31]
      DataReadBuffer_6_data <= 64'h0; // @[cache_phase1.scala 131:31]
    end else if (_GEN_714) begin // @[cache_phase1.scala 428:34]
      DataReadBuffer_6_data <= _GEN_718[127:64]; // @[cache_phase1.scala 430:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        DataReadBuffer_6_data <= _GEN_30;
      end
    end
    if (reset) begin // @[cache_phase1.scala 131:31]
      DataReadBuffer_6_valid <= 1'h0; // @[cache_phase1.scala 131:31]
    end else if (_GEN_714) begin // @[cache_phase1.scala 428:34]
      if (2'h3 == offset) begin // @[cache_phase1.scala 428:34]
        DataReadBuffer_6_valid <= data_wire_valid_3; // @[cache_phase1.scala 428:34]
      end else if (2'h2 == offset) begin // @[cache_phase1.scala 428:34]
        DataReadBuffer_6_valid <= data_wire_valid_2; // @[cache_phase1.scala 428:34]
      end else begin
        DataReadBuffer_6_valid <= _GEN_712;
      end
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        DataReadBuffer_6_valid <= _GEN_31;
      end
    end
    if (reset) begin // @[cache_phase1.scala 131:31]
      DataReadBuffer_7_data <= 64'h0; // @[cache_phase1.scala 131:31]
    end else if (_GEN_714) begin // @[cache_phase1.scala 428:34]
      DataReadBuffer_7_data <= _GEN_718[63:0]; // @[cache_phase1.scala 430:36]
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        DataReadBuffer_7_data <= _GEN_33;
      end
    end
    if (reset) begin // @[cache_phase1.scala 131:31]
      DataReadBuffer_7_valid <= 1'h0; // @[cache_phase1.scala 131:31]
    end else if (_GEN_714) begin // @[cache_phase1.scala 428:34]
      if (2'h3 == offset) begin // @[cache_phase1.scala 428:34]
        DataReadBuffer_7_valid <= data_wire_valid_3; // @[cache_phase1.scala 428:34]
      end else if (2'h2 == offset) begin // @[cache_phase1.scala 428:34]
        DataReadBuffer_7_valid <= data_wire_valid_2; // @[cache_phase1.scala 428:34]
      end else begin
        DataReadBuffer_7_valid <= _GEN_712;
      end
    end else if (!(4'h0 == state)) begin // @[cache_phase1.scala 145:18]
      if (4'h1 == state) begin // @[cache_phase1.scala 145:18]
        DataReadBuffer_7_valid <= _GEN_34;
      end
    end
    if (reset) begin // @[cache_phase1.scala 377:30]
      delay_RLAST <= 1'h0; // @[cache_phase1.scala 377:30]
    end else begin
      delay_RLAST <= io_mem_axi_RLAST; // @[cache_phase1.scala 380:17]
    end
    if (reset) begin // @[cache_phase1.scala 378:30]
      delay_WLAST <= 1'h0; // @[cache_phase1.scala 378:30]
    end else begin
      delay_WLAST <= io_axi_WLAST; // @[cache_phase1.scala 381:17]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  memReadBeatCounter = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  coreReadBeatCounter = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  coreDataWriteCounter = _RAND_3[2:0];
  _RAND_4 = {1{`RANDOM}};
  memDataWriteCounter = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  replace_address_Buffer_addr = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  replace_address_Buffer_valid = _RAND_6[0:0];
  _RAND_7 = {8{`RANDOM}};
  replace_data_buffer_0_data = _RAND_7[255:0];
  _RAND_8 = {1{`RANDOM}};
  replace_data_buffer_0_valid = _RAND_8[0:0];
  _RAND_9 = {8{`RANDOM}};
  replace_data_buffer_1_data = _RAND_9[255:0];
  _RAND_10 = {1{`RANDOM}};
  replace_data_buffer_1_valid = _RAND_10[0:0];
  _RAND_11 = {8{`RANDOM}};
  replace_data_buffer_2_data = _RAND_11[255:0];
  _RAND_12 = {1{`RANDOM}};
  replace_data_buffer_2_valid = _RAND_12[0:0];
  _RAND_13 = {8{`RANDOM}};
  replace_data_buffer_3_data = _RAND_13[255:0];
  _RAND_14 = {1{`RANDOM}};
  replace_data_buffer_3_valid = _RAND_14[0:0];
  _RAND_15 = {8{`RANDOM}};
  replace_data_buffer_4_data = _RAND_15[255:0];
  _RAND_16 = {1{`RANDOM}};
  replace_data_buffer_4_valid = _RAND_16[0:0];
  _RAND_17 = {8{`RANDOM}};
  replace_data_buffer_5_data = _RAND_17[255:0];
  _RAND_18 = {1{`RANDOM}};
  replace_data_buffer_5_valid = _RAND_18[0:0];
  _RAND_19 = {8{`RANDOM}};
  replace_data_buffer_6_data = _RAND_19[255:0];
  _RAND_20 = {1{`RANDOM}};
  replace_data_buffer_6_valid = _RAND_20[0:0];
  _RAND_21 = {8{`RANDOM}};
  replace_data_buffer_7_data = _RAND_21[255:0];
  _RAND_22 = {1{`RANDOM}};
  replace_data_buffer_7_valid = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  inputReadAddrBuffer_id = _RAND_23[1:0];
  _RAND_24 = {1{`RANDOM}};
  inputReadAddrBuffer_addr = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  inputReadAddrBuffer_valid = _RAND_25[0:0];
  _RAND_26 = {2{`RANDOM}};
  inputDataBuffer_0_data = _RAND_26[63:0];
  _RAND_27 = {1{`RANDOM}};
  inputDataBuffer_0_valid = _RAND_27[0:0];
  _RAND_28 = {2{`RANDOM}};
  inputDataBuffer_1_data = _RAND_28[63:0];
  _RAND_29 = {2{`RANDOM}};
  inputDataBuffer_2_data = _RAND_29[63:0];
  _RAND_30 = {2{`RANDOM}};
  inputDataBuffer_3_data = _RAND_30[63:0];
  _RAND_31 = {2{`RANDOM}};
  inputDataBuffer_4_data = _RAND_31[63:0];
  _RAND_32 = {2{`RANDOM}};
  inputDataBuffer_5_data = _RAND_32[63:0];
  _RAND_33 = {2{`RANDOM}};
  inputDataBuffer_6_data = _RAND_33[63:0];
  _RAND_34 = {2{`RANDOM}};
  inputDataBuffer_7_data = _RAND_34[63:0];
  _RAND_35 = {1{`RANDOM}};
  memDataReadAddressBuffer_id = _RAND_35[1:0];
  _RAND_36 = {1{`RANDOM}};
  memDataReadAddressBuffer_addr = _RAND_36[31:0];
  _RAND_37 = {1{`RANDOM}};
  memDataReadAddressBuffer_addr_valid = _RAND_37[0:0];
  _RAND_38 = {8{`RANDOM}};
  memDataReadBuffer_0_data = _RAND_38[255:0];
  _RAND_39 = {1{`RANDOM}};
  memDataReadBuffer_0_valid = _RAND_39[0:0];
  _RAND_40 = {8{`RANDOM}};
  memDataReadBuffer_1_data = _RAND_40[255:0];
  _RAND_41 = {1{`RANDOM}};
  memDataReadBuffer_1_valid = _RAND_41[0:0];
  _RAND_42 = {8{`RANDOM}};
  memDataReadBuffer_2_data = _RAND_42[255:0];
  _RAND_43 = {1{`RANDOM}};
  memDataReadBuffer_2_valid = _RAND_43[0:0];
  _RAND_44 = {8{`RANDOM}};
  memDataReadBuffer_3_data = _RAND_44[255:0];
  _RAND_45 = {1{`RANDOM}};
  memDataReadBuffer_3_valid = _RAND_45[0:0];
  _RAND_46 = {8{`RANDOM}};
  memDataReadBuffer_4_data = _RAND_46[255:0];
  _RAND_47 = {1{`RANDOM}};
  memDataReadBuffer_4_valid = _RAND_47[0:0];
  _RAND_48 = {8{`RANDOM}};
  memDataReadBuffer_5_data = _RAND_48[255:0];
  _RAND_49 = {1{`RANDOM}};
  memDataReadBuffer_5_valid = _RAND_49[0:0];
  _RAND_50 = {8{`RANDOM}};
  memDataReadBuffer_6_data = _RAND_50[255:0];
  _RAND_51 = {1{`RANDOM}};
  memDataReadBuffer_6_valid = _RAND_51[0:0];
  _RAND_52 = {8{`RANDOM}};
  memDataReadBuffer_7_data = _RAND_52[255:0];
  _RAND_53 = {1{`RANDOM}};
  memDataReadBuffer_7_valid = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  memDataReadBufferID = _RAND_54[1:0];
  _RAND_55 = {1{`RANDOM}};
  B_data = _RAND_55[1:0];
  _RAND_56 = {2{`RANDOM}};
  DataReadBuffer_0_data = _RAND_56[63:0];
  _RAND_57 = {1{`RANDOM}};
  DataReadBuffer_0_valid = _RAND_57[0:0];
  _RAND_58 = {2{`RANDOM}};
  DataReadBuffer_1_data = _RAND_58[63:0];
  _RAND_59 = {1{`RANDOM}};
  DataReadBuffer_1_valid = _RAND_59[0:0];
  _RAND_60 = {2{`RANDOM}};
  DataReadBuffer_2_data = _RAND_60[63:0];
  _RAND_61 = {1{`RANDOM}};
  DataReadBuffer_2_valid = _RAND_61[0:0];
  _RAND_62 = {2{`RANDOM}};
  DataReadBuffer_3_data = _RAND_62[63:0];
  _RAND_63 = {1{`RANDOM}};
  DataReadBuffer_3_valid = _RAND_63[0:0];
  _RAND_64 = {2{`RANDOM}};
  DataReadBuffer_4_data = _RAND_64[63:0];
  _RAND_65 = {1{`RANDOM}};
  DataReadBuffer_4_valid = _RAND_65[0:0];
  _RAND_66 = {2{`RANDOM}};
  DataReadBuffer_5_data = _RAND_66[63:0];
  _RAND_67 = {1{`RANDOM}};
  DataReadBuffer_5_valid = _RAND_67[0:0];
  _RAND_68 = {2{`RANDOM}};
  DataReadBuffer_6_data = _RAND_68[63:0];
  _RAND_69 = {1{`RANDOM}};
  DataReadBuffer_6_valid = _RAND_69[0:0];
  _RAND_70 = {2{`RANDOM}};
  DataReadBuffer_7_data = _RAND_70[63:0];
  _RAND_71 = {1{`RANDOM}};
  DataReadBuffer_7_valid = _RAND_71[0:0];
  _RAND_72 = {1{`RANDOM}};
  delay_RLAST = _RAND_72[0:0];
  _RAND_73 = {1{`RANDOM}};
  delay_WLAST = _RAND_73[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
