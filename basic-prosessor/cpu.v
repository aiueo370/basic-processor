`timescale 1ps/1ps

`include "i_rom_01.v"
`include "adder_8.v"
`include "selector_8.v"
`include "register_8.v"
`include "selector_16.v"

`include "register_4.v"
`include "reg_file.v"
`include "extend_16.v"
`include "control.v"
`include "selector_1.v"
`include "selector_2.v"
`include "extend_8.v"

`include "register_16.v"
`include "register_1.v"
`include "alu.v"
`include "branch.v"

`include "fetch.v"
`include "decode.v"
`include "execution.v"
`include "wb.v"

module cpu (rst, clk, inst, wdata_w);

	input rst, clk;
	output [15:0] wdata_w, inst;
	wire [15:0] imm, bjinst, do1, do2, wdata_e;
	wire [7:0] PCd, disp8, nxtadrsr, nxtadrsrr;
	wire [3:0] dest, dest_e, dest_w;
	wire [1:0] alucnt, branchs;
	wire wes, sel, we_e, we_w, bj;

	fetch i0 (.clk(clk), .rst(rst), .bjinst(inst), .PCd(PCd), .bj(bj), .nxtadrsr(nxtadrsr));
	decode i1 (.clk(clk), .rst(rst), .wdata_w(wdata_w), .dest_w(dest_w), .we_w(we_w), .do2(do2), .do1(do1), .imm(imm), .dest(dest), .alucnt(alucnt), .sel(sel), .wes(wes), .bjinst(inst), .disp8(disp8), .nxtadrsr(nxtadrsr), .nxtadrsrr(nxtadrsrr), .bj(bj), .branchs(branchs));
	execution i2(.clk(clk), .rst(rst), .do2(do2), .do1(do1), .imm(imm), .dest(dest), .alucnt(alucnt), .sel(sel), .wes(wes), .disp8(disp8), .wdata_e(wdata_e), .dest_e(dest_e), .we_e(we_e), .nxtadrsrr(nxtadrsrr), .branchs(branchs), .PCd(PCd), .bj(bj));
	wb i3(.clk(clk), .rst(rst), .wdata_e(wdata_e), .dest_e(dest_e), .we_e(we_e), .wdata_w(wdata_w), .dest_w(dest_w), .we_w(we_w));
	
endmodule

