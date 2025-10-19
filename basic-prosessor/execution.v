`timescale 1ps/1ps


module execution (rst, clk, do1, do2, imm, dest, alucnt, sel, wes, wdata_e, dest_e, we_e, disp8, PCd, nxtadrsrr, branchs, bj);
	
	input [15:0]  do1, do2, imm;
	input [7:0] disp8, nxtadrsrr;
	input [3:0] dest;
	input [1:0] alucnt, branchs;
	input sel, wes, rst, clk;
	output [15:0] wdata_e;
	output [7:0] PCd;
	output [3:0] dest_e;
	output we_e, bj;
	wire  [15:0] alu16,immr;
	wire selr;

	register_16 i0 (.in(imm), .clk(clk), .rst(rst), .out(immr));
	register_4 i1 (.in(dest), .clk(clk), .rst(rst), .out(dest_e));
	register_1 i2 (.in(sel), .clk(clk), .rst(rst), .out(selr));
	register_1 i3 (.in(wes), .clk(clk), .rst(rst), .out(we_e));
	alu i4 (.ina(do1), .inb(do2), .clk(clk), .rst(rst), .alucnt(alucnt), .out(alu16));
	adder_8 i5(.rst(rst), .clk(clk), .ina(disp8), .inb(nxtadrsrr), .out(PCd));
	branch i6(.ina(do1), .inb(do2), .branch(branchs), .bj(bj), .clk(clk), .rst(rst));
	selector_16 i7(.in0(alu16), .in1(immr), .out(wdata_e), .s(selr));

endmodule

