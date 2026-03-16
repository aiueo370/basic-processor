`timescale 1ps/1ps

//１６ビットセレクタ
module sel_16 (in0, in1, sel, out);

	input [15:0] in0, in1;			//入力
	input sel;						//セレクト信号
	output [15:0] out;				//出力
	reg [15:0] out;

	always @ (in0 or in1 or sel) begin
		if(sel == 1'b0)begin			//sel=0のときin0を出力
			out <= #1 in0;
		end
		else if(sel == 1'b1)begin		//sel=1のときin1を出力
			out <= #1 in1;
		end

	end


endmodule