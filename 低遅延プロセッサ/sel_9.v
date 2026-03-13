`timescale 1ps/1ps

module sel_9 (in0,in1,sel,out);

	input [8:0] in0,in1;
	input sel;
	output [8:0] out;
	reg [8:0] out;

	always @ (in0 or in1 or sel) begin
		if(sel == 1'b0)begin
			out <= #1 in0;
		end
		else if(sel == 1'b1)begin
			out <= #1 in1;
		end

	end


endmodule