`timescale 1ps/1ps



module decode (dest, wdata_w, inst, dest_w, we_w, rst, clk, bj_i, fRdest, fRsrc, imm_s_8, imm_16s, imm_16u, imm_9s, alucnt, sel_1i, sel_2i, sel_3i, sel_4i, sel_5i, aluimm
                ,we_i, Mwe_i, pc_f, pc_i, imm, we_m, dest_m, wdata_m, we_e, dest_e, wdata_e, ld, mem1e, mem2e, mem3e, mem4e, mem5e, mem6e, mem7e, mem8e, mem9e);

	input [15:0] inst, wdata_w, wdata_m, wdata_e;
	input [8:0] pc_f;
	input [3:0] dest_w, dest_m, dest_e;
	input rst,clk,we_w, we_m, we_e;
	
	output [15:0] fRdest,fRsrc,imm_s_8,imm_16s,imm_16u,mem1e,mem2e,mem3e,mem4e,mem5e,mem6e,mem7e,mem8e,mem9e;
	output [8:0] imm_9s,pc_i,imm;
	output [3:0] dest;
	output [1:0] alucnt;
	output sel_1i,sel_2i,sel_3i,sel_4i,sel_5i,aluimm,we_i,Mwe_i,bj_i,ld;
	
	wire [15:0] Rdest,Rsrc;
	wire [8:0] pc_fi;
	wire [3:0] src;
	wire [1:0] br;
	wire rst_flag;
	
	reg_file i1 (.rst(rst),.in(wdata_w),.wad(dest_w),.we(we_w),.rad1(dest),.rad2(src),.out1(Rdest),.out2(Rsrc),.out3(mem1e),.out4(mem2e),.out5(mem3e),.out6(mem4e),.out7(mem5e),.out8(mem6e),.out9(mem7e),.out10(mem8e),.out11(mem9e));
	imm_shift_8 i2 (.clk(clk),.rst(rst),.in(inst[7:0]),.out(imm_s_8));
	imm_8to16_s i3 (.clk(clk),.rst(rst),.in(inst[7:0]),.out(imm_16s));
	imm_8to16_u i4 (.clk(clk),.rst(rst),.in(inst[7:0]),.out(imm_16u));
	imm_4to9_s i5 (.clk(clk),.rst(rst),.in(inst[3:0]),.out(imm_9s));
	control i6 (.clk(clk),.rst(rst),.opcd(inst[15:12]),.alucnt(alucnt),.sel_1(sel_1i),.sel_2(sel_2i),.sel_3(sel_3i),.sel_4(sel_4i),.sel_5(sel_5i),.aluimm(aluimm),.Mem_we(Mwe_i),.we(we_i),.rst_flag(rst_flag),.br(br),.ld(ld));
	
	//フォワーディング
	forwarding i11 (.we_e(we_e),.dest_e(dest_e),.wdata_e(wdata_e),.we_m(we_m),.dest_m(dest_m),.wdata_m(wdata_m),.dest(dest),.src(src),.fRdest(fRdest),.fRsrc(fRsrc),.Rdest(Rdest),.Rsrc(Rsrc));
	
	register_4 i14 (.clk(clk),.rst(rst),.in(inst[11:8]),.out(dest));
	register_4 i15 (.clk(clk),.rst(rst),.in(inst[7:4]),.out(src));
	
	//条件分岐命令
	register_9 i10 (.clk(clk),.rst(rst),.in(pc_f),.out(pc_fi));
	br_judge i16 (.in0(fRdest),.in1(fRsrc),.out(bj_i),.rst_flag(rst_flag),.br(br));
	adder_9 i17(.in0(imm_9s),.in1(pc_fi),.out(pc_i));
                      
endmodule