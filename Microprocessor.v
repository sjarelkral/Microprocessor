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
    output [7:0]PCAddess,
    output [6:0]high_out,
    output [6:0]low_out,
    input oscillator50Mhz,
    input reset,
    input [7:0]Instruction
    );

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
	 wire [7:0]SignExtImm;

	 //Registers
	 reg [7:0]GPR[3:0];
	 reg [7:0]PC;
   reg [7:0]DataMemory[31:0];

   //Clock Generator
   reg [25:0] delay;
   reg sec;
   always @(posedge oscillator50Mhz)begin
   	delay  <= (delay == 25000000)?26'd0:(delay+1);
   	if (delay == 26'd0)begin
   		sec <= ~sec;
   	end
   end
   assign clock = sec;
   
   //PC
   assign PCAddess = PC; // Instruction  = Instruction Memory[PC]

   //Instruction OP code is used to generate control signals
   assign RegDst =  ~Instruction[6];
	 assign RegWrite = ~Instruction[7];
	 assign ALUSrc = Instruction[7] ^ Instruction[6];
	 assign Branch  = Instruction[7]& Instruction[6];
	 assign MemRead = (Instruction[7:6] == 2'b01 );
	 assign MemWrite = (Instruction[7:6] == 2'b10);
	 assign MemtoReg = Instruction[6];
	 assign ALUOp = ~(Instruction[7] | Instruction[6]);

   //Register input/output connections
   assign ReadRegister1 = Instruction[5:4];
   assign ReadRegister2 = Instruction[3:2];
   assign WriteRegister = RegDst ? Instruction[1:0] : Instruction[3:2];
   assign RegWriteData = (MemtoReg) ? ReadData : ALUResult;

   assign ReadData1 = (ReadRegister1 == 2'd0) ? GPR[0]:
                      (ReadRegister1 == 2'd1) ? GPR[1]:
                      (ReadRegister1 == 2'd2) ? GPR[2]:
                      (ReadRegister1 == 2'd3) ? GPR[3];

    assign ReadData2 = (ReadRegister2 == 2'd0) ? GPR[0]:
                      (ReadRegister2 == 2'd1) ? GPR[1]:
                      (ReadRegister2 == 2'd2) ? GPR[2]:
                      (ReadRegister2 == 2'd3) ? GPR[3];


   //Sign extend Instruction [1:0]
   assign SignExtImm[1:0] = Instruction[1:0];
   assign SignExtImm[7:2] = (Instruction[1]) ? 6'b111111 : 6'b000000;

   //connections into the ALU
   assign ALUin1  = ReadData1;
   assign ALUin2 = (ALUSrc) ? SignExtImm : ReadData2;
   assign ALUResult = ALUin1 + ALUin2;

   //Memory input/output values
   assign MemAddress = ALUResult;
   assign WriteData = ReadData2;
   assign ReadData = DataMemory[MemAddress];

   always @ ( posedge clock or posedge reset) begin
      if (reset)begin

        //Reset PC
        PC <= 8'd0;

        //Reset registers
        GPR[0] <= 8'd0;
        GPR[1] <= 8'd0;
        GPR[2] <= 8'd0;
        GPR[3] <= 8'd0;

         //Reinitialize memory;
         DataMemory[0] <= 8'd0;
         DataMemory[1] <= 8'd1;
         DataMemory[2] <= 8'd2;
         DataMemory[3] <= 8'd3;
         DataMemory[4] <= 8'd4;
         DataMemory[5] <= 8'd5;
         DataMemory[6] <= 8'd6;
         DataMemory[7] <= 8'd7;
         DataMemory[8] <= 8'd8;
         DataMemory[9] <= 8'd9;
         DataMemory[10] <= 8'd10;
         DataMemory[11] <= 8'd11;
         DataMemory[12] <= 8'd12;
         DataMemory[13] <= 8'd13;
         DataMemory[14] <= 8'd14;
         DataMemory[15] <= 8'd15;
         DataMemory[16] <= 8'd16;
         DataMemory[17] <= 8'd17;
         DataMemory[18] <= 8'd18;
         DataMemory[19] <= 8'd19;
         DataMemory[20] <= 8'd20;
         DataMemory[21] <= 8'd21;
         DataMemory[22] <= 8'd22;
         DataMemory[23] <= 8'd23;
         DataMemory[24] <= 8'd24;
         DataMemory[25] <= 8'd25;
         DataMemory[26] <= 8'd26;
         DataMemory[27] <= 8'd27;
         DataMemory[28] <= 8'd28;
         DataMemory[29] <= 8'd29;
         DataMemory[30] <= 8'd30;
         DataMemory[31] <= 8'd31;
       end

       else begin

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

endmodule
