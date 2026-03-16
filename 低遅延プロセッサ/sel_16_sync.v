`timescale 1ps/1ps

//１６ビット同期セレクタ
module sel_16_sync (clk, rst, in0, in1, sel, out);

	input [15:0] in0, in1;			//入力
	input sel;						//セレクト信号
	input clk, rst;					//クロック・リセット
	output [15:0] out;				//出力
	reg [15:0] out;

	always @ (posedge clk or negedge rst) begin			//同期回路
	
		if(!rst)begin
				out <= #1 16'b0;						//リセット
		end
		else begin 
			if(sel == 1'b0)begin						//sel=0のときin0を出力
				out <= #1 in0;
			end
			else if(sel == 1'b1)begin					//sel=1のときin1を出力
				out <= #1 in1;
			end
		end
	end


endmodule