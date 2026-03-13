`timescale 1ps/1ps

//算術論理演算ユニット
module alu_e1 (in0, in1, alucnt, out);

		input [15:0] in0, in1;		//入力
		input [1:0] alucnt;			//演算選択信号
		output [15:0] out;			//出力
		reg [15:0] out;

	always @ (in0 or in1 or alucnt) begin
		if(alucnt == 2'b00)begin		//ADD命令
			out <= #1 in0 + in1;
		end
		else if(alucnt == 2'b01)begin	//SUB命令
			out <= #1 in0 - in1;
		end
		else if(alucnt == 2'b10)begin	//AND命令
			out <= #1 in0 & in1;
		end
		else if(alucnt == 2'b11)begin	//OR命令
			out <= #1 in0 | in1;
		end
	end

endmodule