`timescale 1ps/1ps



module decode (dest_i, wdata_w, inst, dest_w, we_w, rst, clk, bj_i, fRdest, fRsrc, imm_s_8_i, imm_16s_i, imm_16u_i, imm_9s_i, alucnt_i, sel_1i, sel_2i, sel_3i, sel_4i, sel_5i, aluimm_i
                ,we_i, Mwe_i, pc_f, pc_i, we_m, dest_m, wdata_m, we_e, dest_e, wdata_e, ld_i, mem1e, mem2e, mem3e, mem4e, mem5e, mem6e, mem7e, mem8e, mem9e);

	input [15:0] inst;							//読み出し命令
	input [15:0] wdata_w, wdata_m, wdata_e;		//WE,MA,EXからの書き込みデータ
	input [8:0] pc_f;							//FEからのプログラムカウンタ
	input [3:0] dest_w, dest_m, dest_e;			//WE,MA,EXからのレジスタ番号
	input rst,clk;								//リセット・クロック
	input we_w, we_m, we_e;						//WE,MA,EXからの書込許可
	
	output [15:0] fRdest,fRsrc;					//フォワーディング後の読み出しデータ
	output [15:0] imm_s_8_i;					//LUI命令用オペランド
	output [15:0] imm_16s_i;					//即値演算用オペランド
	output [15:0] imm_16u_i;					//ADDIU用オペランド
	output [15:0] mem1e,mem2e,mem3e,mem4e,mem5e,mem6e,mem7e,mem8e,mem9e;	//CPU出力
	output [8:0] imm_9s_i;						//9ビット計算用オペランド
	output [8:0] pc_i;							//条件分岐後のプログラムカウンタ
	output [3:0] dest_i;						//書き込みレジスタ番号
	output [1:0] alucnt_i;						//ALU演算選択信号
	output sel_1i, sel_2i, sel_3i, sel_4i, sel_5i;	//セレクタ選択信号
	output aluimm_i;							//即値演算ALU選択信号
	output we_i;								//レジスタの書き込み許可
	output Mwe_i;								//データメモリの書き込み許可
	output bj_i;								//条件分岐判定信号
	output ld_i;								//LD命令判定信号
	
	//配線
	wire [15:0] Rdest,Rsrc;
	wire [15:0] imm_s_8,imm_16s,imm_16u;
	wire [8:0] pc_fi;
	wire [8:0] imm_9s;
	wire [3:0] src;
	wire [3:0] dest;
	wire [1:0] alucnt;
	wire [1:0] br;
	wire rst_flag;
	wire sel_1,sel_2,sel_3,sel_4,sel_5,aluimm,we,Mwe,bj,ld;
	
	//同期回路化
	reg_file i1 (.rst(rst),.in(wdata_w),.wad(dest_w),.we(we_w),.rad1(dest),.rad2(src),.out1(Rdest),.out2(Rsrc),.out3(mem1e),.out4(mem2e),.out5(mem3e),.out6(mem4e),.out7(mem5e),.out8(mem6e),.out9(mem7e),.out10(mem8e),.out11(mem9e));			//レジスタファイル
	imm_shift_8 i2 (.clk(clk),.rst(rst),.in(inst[7:0]),.out(imm_s_8));				//LUI命令用8ビットシフト
	imm_8to16_s i3 (.clk(clk),.rst(rst),.in(inst[7:0]),.out(imm_16s));				//即値演算用8から16ビット符号拡張
	imm_8to16_u i4 (.clk(clk),.rst(rst),.in(inst[7:0]),.out(imm_16u));				//符号なし即値演算8から16ビット符号無し符号拡張
	imm_4to9_s i5 (.clk(clk),.rst(rst),.in(inst[3:0]),.out(imm_9s));				//メモリ呼び出し,またはジャンプ先用4から9ビット符号拡張
	register_9 i10 (.clk(clk),.rst(rst),.in(pc_f),.out(pc_fi));
	register_4 i14 (.clk(clk),.rst(rst),.in(inst[11:8]),.out(dest));
	register_4 i15 (.clk(clk),.rst(rst),.in(inst[7:4]),.out(src));
	control i6 (.clk(clk),.rst(rst),.opcd(inst[15:12]),.alucnt(alucnt),.sel_1(sel_1),.sel_2(sel_2),.sel_3(sel_3),.sel_4(sel_4),.sel_5(sel_5),.aluimm(aluimm),.Mwe(Mwe),.we(we),.rst_flag(rst_flag),.br(br),.ld(ld));			//命令解読
	
	forwarding i11 (.we_e(we_e),.dest_e(dest_e),.wdata_e(wdata_e),.we_m(we_m),.dest_m(dest_m),.wdata_m(wdata_m),.dest(dest),.src(src),.fRdest(fRdest),.fRsrc(fRsrc),.Rdest(Rdest),.Rsrc(Rsrc));				//フォワーディング
	
	br_judge i16 (.in0(fRdest),.in1(fRsrc),.out(bj_i),.rst_flag(rst_flag),.br(br));				//条件分岐判定
	adder_9 i17(.in0(imm_9s),.in1(pc_fi),.out(pc_i));											//ジャンプ先計算用加算器
	
	//出力遅延
	assign #1 dest_i = dest;
	assign #1 imm_s_8_i = imm_s_8;
	assign #1 imm_16s_i = imm_16s;
	assign #1 imm_16u_i = imm_16u;
	assign #1 imm_9s_i = imm_9s;
	assign #1 alucnt_i = alucnt;
	assign #1 aluimm_i = aluimm;
	assign #1 sel_1i = sel_1;
	assign #1 sel_2i = sel_2;
	assign #1 sel_3i = sel_3;
	assign #1 sel_4i = sel_4;
	assign #1 sel_5i = sel_5;
	assign #1 we_i = we;
	assign #1 Mwe_i = Mwe;
	assign #1 ld_i = ld;
                      
endmodule