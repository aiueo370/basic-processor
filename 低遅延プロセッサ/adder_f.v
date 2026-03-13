`timescale 1ps/1ps

//HALT命令用加算器
module adder_f (clk, rst, in0, in1, out, flagin, flagout);

	input [8:0] in0, in1;		//入力
	input clk, rst;				//クロック・リセット
	input flagin;				//HALT命令用入力フラグ
	output flagout;				//HALT命令用出力フラグ
	output [8:0] out;			//出力
	reg flagout;
	reg [8:0] out;

	always @ (negedge rst or posedge clk) begin		//同期回路
	
		if(!rst) begin				//リセットなら出力とフラグを初期化
			out <= #1 9'h0;
			flagout <= #1 1'b0;
			
		end else begin
			if(flagin == 1'b1)begin		//フラグが立つ
				out <=#1 in0;			//加算無し
			end	else begin				//そうでないなら
				out <=#1 in0 + in1;		//加算
			end
		end
	end

endmodule