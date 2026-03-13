`timescale 1ps/1ps

//8ビットから16ビット符号無し符号拡張機
module imm_8to16_u (clk, rst, in, out);

	input [7:0] in;			//入力
	input clk,rst;			//クロック・リセット
	output [15:0] out;		//出力
	reg [15:0] out;

	always @ (posedge clk or negedge rst) begin			//同期回路
		if(!rst)begin									//リセット
			out <= #1 16'b0;
		end
		else begin
			out <= #1 in | 16'h0000;					//符号拡張
		end
	end

endmodule