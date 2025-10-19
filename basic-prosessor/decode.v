`timescale 1ps/1ps

module decode (wdata_w, dest_w, we_w, rst, clk, bjinst, nxtadrsr, bj, imm, nxtadrsrr, alucnt, sel, wes, disp8, branchs, dest, bj, do1, do2);

	input [15:0] wdata_w, bjinst;
	input [7:0] nxtadrsr;
	input[3:0] dest_w;
	input we_w, rst, clk, bj;
	output [15:0] imm, do1 ,do2;
	output [7:0] disp8, nxtadrsrr;
	output [3:0] dest;
	output [1:0] alucnt, branchs;
	output sel, wes;
	wire [15:0] do1, do2;
	wire [3:0] dest_r, src_r;
	wire [1:0] branch;
	wire we;

	reg_file  i0 (.in(wdata_w), .wad(dest_w), .we(we_w), .rad1(dest_r), .rad2(src_r), .out1(do1), .out2(do2), .clk(clk), .rst(rst));
	register_4 i1 (.rst(rst), .clk(clk), .in(bjinst[11:8]), .out(dest));
    extend_16 i2 (.in(bjinst[7:0]), .out(imm), .clk(clk), .rst(rst));
    control i3 (.opcd(bjinst[15:12]), .alucnt(alucnt), .sel(sel), .we(we), .branch(branch), .clk(clk), .rst(rst));
    selector_1 i4 (.in0(we), .in1(1'b0), .out(wes), .s(bj));
    selector_2 i5 (.in0(branch), .in1(2'b00), .out(branchs), .s(bj));
    extend_8 i6 (.rst(rst), .clk(clk), .in(bjinst[3:0]), .out(disp8));
    register_8 i7 (.rst(rst), .clk(clk), .in(nxtadrsr), .out(nxtadrsrr));
    register_4 i8 (.rst(rst), .clk(clk), .in(bjinst[11:8]), .out(dest_r));
    register_4 i9 (.rst(rst), .clk(clk), .in(bjinst[7:4]), .out(src_r));
   
endmodule
