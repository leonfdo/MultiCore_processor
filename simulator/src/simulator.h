#include <stdio.h>
#include <stdlib.h>
#include "Vsystem.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <fstream>
#include <iterator>
#include <vector>
#include <iostream>
#include <string>
#include <stdint.h>
#include <typeinfo>
#include <string>

#define STEP_TIMEOUT 1000

using namespace std;

class simulator {
  private:
  Vsystem         *tb;
	VerilatedVcdC*  tfp;

  void tick(int tickcount, Vsystem *tb, VerilatedVcdC* tfp){
    tb->eval();
    if (tfp){
      tfp->dump(tickcount*10 - 2);
    }
    tb->clock = 1;
    tb->eval();
    if(tfp){
      tfp->dump(tickcount*10);
    }
    tb->clock = 0;
    tb->eval();
    if(tfp){
      tfp->dump(tickcount*10 + 5);
      tfp->flush();
    }
  }

  void tick_nodump(int tickcount, Vsystem *tb, VerilatedVcdC* tfp){
    tb->eval();
    tb->clock = 1;
    tb->eval();
    tb->clock = 0;
    tb->eval();
  }

  public:

  uint64_t  prev_pc;
  unsigned long        tickcount;
  unsigned dump_tick;
  std::string accumulatedChars0;
  std::string accumulatedChars1;

  __uint64_t get_register_value(__uint8_t rd) {
    switch (rd) {
    case 0:
      return tb -> registersOut0_0;
    case 1:
      return tb -> registersOut0_1;
    case 2:
      return tb -> registersOut0_2;
    case 3:
      return tb -> registersOut0_3;
    case 4:
      return tb -> registersOut0_4;
    case 5:
      return tb -> registersOut0_5;
    case 6:
      return tb -> registersOut0_6;
    case 7:
      return tb -> registersOut0_7;
    case 8:
      return tb -> registersOut0_8;
    case 9:
      return tb -> registersOut0_9;
    case 10:
      return tb -> registersOut0_10;
    case 11:
      return tb -> registersOut0_11;
    case 12:
      return tb -> registersOut0_12;
    case 13:
      return tb -> registersOut0_13;
    case 14:
      return tb -> registersOut0_14;
    case 15:
      return tb -> registersOut0_15;
    case 16:
      return tb -> registersOut0_16;
    case 17:
      return tb -> registersOut0_17;
    case 18:
      return tb -> registersOut0_18;
    case 19:
      return tb -> registersOut0_19;
    case 20:
      return tb -> registersOut0_20;
    case 21:
      return tb -> registersOut0_21;
    case 22:
      return tb -> registersOut0_22;
    case 23:
      return tb -> registersOut0_23;
    case 24:
      return tb -> registersOut0_24;
    case 25:
      return tb -> registersOut0_25;
    case 26:
      return tb -> registersOut0_26;
    case 27:
      return tb -> registersOut0_27;
    case 28:
      return tb -> registersOut0_28;
    case 29:
      return tb -> registersOut0_29;
    case 30:
      return tb -> registersOut0_30;
    case 31:
      return tb -> registersOut0_31;
    default:
      return 0;
    }
  }


  __uint32_t waitForCore() {
#ifdef CORE_BOOT_WAIT
    if (!(tb -> waitingForCore_waiting)) {
      printf("ERROR: Core should be waiting during the process of programming DRAM");
      return 1;
    }
    for (;tb -> waitingForCore_waiting;tick(++dump_tick, tb, tfp)) //here it is tick_nodump
      printf("Cycles remaining waiting: %016lx \r", tb -> waitingForCore_timeRemaining);

    printf("\n");
#endif

    return 0;
  }


  void init(
    std::string image_name = "Image",
    std::string dtb_name = "qemu.dtb",
    std::string boot_rom = "boot.bin"
  ) {
    tb = (new Vsystem);
    tickcount = 0UL;
    dump_tick = 0UL;
	
    Verilated::traceEverOn(true);
    tfp = new VerilatedVcdC;
    tb->trace(tfp, 99);
    tfp->open("system_trace.vcd");

    tb -> reset = 1;
    for(int i = 0; i < 20; i++){
      tick(++dump_tick, tb, tfp); //here it is tick_nodump
    }
    tb -> reset = 0;
    for(int i = 0; i < 20; i++){
      tick(++dump_tick, tb, tfp); //here it is tick_nodump
    }

    printf("*********************************Loading kernel image*********************************\n");
		ifstream input(image_name, ios::binary);
		//printf("Running test for : ");

		vector<unsigned char> buffer(istreambuf_iterator<char>(input), {});

		//cout << buffer.size() << endl;
		tb ->programmer_valid = 1;
		unsigned long progress = 0UL;
    int next_step = buffer.size()/20;
		//printf("Loading kernel image|                    |");
		for (int i = 0; i < buffer.size(); i=i+8) {
			tb -> programmer_byte = *reinterpret_cast<unsigned long*>(&buffer.at(i));
      tb -> programmer_offset = i;
			//cout << buffer.at(i)&255 << endl;
			tick(++dump_tick, tb, tfp);	//here it is tick_nodump
      // if (progress != (i*100)/buffer.size()) 
      printf("Kernel Loaded: %ld \%\r", (i*100)/buffer.size());		
		}
    printf("done\n");
    // printf("loading dtb\n");
    // ifstream dtb_input(dtb_name, ios::binary);
		// //printf("Running test for : ");

		// vector<unsigned char> dtb_buffer(istreambuf_iterator<char>(dtb_input), {});
    // // int next_step = buffer.size()/20;
		// //printf("Loading kernel image|                    |");
		// for (int i = 0; i < dtb_buffer.size(); i=i+8) {
		// 	tb -> programmer_byte = *reinterpret_cast<unsigned long*>(&dtb_buffer.at(i));
    //   tb -> programmer_offset = (i+0x07e00000UL);
		// 	//cout << buffer.at(i)&255 << endl;
		// 	tick(++dump_tick, tb, tfp);	//here it is tick_nodump
    //   // if (progress != (i*100)/buffer.size()) 
    //   printf("Kernel Loaded: %ld \%\r", (i*100)/buffer.size());		
		// }
    // printf("done\n");
    // printf("loading boot rom\n");
    // ifstream boot_input(boot_rom, ios::binary);
		// //printf("Running test for : ");

		// vector<unsigned char> boot_buffer(istreambuf_iterator<char>(boot_input), {});
    // // int next_step = buffer.size()/20;
		// //printf("Loading kernel image|                    |");
		// for (int i = 0; i < boot_buffer.size(); i=i+8) {
		// 	tb -> programmer_byte = *reinterpret_cast<unsigned long*>(&boot_buffer.at(i));
    //   tb -> programmer_offset = (i+0x07ffff00UL);
		// 	//cout << buffer.at(i)&255 << endl;
		// 	tick(++dump_tick, tb, tfp);	//here it is tick_nodump
    //   // if (progress != (i*100)/buffer.size()) 
    //   printf("Kernel Loaded: %ld \%\r", (i*100)/buffer.size());		
		// }
    // printf("done\n");
		tb ->finishedProgramming = 1;
    tb ->programmer_valid = 0;
    tick(++dump_tick, tb, tfp);//here it is tick_nodump
		tb ->finishedProgramming = 0;
    tb ->programmer_valid = 0;
    tick(++dump_tick, tb, tfp); //here it is tick_nodump
    // prev_pc = 0x80000000UL;
    prev_pc = 0x10000000UL;
  }

  int step() {
    /* while (1) { // runs until a instruction is completed
      if (tb -> robOut_commitFired){
        prev_pc = tb -> robOut_pc;
        tick_nodump(++tickcount, tb, tfp);
        if (tb ->putChar_valid) { cout << (char)(tb -> putChar_byte) << flush; }
        break;
      }
      
      tick_nodump(++tickcount, tb, tfp);

      if (tb ->putChar_valid) { cout << (char)(tb -> putChar_byte) << flush; }
    } */
    tick(++dump_tick, tb, tfp);
    #ifndef STEP_TIMEOUT
    while (!(tb -> robOut0_commitFired)) {
    #else
    for (int i = 0; !(tb -> robOut0_commitFired) && i < STEP_TIMEOUT; i++) {
    #endif
    #ifdef SHOW_TERMINAL
    // if (tb ->core0OutChar_valid) { cout<<(char)(tb -> core0OutChar_byte)<<flush;}
    // if (tb ->core1OutChar_valid) { cout<< (char)(tb -> core1OutChar_byte)<<flush;}

    if (tb ->core0OutChar_valid) { accumulatedChars0 += (char)(tb -> core0OutChar_byte);}
    if (tb ->core1OutChar_valid) { accumulatedChars1 += (char)(tb -> core1OutChar_byte);}

    #endif
      tick(++dump_tick, tb, tfp);
          }
    
    // #ifdef SHOW_TERMINAL
    //  if (tb ->core0OutChar_valid) { cout<< (char)(tb -> core0OutChar_byte+98); cout.flush();}
    //  if (tb ->core1OutChar_valid) { cout<< (char)(tb -> core1OutChar_byte+98); cout.flush();}
    // #endif
    // return 1 indicate timeout
    prev_pc = tb -> robOut0_pc;
    if ((tb -> robOut0_interrupt) && (tb -> robOut0_commitFired)) { return 2; }
    if (tb -> robOut0_commitFired) { return 0; } else { printf("TIMEOUT IN SIMULATOR!!!\n"); return 1; }
  }

  int step_nodump() {
    /* while (1) { // runs until a instruction is completed
      if (tb -> robOut_commitFired){
        prev_pc = tb -> robOut_pc;
        tick_nodump(++tickcount, tb, tfp);
        if (tb ->putChar_valid) { cout << (char)(tb -> putChar_byte) << flush; }
        break;
      }
      
      tick_nodump(++tickcount, tb, tfp);

      if (tb ->putChar_valid) { cout << (char)(tb -> putChar_byte) << flush; }
    } */
    tick(++dump_tick, tb, tfp); //this tick_nodump
    #ifndef STEP_TIMEOUT
    while (!(tb -> robOut0_commitFired)) {
    #else
    for (int i = 0; !(tb -> robOut0_commitFired) && i < STEP_TIMEOUT; i++) {
    #endif
    #ifdef SHOW_TERMINAL
      //if (tb ->putChar_valid) { cout << tb -> putChar_byte << flush; }
    #endif
      tick(++dump_tick, tb, tfp); //here it tick_nodump
          }
    
    #ifdef SHOW_TERMINAL
    //if (tb ->putChar_valid) { cout << tb -> putChar_byte << flush; }
    #endif
    // return 1 indicate timeout
    prev_pc = tb -> robOut0_pc;
    if ((tb -> robOut0_interrupt) && (tb -> robOut0_commitFired)) { return 2; }
    if (tb -> robOut0_commitFired) { return 0; } else { printf("TIMEOUT IN SIMULATOR!!!\n"); return 1; }
  }

  int check_registers(std::vector<uint64_t> correct, uint64_t mstatus) {
    if ( tb -> registersOut0_1 != correct[1] ) { return 1; }
    if ( tb -> registersOut0_2 != correct[2] ) { return 2; }
    if ( tb -> registersOut0_3 != correct[3] ) { return 3; }
    if ( tb -> registersOut0_4 != correct[4] ) { return 4; }
    if ( tb -> registersOut0_5 != correct[5] ) { return 5; }
    if ( tb -> registersOut0_6 != correct[6] ) { return 6; }
    if ( tb -> registersOut0_7 != correct[7] ) { return 7; }
    if ( tb -> registersOut0_8 != correct[8] ) { return 8; }
    if ( tb -> registersOut0_9 != correct[9] ) { return 9; }
    if ( tb -> registersOut0_10 != correct[10] ) { return 10; }
    if ( tb -> registersOut0_11 != correct[11] ) { return 11; }
    if ( tb -> registersOut0_12 != correct[12] ) { return 12; }
    if ( tb -> registersOut0_13 != correct[13] ) { return 13; }
    if ( tb -> registersOut0_14 != correct[14] ) { return 14; }
    if ( tb -> registersOut0_15 != correct[15] ) { return 15; }
    if ( tb -> registersOut0_16 != correct[16] ) { return 16; }
    if ( tb -> registersOut0_17 != correct[17] ) { return 17; }
    if ( tb -> registersOut0_18 != correct[18] ) { return 18; }
    if ( tb -> registersOut0_19 != correct[19] ) { return 19; }
    if ( tb -> registersOut0_20 != correct[20] ) { return 20; }
    if ( tb -> registersOut0_21 != correct[21] ) { return 21; }
    if ( tb -> registersOut0_22 != correct[22] ) { return 22; }
    if ( tb -> registersOut0_23 != correct[23] ) { return 23; }
    if ( tb -> registersOut0_24 != correct[24] ) { return 24; }
    if ( tb -> registersOut0_25 != correct[25] ) { return 25; }
    if ( tb -> registersOut0_26 != correct[26] ) { return 26; }
    if ( tb -> registersOut0_27 != correct[27] ) { return 27; }
    if ( tb -> registersOut0_28 != correct[28] ) { return 28; }
    if ( tb -> registersOut0_29 != correct[29] ) { return 29; }
    if ( tb -> registersOut0_30 != correct[30] ) { return 30; }
    if ( tb -> registersOut0_31 != correct[31] ) { return 31; }
    if ( tb -> registersOut0_32 != mstatus) { return 32; }
    return 0;
  }

  

  void set_probe(unsigned long address) { tb -> prober_offset = address; }
  unsigned long get_probe() { return tb -> prober_accessLong; }

  __uint64_t read_register(int rs) {
    switch (rs)
    {
    case 0:
      return 0UL;
    
    case 1:
      return tb -> registersOut0_1;

    case 2:
      return tb -> registersOut0_2;

    case 3:
      return tb -> registersOut0_3;

    case 4:
      return tb -> registersOut0_4;

    case 5:
      return tb -> registersOut0_5;

    case 6:
      return tb -> registersOut0_6;

    case 7:
      return tb -> registersOut0_7;

    case 8:
      return tb -> registersOut0_8;

    case 9:
      return tb -> registersOut0_9;

    case 10:
      return tb -> registersOut0_10;
    
    case 11:
      return tb -> registersOut0_11;

    case 12:
      return tb -> registersOut0_12;

    case 13:
      return tb -> registersOut0_13;

    case 14:
      return tb -> registersOut0_14;

    case 15:
      return tb -> registersOut0_15;

    case 16:
      return tb -> registersOut0_16;

    case 17:
      return tb -> registersOut0_17;

    case 18:
      return tb -> registersOut0_18;

    case 19:
      return tb -> registersOut0_19;
    
    case 20:
      return tb -> registersOut0_20;
    
    case 21:
      return tb -> registersOut0_21;

    case 22:
      return tb -> registersOut0_22;

    case 23:
      return tb -> registersOut0_23;

    case 24:
      return tb -> registersOut0_24;

    case 25:
      return tb -> registersOut0_25;

    case 26:
      return tb -> registersOut0_26;

    case 27:
      return tb -> registersOut0_27;

    case 28:
      return tb -> registersOut0_28;

    case 29:
      return tb -> registersOut0_29;
    
    case 30:
      return tb -> registersOut0_30;
    
    case 31:
      return tb -> registersOut0_31;
    
    case 32:
      return tb -> registersOut0_32;
    
    default:
      return 0UL;
    }
  }
  
};
