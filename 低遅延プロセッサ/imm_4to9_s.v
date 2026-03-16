`timescale 1ps/1ps

//4ビットから9ビット符号拡張器
module imm_4to9_s (clk, rst, in, out);

	input [3:0] in;			//入力
	input clk, rst;			//クロック・リセット
	output [8:0] out;		//出力
	reg [8:0] out;

	always @ (posedge clk or negedge rst) begin			//同期回路
		if(!rst)begin									//リセット
			out <= #1 9'b0;
		end
		else begin
	
	case(in[3])
		1'b0:begin										//正の数なら
			out <= #1 in | 9'b00000000;
		end
		
		1'b1:begin										//負の数なら
			out <= #1 in | 9'b111110000;
		end
		
	endcase
    end
	end

endmodule