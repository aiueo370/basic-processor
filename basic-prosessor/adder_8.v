`timescale 1ps/1ps

module adder_8 (rst, clk, ina, inb ,out);

	input rst, clk;
	input [7:0] ina, inb;
	output [7:0] out;
	reg [7:0] out;
	
	always @ (negedge rst or posedge clk) begin
		if(rst == 0) begin
			out <= #1 8'b00000000;
		end else begin
			out <= #1 ina + inb;
		end
	end

endmodule
