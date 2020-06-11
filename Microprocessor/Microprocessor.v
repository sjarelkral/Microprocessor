`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    19:32:41 06/05/2020
// Design Name:
// Module Name:    Microprocessor
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module Microprocessor(
    output clock,
    output mem_write;
    output mem_read;
    output reg_write;
    output [1:0]op;
    output [7:0]reg_num;
    output [7:0]instruction_address,
    output [6:0]rwd_1,
    output [6:0]rwd_0,
    input oscillator,
    input reset,
    input [7:0]instruction
    );

    //Frequency divider : Generate 1 Hz clock (output LED, internal input for components)
    reg [25:0] delay;
    reg sec;
    always @(posedge oscillator)begin
    	delay  <= (delay == 25000000)?26'd0:(delay+1);
    	if (delay == 26'd0)begin
    		sec <= ~sec;
    	end
    end
    assign clock = sec;

    //7-segment display
    assign op = ir[7:6];


    //Storage elements
    reg [7:0]registers[3:0];
    reg [7:0]pc;
    reg [7:0]ir;
    reg [7:0]memory[31:0];
    reg

    //buses and wires
    wire [7:0]literal;

    //connections
    assign instruction_address = pc;
    assign immediate = {ir[1],ir[1],ir[1],ir[1],ir[1],ir[1],ir[1],ir[0]}; //signext
    assign mem_write = (op == 2'b10);
    assign mem_read = (op == 2'b01);
    assign reg_write = ~op[1];







    always @ (posedge reset or posedge clock) begin

    if (reset) begin
      //reset pc
      pc <= 8'd0;

      //reset registers
      registers <= 32'd0;

      //reinitialize memory
      memory[0] <= 0;
      memory[1] <= 1;
      memory[2] <= 2;
      memory[3] <= 3;
      memory[4] <= 4;
      memory[5] <= 5;
      memory[6] <= 6;
      memory[7] <= 7;
      memory[8] <= 8;
      memory[9] <= 9;
      memory[10] <= 0;
      memory[11] <= 11;
      memory[12] <= 12;
      memory[13] <= 13;
      memory[14] <= 14;
      memory[15] <= 15;
      memory[16] <= 0;
      memory[17] <= -1;
      memory[18] <= -2;
      memory[19] <= -3;
      memory[20] <= -4;
      memory[21] <= -5;
      memory[22] <= -6;
      memory[23] <= -7;
      memory[24] <= -8;
      memory[25] <= -9;
      memory[26] <= -10;
      memory[27] <= -11;
      memory[28] <= -12;
      memory[29] <= -13;
      memory[30] <= -14;
      memory[31] <= -15;
    end

    else begin

    // PC <== pc + 1 + (offset /zero)
    pc <= pc +1 + ((op == 2'd11)?immediate:8'd0);

    end

    end

    reg [7:0]console_buffer;

    Console disp1(high_out, console_buffer[7:4]);
    Console disp2(low_out, console_buffer[3:0]);

	 //Buses
	 wire RegDst;
   wire RegWrite;
   wire ALUSrc;
   wire Branch;
   wire MemRead;
   wire MemWrite;
   wire MemtoReg;
   wire ALUOp;
   wire [1:0]ReadRegister1;
   wire [1:0]ReadRegister2;
   wire [1:0]WriteRegister;
	 wire [7:0]MemAddress;
   wire [7:0]ALUResult;
   wire [7:0]ALUin1;
   wire [7:0]ALUin2;
	 wire [7:0]ReadData1; //reg
	 wire [7:0]ReadData2; //reg
	 wire [7:0]ReadData; //mem
	 wire [7:0]RegWriteData;
	 wire [7:0]WriteData;

   //PC
   assign PCAddess = PC; // Instruction  = Instruction Memory[PC]

   //Instruction OP code is used to generate control signals
   assign RegDst =  ~IR[6];
	 assign RegWrite = ~IR[7];
	 assign ALUSrc = IR[7] ^ IR[6];
	 assign Branch  = IR[7]& IR[6];
	 assign MemRead = (IR[7:6] == 2'b01 );
	 assign MemWrite = (IR[7:6] == 2'b10);
	 assign MemtoReg = IR[6];
	 assign ALUOp = ~(IR[7] | IR[6]);

   //Register input/output connections
   assign ReadRegister1 = IR[5:4];
   assign ReadRegister2 = IR[3:2];
   assign WriteRegister = RegDst ? IR[1:0] : IR[3:2];
   assign RegWriteData = (MemtoReg) ? ReadData : ALUResult;

   assign ReadData1 = registers[ReadRegister1];

    assign ReadData2 = registers[ReadRegister2];

   //connections into the ALU
   assign ALUin1  = ReadData1;
   assign ALUin2 = (ALUSrc) ? SignExtImm : ReadData2;
   assign ALUResult = ALUin1 + ALUin2;

   //Memory input/output values
   assign MemAddress = ALUResult;
   assign WriteData = ReadData2;
   assign ReadData = DataMemory[MemAddress];

   always @ ( posedge clock or posedge reset) begin

       else begin

       IR <= Instruction;
       PC <= Branch ? PC+1+SignExtImm : PC+1; //Evaluate PC

       if (RegWrite) begin
         case (WriteRegister)
           2'd0: GPR[0] <= RegWriteData;
           2'd1: GPR[1] <= RegWriteData;
           2'd2: GPR[2] <= RegWriteData;
           2'd3: GPR[3] <= RegWriteData;
         endcase
         console_buffer <= RegWriteData;
       end

       if (MemWrite) begin
         DataMemory[MemAddress] <= WriteData;
       end
		 end

		 end

endmodule
