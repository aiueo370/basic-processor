`timescale 1ps/1ps
//BGT
module i_rom (clk,flagin,flagout, address, q,clk_count);

  input         clk,flagin;
  input [8:0]   address;
  output [15:0] q,clk_count ;
 
  output flagout;//HALT命令確認のフラグ
  
  
  reg [15:0]  core[0:511], q;
  
  integer i = 1'b0;//flagが一度立った降ろさないように制御する
  integer clk_counter = 16'd0;
  integer flag_out =1'b0;
  
  initial begin
 
//R0 	ゼロレジスタ
//R1 	i 				外側ループのカウンタ
//R2	j 				内側ループのカウンタ
//R3 	indexMin 		暫定最小値のインデックス
//R4	array[indexMin]	暫定最小値の値
//R5	w 				
//R6	array[i]		スワップ用(比較用値 外ループ)
//R7	array[j]		スワップ用(比較用値 内ループ)
//R8	30 				データメモリの数(i用)
//R9 	31 				データメモリの数(k用)


//初期値
core[0]  = 16'h881F;		// LI R8, 31
core[1]  = 16'h1980;		// ADD R9 R8
core[2]  = 16'h5901;		// ADDIU R9 1

//外側ループ
core[3]  = 16'hD812;		// BGT R8>R1 外側ループへ　　ジャンプ
core[4]  = 16'hE01A;		// ソートエンドへ           　　ジャンプ  					///

//続き外側ループ
core[5] = 16'h1210;		// ADD R2,R1 
core[6] = 16'h5201;		// ADDI R2 + 1  i+1 → j jの値を格納する
core[7]  = 16'h8300;		// R3  初期化
core[8]  = 16'h1310;		// ADD R3,R1  iをindexMinにする
//core[9]  = 16'h8400;		// R4  初期化
core[9]  = 16'hA610;		// LD R6 ← Mem[i] i番地の値を格納
core[10]  = 16'hA430;		// LD R4 ← Mem[indexMin] 暫定最小値を格納


core[11] = 16'hA720;		// LD R7 ← Mem[j] j番地の値を格納

//内側ループ
core[12] = 16'hD922;		// BGT R9>R2 -> 32>kならば内側ループを継続		///　　ジャンプ
core[13] = 16'hE00A;		// 32<=kならばスワップへ						///　　ジャンプ

//続き内側ループ1

core[14] = 16'hD474;		// BGT R4 > R7  最小値>比較値→(中継)最小更新へ	///　　ジャンプ


//そうでなければ内側ループ2
core[15] = 16'h5201;		// ADDI R2 1 j+1→j
core[16] = 16'hA720;		// LD R7 ← Mem[j] j番地の値を格納
core[17] = 16'hE1FB;		// 内側ループへ									///　　ジャンプ

//最小更新
core[18] = 16'h8400;		// LI R4 0 初期化  暫定最小値をリセット
core[19] = 16'h8300;		// LI R3 0 初期化  暫定最小値のインデックスをリセット
core[20] = 16'h1320;		// ADD R3 R2       内側ループのカウンタ→暫定最小値のインデックス
core[21] = 16'hA430;		// LD R4 ← Mem[indexMin] 暫定最小値を格納 更新
core[22] = 16'hE1FA;		// 内側ループ続2へ								///　　ジャンプ

//スワップ
//w(R5)に一時退避
core[23] = 16'h8500; 	    // LI 5 0　w 初期化
core[24] = 16'h1560;		    // ADD R5←R6 w← indexMin

//最小値を現在の先頭にストアする
core[25] = 16'hB410;		// ST R4 R1  mem[i] = array[indexMin]

//退避していた値wを最小値の場所へ
core[26] = 16'hB530;		// ST R5 R3  mem[indexMin] = w = array[i]

//iの値を更新
core[27] = 16'h5101;		// ADDI R1 1 i+1→i

core[28] = 16'h8200;		//R2を初期化

core[29] = 16'hE1E6;		//外側ループへ									///　　ジャンプ

//ソートエンド(データメモリをレジスタに出力)
core[30]=  16'hD784;			//BGT R7>R8　　ジャンプ
core[31] = 16'hA170;		// LD R1 R7
core[32] = 16'h5701;
core[33] = 16'hE1FD;//　　ジャンプ
core[34] = 16'hF000;



   end
   
   assign clk_count = clk_counter;
   assign flagout = flag_out;
 
   always @ (posedge clk)  begin
   if(flagin == 1'b0)begin
	if(i != 1'b1)begin
	
		
		
	
		if(core[address] != 16'hF000 )begin
			clk_counter <= clk_counter + 1'b1;
			q <= #1 core[address];
			flag_out <= #1 1'b0;
		end else begin
			flag_out <= #1 1'b1;//フラグを立てる
			i <= #1 1'b1;

		end
	end
	end else begin
		q <= #1 16'h0;
        
	end
	end

endmodule