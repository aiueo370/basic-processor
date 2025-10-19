`timescale 1ps/1ps

module selector_2 (in0, in1, s, out);

	input [1:0] in0,in1;
	input s;
	output [1:0] out;
	reg [1:0] out;

  always @ (in0 or in1 or s) begin
	if(s==0) begin
		out <= #1 in0;
	end
	else begin
		out <= #1 in1;
	end
	
  end

endmodule
