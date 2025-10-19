`timescale 1ps/1ps

module register_16 (in, out, rst, clk);

	input rst, clk;
	input [15:0] in;
	output [15:0] out;
	reg [15:0] out;

  always @ (negedge rst or posedge clk) begin
	
      if(rst == 0)begin
      	out <= #1 16'b000000000000000;
      end
      else begin
      	out <= #1 in;
      end

  end

endmodule
