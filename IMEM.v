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
	 
	 wire [7:0] MemByte[31:0];
	 
	 assign MemByte[0]  = {2'b01, 2'b00, 2'b10, 2'b01};


endmodule
