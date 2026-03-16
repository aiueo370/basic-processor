`timescale 1ps/1ps

module execution (clk, rst, fRdest, fRsrc, imm_s_8_i, imm_16s_i, imm_16u_i, imm_9s_i, dest_i, alucnt_i, aluimm_i, sel_1i, sel_2i, sel_3i, sel_4i, sel_5i, Mwe_i, we_i, wdata_e, Mem_address_e, dest_e, Mwe_e, we_e, mdata, ld_i);

	input [15:0] fRdest, fRsrc;					//レジスタ読み出しデータ
	input [15:0] imm_s_8_i;						//LUI命令用オペランド
	input [15:0] imm_16s_i;						//即値演算用オペランド
	input [15:0] imm_16u_i;						//ADDIU用オペランド
	input [15:0] mdata;							//データメモリ出力
	input [8:0] imm_9s_i;						//9ビット計算用オペランド
	input [3:0] dest_i;							//書き込みレジスタアドレス
	input [1:0] alucnt_i;						//ALU選択信号
	input aluimm_i, sel_1i, sel_2i, sel_3i, sel_4i, sel_5i;		//セレクタ選択信号
	input Mwe_i;								//データメモリの書き込み許可
	input we_i;									//レジスタ書き込み許可
	input clk, rst;								//クロック・リセット
	input ld_i;									//LD命令判定
	
	output [15:0] wdata_e;						//演算結果
	output [8:0] Mem_address_e;					//選択データメモリアドレス
	output [3:0] dest_e;						//書き込みレジスタアドレス
	output Mwe_e;								//データメモリ書き込み許可
	output we_e;								//レジスタファイル書き込み許可
	
	//配線
	wire [15:0] alu_e1_o, alu_e2_o, sel_1_o, sel_2_o, sel_3_o, sel_4_o, sel_5_o, reg_16_2, ffRsrc, fRdest_r, fRsrc_r, mdata_e;
	wire [8:0] imm_9s;
	wire [3:0] dest;
	wire [1:0] alucnt;
	wire sel_2, sel_3, sel_4, sel_5, Mwe, we, aluimm, ld;
	
	//同期回路化
	register_16 i1 (.clk(clk), .rst(rst), .in(imm_s_8_i), .out(reg_16_2));
	register_4 i2  (.clk(clk), .rst(rst), .in(dest_i), .out(dest));
	register_1 i3  (.clk(clk), .rst(rst), .in(aluimm_i), .out(aluimm));
	register_1 i4 (.clk(clk), .rst(rst), .in(sel_2i), .out(sel_2));
	register_1 i5 (.clk(clk), .rst(rst), .in(sel_3i), .out(sel_3));
	register_1 i6 (.clk(clk), .rst(rst), .in(sel_4i), .out(sel_4));
	register_1 i7 (.clk(clk), .rst(rst), .in(sel_5i), .out(sel_5));
	register_1 i8 (.clk(clk), .rst(rst), .in(Mwe_i), .out(Mwe));
	register_1 i9 (.clk(clk), .rst(rst), .in(we_i), .out(we));
	register_1 i10 (.clk(clk), .rst(rst), .in(ld_i), .out(ld));
	register_9 i11 (.clk(clk), .rst(rst), .in(imm_9s_i), .out(imm_9s));
	register_2 i12  (.clk(clk), .rst(rst), .in(alucnt_i), .out(alucnt));
	register_16 i13 (.clk(clk), .rst(rst), .in(fRdest), .out(fRdest_r));
	register_16 i14 (.clk(clk), .rst(rst), .in(fRsrc), .out(fRsrc_r));
	sel_16_sync i15 (.clk(clk), .rst(rst), .in0(imm_16s_i), .in1(imm_16u_i), .sel(sel_1i), .out(sel_1_o));		//ADDIかADDIUの選択
	
	alu_e1 i16 (.in0(mdata_e), .in1(ffRsrc), .alucnt(alucnt), .out(alu_e1_o));			//ADDかSUBかANDかORの選択
	
	alu_e2 i17 (.in0(mdata_e), .in1(sel_1_o), .alucnt(aluimm), .out(alu_e2_o));			//(ADDI,ADDIU)か(SUBI)の選択
	adder_9 i18 (.in0(ffRsrc[8:0]), .in1(imm_9s), .out(Mem_address_e));					//データメモリアドレスの演算
	sel_16 i19 (.in0(alu_e1_o), .in1(sel_1_o), .sel(sel_2), .out(sel_2_o));				//(ADD,SUB,AND,OR)か(LI)の選択
	sel_16 i20 (.in0(alu_e2_o), .in1(sel_2_o), .sel(sel_3), .out(sel_3_o));				//(ADDI,ADDIU)か(ADD,SUB,AND,OR,LI)の選択
	sel_16 i21 (.in0(sel_3_o), .in1(reg_16_2), .sel(sel_4), .out(sel_4_o));				//(ADDI,ADDIU,ADD,SUB,AND,OR,LI)か(LUI)の選択
	sel_16 i22 (.in0(sel_4_o), .in1(mdata_e), .sel(sel_5), .out(wdata_e));				//(ADDI,ADDIU,ADD,SUB,AND,OR,LI,LUI)か(LD,ST)の選択
	
	forwarding_ex i23 (.fRdest(fRdest_r), .fRsrc(fRsrc_r),.mdata(mdata), .ld_e(ld), .ffRdest(mdata_e), .ffRsrc(ffRsrc));		//LD命令フォワーディング
	
	//遅延
	assign #1 Mwe_e = Mwe;
	assign #1 we_e = we;
	assign #1 dest_e = dest;

	
                      
endmodule