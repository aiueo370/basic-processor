`timescale 1ps/1ps

//左８ビットシフター
module imm_shift_8 (clk, rst, in, out);

	input [7:0] in;				//入力
	input clk, rst;				//クロック・リセット
	output [15:0] out;			//出力
	reg [15:0] out;

	always @ (posedge clk or negedge rst) begin
		if(!rst)begin									//リセット
			out <= #1 16'b0;
		end
		
		else begin
			out <= #1 in << 8;							//８ビットシフト
		end
		end

endmodule