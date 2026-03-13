`timescale 1ps/1ps

//データメモリ
module data_mem (rst, in0, in1, in2, in3, out);

	input [15:0] in0;			//書き込みデータ
	input [8:0] in2;			//読み出しアドレス
	input [8:0] in3;			//書き込みアドレス
	input in1;					//書込許可
	input rst;					//リセット
	output [15:0] out;			//出力
	reg[15:0]mem[0:511];		//メモリ

	integer i;					//初期化用カウンタ
	
	always @ (*) begin
	    if(!rst)begin									//リセット
        	for(i = 0;i <= 511 ; i=i+1) begin
        		mem[i] <= 16'h0000;
          	end
          	
//初期メモリ
mem[0]  <= 16'h003b;  // 59
mem[1]  <= 16'h0057;  // 87
mem[2]  <= 16'h0002;  // 2
mem[3]  <= 16'h0062;  // 98
mem[4]  <= 16'h0044;  // 68
mem[5]  <= 16'h0030;  // 48
mem[6]  <= 16'h0054;  // 84
mem[7]  <= 16'h0016;  // 22
mem[8]  <= 16'h002a;  // 42
mem[9]  <= 16'h0045;  // 69
mem[10] <= 16'h002d;  // 45
mem[11] <= 16'h0049;  // 73
mem[12] <= 16'h0029;  // 41
mem[13] <= 16'h001f;  // 31
mem[14] <= 16'h0052;  // 82
mem[15] <= 16'h002c;  // 44
mem[16] <= 16'h005d;  // 93
mem[17] <= 16'h0048;  // 72
mem[18] <= 16'h0004;  // 4
mem[19] <= 16'h005e;  // 94
mem[20] <= 16'h001d;  // 29
mem[21] <= 16'h0038;  // 56
mem[22] <= 16'h002b;  // 43
mem[23] <= 16'h001c;  // 28
mem[24] <= 16'h0021;  // 33
mem[25] <= 16'h003d;  // 61
mem[26] <= 16'h004c;  // 76
mem[27] <= 16'h0003;  // 3
mem[28] <= 16'h0040;  // 64
mem[29] <= 16'h0034;  // 52
mem[30] <= 16'h003a;  // 58
mem[31] <= 16'h000e;  // 14

		end else begin
		
			if(in1 == 1)begin			//書き込み許可なら書き込み
				mem[in2] =  in0;
			end
		end
	end
	
	assign #1 out = mem[in3];			//出力

endmodule