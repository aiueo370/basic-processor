`timescale 1ps/1ps
//CPU

//ファイル読み込み
`include "fetch.v"
`include "decode.v"
`include "execution.v"
`include "ma.v"
`include "wb.v"

`include "adder_9.v"
`include "adder_f.v"

`include "alu_e1.v"
`include "alu_e2.v"

`include "br_judge.v"

`include "control.v"

`include "data_mem.v"

`include "forwarding.v"
`include "forwarding_ex.v"

`include "jump_j.v"

`include "i_rom.v"

`include "imm_4to9_s.v"
`include "imm_8to16_s.v"
`include "imm_8to16_u.v"
`include "imm_shift_8.v"

`include "reg_file.v"

`include "register_1.v"
`include "register_2.v"
`include "register_4.v"
`include "register_9.v"
`include "register_16.v"

`include "sel_9.v"
`include "sel_16.v"
`include "sel_16_sync.v"


module cpu (rst, clk, R1, R2, R3, R4, R5, R6, R7, R8, R9, clk_count, flag_halt);

	input rst,clk;				//リセット・クロック
	output [15:0] R1,R2,R3,R4,R5,R6,R7,R8,R9;
	output [15:0 ]clk_count;	//クロック回数
	output flag_halt;			//HALT命令フラグ

	wire [15:0] inst,wdata_m,wdata_e,fRdest,fRsrc,imm_s_8_i,imm_16s_i,imm_16u_i,wdata_w,mdata,mem1e,mem2e,mem3e,mem4e,mem5e,mem6e,mem7e,mem8e,mem9e;
	wire [8:0] pc_f,pc_i,imm_9s_i,Mem_address_e;
	wire [3:0] dest_m,dest_e,dest_i,dest_w;
	wire [1:0] alucnt_i;
	wire bj_i,we_w,we_m,we_e,aluimm_i,sel_1i,sel_2i,sel_3i,sel_4i,sel_5i,sel_6i,Mwe_i,we_i,ld_i;
	
	//FEステージ
	fetch i0 (.clk(clk),.rst(rst),.bj_i(bj_i),.pc_i(pc_i),.inst(inst),.pc_f(pc_f),.clk_count(clk_count),.flag_halt(flag_halt));
	
	//IDステージ
	decode i1 (.clk(clk),.rst(rst),.inst(inst),.pc_f(pc_f),.wdata_w(wdata_w),.dest_w(dest_w),.we_w(we_w),.we_m(we_m),.dest_m(dest_m),.wdata_m(wdata_m),.we_e(we_e),.dest_e(dest_e),.wdata_e(wdata_e),.
				fRdest(fRdest),.fRsrc(fRsrc),.imm_s_8_i(imm_s_8_i),.imm_16s_i(imm_16s_i),.imm_16u_i(imm_16u_i),.imm_9s_i(imm_9s_i),.dest_i(dest_i),.pc_i(pc_i),.alucnt_i(alucnt_i),.aluimm_i(aluimm_i),.
				sel_1i(sel_1i),.sel_2i(sel_2i),.sel_3i(sel_3i),.sel_4i(sel_4i),.sel_5i(sel_5i),.Mwe_i(Mwe_i),.we_i(we_i),.bj_i(bj_i),.
				ld_i(ld_i),.mem1e(R1),.mem2e(R2),.mem3e(R3),.mem4e(R4),.mem5e(R5),.mem6e(R6),.mem7e(R7),.mem8e(R8),.mem9e(R9));
	
	//EXステージ			
	execution i2 (.clk(clk),.rst(rst),.fRdest(fRdest),.fRsrc(fRsrc),.imm_s_8_i(imm_s_8_i),.imm_16s_i(imm_16s_i),.imm_16u_i(imm_16u_i),.imm_9s_i(imm_9s_i),.dest_i(dest_i),.alucnt_i(alucnt_i),.
				aluimm_i(aluimm_i),.sel_1i(sel_1i),.sel_2i(sel_2i),.sel_3i(sel_3i),.sel_4i(sel_4i),.sel_5i(sel_5i),.Mwe_i(Mwe_i),.we_i(we_i),.
				Mwe_e(Mwe_e),.we_e(we_e),.wdata_e(wdata_e),.Mem_address_e(Mem_address_e),.
				ld_i(ld_i),.mdata(mdata),.dest_e(dest_e));
	
	//MAステージ			
	ma i3 (.clk(clk),.rst(rst),.Mem_address_e(Mem_address_e),.wdata_e(wdata_e),.dest_e(dest_e),.we_e(we_e),.wdata_m(wdata_m),.we_m(we_m),.Mwe_e(Mwe_e),.
			mdata(mdata),.dest_m(dest_m));
	
	//WBステージ
	wb i4 (.clk(clk),.rst(rst),.wdata_m(wdata_m),.dest_m(dest_m),.we_m(we_m),.wdata_w(wdata_w),.dest_w(dest_w),.we_w(we_w));
	
endmodule

