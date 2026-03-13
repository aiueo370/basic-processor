`timescale 1ps/1ps

module jump_j(in, out1, out2);

		input [15:0] in;
		output out1;
		output [8:0] out2;
		reg out1;
		reg [8:0] out2;

	always @ (in) begin
	//case文を使用
	case(in[15:12])
		4'b1110:			//JUMP命令
			begin
				out1 <= #1 1'b1;
				out2 <= #1 in[8:0];
			end
			
		default: 
			begin//それ以外の時
				out1 <= #1 1'b0;		
				out2 <= #1 9'b0;  //ここは何を出力してもいい
			end
	endcase
	end

endmodule