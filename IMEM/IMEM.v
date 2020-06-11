`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    19:08:42 06/05/2020
// Design Name:
// Module Name:    IMEM
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
module IMEM(
    output [7:0] instruction,
    input [7:0] Read_Address
    );

	 wire [7:0] MemByte[31:0]; //32 words(bytes) of memory, just example..

   ///// Basic Operation Test Set ////

   // lw $s2, 1($s0)
	 assign MemByte[0]  = {2'b01, 2'b00, 2'b10, 2'b01};

   // j + 1
   assign MemByte[1]  = {2'b11, 2'b00, 2'b00, 2'b01};

   // add $s0, $s1 $s2
   assign MemByte[2]  = {2'b00, 2'b01, 2'b10, 2'b00};

   // sw $s2, 1($s2)
   assign MemByte[3]  = {2'b10, 2'b10, 2'b10, 2'b01};

   // lw $s3, 1($s0)
   assign MemByte[4]  = {2'b01, 2'b00, 2'b11, 2'b01};

   assign instruction = MemByte[Read_Address];

endmodule
