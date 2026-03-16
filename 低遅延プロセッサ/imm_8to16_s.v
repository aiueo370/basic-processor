`timescale 1ps/1ps

//8ビットから16ビット符号拡張機
module imm_8to16_s (clk, rst, in, out);

	input [7:0] in;			//入力
	input clk, rst;			//クロック・リセット
	output [15:0] out;		//出力
	reg [15:0] out;

	always @ (posedge clk or negedge rst) begin			//同期回路
		if(!rst)begin									//リセット
			out <= #1 16'b0;
		end
		else begin

		case(in[7])
			1'b0:begin										//正の数なら
			out <= #1 in | 16'h0000;
		end
			1'b1:begin										//負の数なら
			out <= #1 in | 16'hFF00;
		end
				
		endcase
		end
	end

endmodule