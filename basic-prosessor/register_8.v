`timescale 1ps/1ps

module register_8 (rst, clk, in, out);

	input rst,clk;
	input [7:0] in;
	output [7:0] out;
	reg [7:0] out;
	
	always @ (negedge rst or posedge clk) begin
	
		if(rst == 0)begin
			out <= #1 8'b00000000;
		end else begin
			out <= #1 in;
		end
	end

endmodule
