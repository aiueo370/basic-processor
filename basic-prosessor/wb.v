`timescale 1ps/1ps

module wb (clk, rst,wdata_e,dest_e,we_e,wdata_w,dest_w,we_w);

	input clk,rst;
	input [15:0] wdata_e;
	input [3:0] dest_e;
	input we_e;
	output [15:0] wdata_w;
	output [3:0] dest_w;
	output we_w;

	register_16 i0 (.clk(clk), .rst(rst), .in(wdata_e), .out(wdata_w));
	register_4 i1 (.clk(clk), .rst(rst), .in(dest_e), .out(dest_w));
	register_1 i2 (.clk(clk), .rst(rst), .in(we_e), .out(we_w));
	
endmodule

