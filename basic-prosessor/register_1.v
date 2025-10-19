`timescale 1ps/1ps

module register_1 (in, out, rst, clk);

	input rst,clk, in;
	output out;
	reg out;

  always @ (negedge rst or posedge clk) begin
	
      if(rst == 0)begin
      	out <= #1 1'b0;
      end
      else begin
      	out <= #1 in;
      end

  end

endmodule
