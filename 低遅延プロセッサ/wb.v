`timescale 1ps/1ps

module wb (clk, rst, wdata_m, dest_m, we_m, wdata_w, dest_w, we_w);

	input [15:0] wdata_m;
	input [3:0] dest_m;
	input we_m, rst, clk;
	
	output [15:0] wdata_w;
	output [3:0] dest_w;
	output we_w;
	
	register_16 i1 (.clk(clk), .rst(rst), .in(wdata_m), .out(wdata_w));
	register_4 i2 (.clk(clk), .rst(rst), .in(dest_m), .out(dest_w));
	register_1 i3 (.clk(clk), .rst(rst), .in(we_m), .out(we_w));
	


	
                      
endmodule