`timescale 1ps/1ps

module alu (ina, inb, clk, rst, alucnt, out);

	input [15:0]  ina,inb;
	input[1:0] alucnt;
	input clk, rst;
	output [15:0] out;
	reg [15:0] out;

  always @ (negedge rst or posedge clk) begin
	
      //‚±‚Ì’†‚Éå‚È‰ñ˜H“®ì‚Ì‹Lq
      if(rst==0) begin
      	out <= #1 16'b0000000000000000;
      end
      else begin
        case(alucnt)
        	2'b00:
        		begin
        			out <= #1 ina + inb;
        		end
        	2'b01:
        		begin
        			out <= #1 ina - inb;
        		end
        	2'b10:
        		begin
        			out <= #1 ina & inb;
        		end
        	2'b11:
        		begin
        			out <= #1 ina | inb;
        		end
        endcase
      end
  end

endmodule
