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
    output mem_write,
    output mem_read,
    output reg_write,
    output [1:0]op,
    output [6:0]reg_num,
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

    //Storage elements
    reg [7:0]registers[3:0];
    reg [7:0]pc;
    reg [7:0]ir;
    reg [7:0]memory[31:0];
    reg [4:0]rw_num;

    //buses and wires
    wire [7:0]literal;
	wire [7:0]display_bus = registers[rw_num];
	 
	 
	 //7-segment display
    Console data1(rwd_1, display_bus[7:4]);
    Console data0(rwd_0, display_bus[3:0]);
    Console reg_num_(reg_num, pc[3:0]);

    //connections
    assign instruction_address = pc;
    assign immediate = {ir[1],ir[1],ir[1],ir[1],ir[1],ir[1],ir[1],ir[0]}; //signext
    assign mem_write = (op == 2'b10);
    assign mem_read = (op == 2'b01);
    assign reg_write = ~op[1];
    assign op = ir[7:6];

    always @ (posedge reset or posedge clock) begin

    if (reset) begin
      //reset pc
      pc <= 8'd0;

      //reset registers
      registers[0] <= 8'd0;
      registers[1] <= 8'd0;
      registers[2] <= 8'd0;
      registers[3] <= 8'd0;


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
	 
        ir = instruction;

        if (op == 2'b00) begin
          pc <= pc+1;
			 rw_num <= ir[1:0];
          registers[rw_num] <= registers[ir[3:2]]+registers[ir[5:4]];
        end

        else if (op == 2'b01) begin
          pc <= pc+1;
			 rw_num <= ir[3:2];
          registers[ir[3:2]] <= memory[registers[ir[5:4]]+immediate];
        end

        else if (op == 2'b10) begin
          pc <= pc+1;
			 memory[registers[ir[5:4]]+immediate] <= registers[ir[3:2]];
        end
		  
		  else begin
			pc <= pc + immediate+1;
		  end

    end
	end

endmodule
