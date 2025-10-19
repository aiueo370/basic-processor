`timescale 1ps/1ps

module fetch (rst, clk, bjinst, nxtadrsr, PCd, bj);

	input [7:0] PCd;
	input rst, bj, clk;
	output [15:0] bjinst;
	output [7:0] nxtadrsr;
	wire [15:0] inst;
	wire [7:0] nxtadrs, oneadrs;

	i_rom_01 i0 (.clk(clk), .address(nxtadrs), .q(inst));
	adder_8 i1(.rst(rst), .clk(clk), .ina(nxtadrs), .inb(8'b0000001), .out(oneadrs));
	selector_8 i2(.in0(oneadrs), .in1(PCd), .out(nxtadrs), .s(bj));
	register_8 i3(.in(nxtadrs), .out(nxtadrsr), .rst(rst), .clk(clk));
	selector_16 i4(.in0(inst), .in1(16'h0000), .out(bjinst), .s(bj));
	
endmodule

