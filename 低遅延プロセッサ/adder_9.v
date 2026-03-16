`timescale 1ps/1ps

//９ビット加算器

module adder_9 (in0, in1, out);

	input [8:0] in0, in1;	//入力
	output [8:0] out;		//出力
	reg [8:0] out;

	always @ (in0 or in1) begin
		out <= #1 in0 + in1;	//in0とin1の加算結果を出力
	end

endmodule