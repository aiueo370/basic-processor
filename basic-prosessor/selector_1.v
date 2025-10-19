`timescale 1ps/1ps

module selector_1 (in0, in1, s, out);

	input in0, in1;
	input s;
	output out;
	reg out;

  always @ (in0 or in1 or s) begin
	if(s==0) begin
		out <= #1 in0;
	end
	else begin
		out <= #1 in1;
	end
	
  end

endmodule
