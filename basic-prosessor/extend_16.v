`timescale 1ps/1ps

module extend_16 (in, out, clk, rst);

	input [7:0] in;
	input clk, rst;
	output [15:0] out;
	reg [15:0] out;

  always @ (posedge clk or negedge rst) begin
      if (!rst) begin
          out <= 16'b0;
      end else begin
      case(in[7])
      	1'b0:
      		begin
      			out <= #1 {8'b00000000, in};
      		end
      		
      	1'b1:	
      		begin
      			out <= #1 {8'b11111111, in};
      		end
      	default:	begin out <=#1 16'hxxxx; end
      endcase
      end

  end

endmodule
