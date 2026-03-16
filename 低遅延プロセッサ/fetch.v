`timescale 1ps/1ps

//FEステージ
module fetch (clk, rst, inst, pc_f, bj_i, pc_i, clk_count, flag_halt);

	input [8:0] pc_i;					//条件分岐後のプログラムカウンタ
    input clk, rst;						//クロック・リセット
    input bj_i;							//条件分岐判定フラグ
    output [15:0] inst;					//フェッチした命令
    output [15:0] clk_count;			//クロック回数
    output [8:0] pc_f;					//命令フェッチ用のプログラムカウンタ
    output flag_halt;					//HALT命令用フラグ
    
    //配線
    wire [15:0] pc_q;
    wire [8:0] pc, nxtadrs1, nxtadrs2, jm, pc_f, jm_pc;
    wire flag1, jm_j;
    
    //同期回路化
    i_rom i0 (.address(pc), .q(pc_q), .clk(clk),.flagin(flag1),.clk_count(clk_count),.flagout(flag_halt));			//命令メモリ
    adder_f i1 (.clk(clk), .rst(rst), .in0(pc), .in1(9'b000000001), .out(nxtadrs1), .flagin(flag_halt),.flagout(flag1));		//フェッチ用プログラムカウンタ加算
    register_9 i3(.clk(clk),.rst(rst),.in(pc),.out(pc_f));
    
    sel_9 i4(.in1(pc_i), .in0(nxtadrs2), .sel(bj_i), .out(pc));				//条件分岐命令かそれ以外のプログラムカウンタの選択
    sel_16 i5(.in0(pc_q), .in1(16'h0000), .sel(bj_i), .out(inst));			//条件分岐成立後の命令のいらない命令の取り消し
    
    jump_j i6(.in(inst), .out1(jm_j), .out2(jm));						//JUMP命令のジャンプ後プログラムカウンタとフラグ
    adder_9 i7(.in0(jm), .in1(pc_f), .out(jm_pc));						//JUMP命令のジャンプ先計算
    sel_9 i8(.in0(nxtadrs1), .in1(jm_pc), .sel(jm_j), .out(nxtadrs2));		//JUMP命令かそれ以外のプログラムカウンタの選択
    
    
    
endmodule

