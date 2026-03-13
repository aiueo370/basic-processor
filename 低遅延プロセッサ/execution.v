`timescale 1ps/1ps

module execution (clk, rst, fRdest, fRsrc, imm_s_8, imm_16s, imm_16u, imm_9s, pc_i, imm, dest, alu, aluimm, sel_1i, sel_2i, sel_3i, sel_4i, sel_5i, Mwe_i, we_i, wdata_e, Mem_address_e, dest_e, Mwe_e, we_e, mdata, ld);

	input [15:0] fRdest, fRsrc, imm_s_8, imm_16s, imm_16u, mdata;
	input [8:0] imm_9s, pc_i, imm;
	input [3:0] dest;
	input [1:0] alu;
	input aluimm, sel_1i, sel_2i, sel_3i, sel_4i, sel_5i, Mwe_i, we_i, clk, rst, ld;
	
	output [15:0] wdata_e;
	output [8:0] Mem_address_e;
	output [3:0] dest_e;
	output Mwe_e, we_e;
	
	wire [15:0] alu_e1_o, alu_e2_o, sel_3_o, sel_4_o, sel_5_o, sel_2_o, reg_16_2, ffRsrc, fRdest_r, fRsrc_r, mdata_e;
	wire [8:0] imm_9sr;
	wire [3:0] reg_4_1;
	wire [1:0] alu_r;
	wire sel_2, sel_3, sel_4, sel_5, Mwe, we, aluimm_r, ld_e;

	register_16 i1 (.clk(clk), .rst(rst), .in(imm_s_8), .out(reg_16_2));
	register_4 i2  (.clk(clk), .rst(rst), .in(dest), .out(reg_4_1));
	register_1 i3  (.clk(clk), .rst(rst), .in(aluimm), .out(aluimm_r));
	register_1 i4 (.clk(clk), .rst(rst), .in(sel_2i), .out(sel_2));
	register_1 i5 (.clk(clk), .rst(rst), .in(sel_3i), .out(sel_3));
	register_1 i6 (.clk(clk), .rst(rst), .in(sel_4i), .out(sel_4));
	register_1 i7 (.clk(clk), .rst(rst), .in(sel_5i), .out(sel_5));
	register_1 i8 (.clk(clk), .rst(rst), .in(Mwe_i), .out(Mwe));
	register_1 i9 (.clk(clk), .rst(rst), .in(we_i), .out(we));
	
	alu_e1 i10 (.in0(mdata_e), .in1(ffRsrc), .alucnt(alu_r), .out(alu_e1_o));
	alu_e2 i11 (.in0(mdata_e), .in1(sel_2_o), .alucnt(aluimm_r), .out(alu_e2_o));
	adder_9 i12 (.in0(ffRsrc[8:0]), .in1(imm_9sr), .out(Mem_address_e));
	sel_16_sync i13 (.clk(clk), .rst(rst), .in0(imm_16s), .in1(imm_16u), .sel(sel_1i), .out(sel_2_o));
	sel_16 i14 (.in0(alu_e1_o), .in1(sel_2_o), .sel(sel_2), .out(sel_3_o));
	sel_16 i15 (.in0(alu_e2_o), .in1(sel_3_o), .sel(sel_3), .out(sel_4_o));
	sel_16 i16 (.in0(sel_4_o), .in1(reg_16_2), .sel(sel_4), .out(sel_5_o));
	sel_16 i17 (.in0(sel_5_o), .in1(mdata_e), .sel(sel_5), .out(wdata_e));
	
	forwarding_ex i18 (.fRdest(fRdest_r), .fRsrc(fRsrc_r),.mdata(mdata), .ld_e(ld_e), .ffRdest(mdata_e), .ffRsrc(ffRsrc));
	register_1 i19 (.clk(clk), .rst(rst), .in(ld), .out(ld_e));
	register_9 i20 (.clk(clk), .rst(rst), .in(imm_9s), .out(imm_9sr));
	register_2 i21  (.clk(clk), .rst(rst), .in(alu), .out(alu_r));
	register_16 i22 (.clk(clk), .rst(rst), .in(fRdest), .out(fRdest_r));
	register_16 i23 (.clk(clk), .rst(rst), .in(fRsrc), .out(fRsrc_r));
	
	
	
	assign #1 Mwe_e = Mwe;
	assign #1 we_e = we;
	assign #1 dest_e = reg_4_1;

	
                      
endmodule