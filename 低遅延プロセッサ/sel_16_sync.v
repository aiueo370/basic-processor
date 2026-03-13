`timescale 1ps/1ps

module sel_16_sync (clk,rst,in0,in1,sel,out);

	input [15:0] in0, in1;
	input sel, clk, rst;
	output [15:0] out;
	reg [15:0] out;

	always @ (posedge clk or negedge rst) begin
	
		if(!rst)begin
				out <= #1 16'b0;
		end
		else begin 
		
		if(sel == 1'b0)begin
			out <= #1 in0;
		end
		else if(sel == 1'b1)begin
			out <= #1 in1;
		end
	end
	end


endmodule