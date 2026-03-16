`timescale 1ps/1ps

//レジスタファイル
module reg_file (rst, in, wad, we, rad1, rad2, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11);

		input [15:0] in;					//入力
		input [3:0] wad;					//書き込みアドレス
		input we;							//書き込み許可
		input rst;							//リセット
		input [3:0] rad1, rad2;				//演算用出力データ
		output [15:0] out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11;		//CPU出力
		
		//配線
		reg[15:0] out3, out4, out5, out6, out7, out8, out9, out10, out11;
		reg[15:0]  mem[15:0];		//ファイルの生成
		
		integer i;			//ループ用カウンタ
		
	    always @ (rst or in or wad or we or rad1 or rad2) begin
        
        	if(!rst) begin				//リセットで初期化
               	for(i = 0;i <= 15 ; i=i+1) begin
                  	mem[i] <= 16'h0000;
               	end
          	 end
        
			if(we == 1)begin
				if(wad != 0)begin
					mem[wad] <=  in;		//アドレスが0でなければinを代入する
				end else begin
					mem[wad] <= 16'h0;		//ゼロレジスタ
				end
			end
			
			//CPU出力
			out3 <= mem[1];
			out4 <= mem[2];
			out5 <= mem[3];
			out6 <= mem[4];
			out7 <= mem[5];
			out8 <= mem[6];
			out9 <= mem[7];
			out10 <= mem[8];
			out11 <= mem[9];
			
		end
		
		//演算用出力
		assign #1 out1 = mem[rad1];
		assign #1 out2 = mem[rad2];


endmodule