`timescale 1ps/1ps

module extend_8 (in, out, clk, rst);

	input [3:0]  in;
	input clk, rst;
	output [7:0] out;
	reg [7:0] out;

  always @ (posedge clk or negedge rst) begin
      if (!rst) begin
          out <= 8'b0;
      end else
      case(in[3])
      	1'b0:
      		begin
      			out <= #1 {8'b0000,in};
      		end
      		
      	1'b1:	
      		begin
      			out <= #1 {8'b1111, in};
      		end
      	default:	begin out <=#1 16'hxx; end
      endcase
  end

endmodule
