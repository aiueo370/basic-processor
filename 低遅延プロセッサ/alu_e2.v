`timescale 1ps/1ps

//即値算術論理演算ユニット
module alu_e2 (in0, in1, alucnt, out);

		input [15:0] in0, in1;		//入力
		input alucnt;				//演算選択信号
		output [15:0] out;			//出力
		reg [15:0] out;

	always @ (in0 or in1 or alucnt) begin
		if(alucnt == 1'b0)begin			//ADDI命令かADDIU命令
			out <= #1 in0 + in1;		//加算
		end
		else if(alucnt == 1'b1)begin	//SUBI命令
			out <= #1 in0 - in1;		//減算
		end
	end

endmodule