`timescale 1ps/1ps

module control (opcd, alucnt, sel, we, branch, clk, rst);

	input clk, rst;
	input [3:0]  opcd;
	output [1:0] alucnt, branch;
	output sel, we;
	reg [1:0] alucnt, branch;
	reg sel, we;

  always @ (negedge rst or posedge clk) begin
  	if(rst == 0)begin
      	alucnt <= 2'b00;
        sel    <= 1'b0;
        we     <= 1'b0;
        branch <= 2'b00;
     end
     else begin
      //branch：01:BEQ、10:BLT、00:それ以外
      case(opcd)
      
      4'b0000:	//NOP
      	begin
      		#1 alucnt <= 2'b00;	sel<=1'b0;	we <=1'b0;	branch <= 2'b00;
      	end
      	
      4'b0001:	//ADD
      	begin
      		#1 alucnt <=2'b00; sel<=1'b0;	we<=1'b1;	branch <= 2'b00;
      	end
      
      4'b0010:	//SUB
      	begin
      		#1 alucnt <=2'b01;	sel<=1'b0;	we<=1'b1;	branch <= 2'b00;
      	end
      
      4'b0011:	//AND
      	begin
      		#1 alucnt <= 2'b10;	sel<=1'b0;	we <=1'b1;	branch <= 2'b00;
      	end
      	
      4'b0100:	//OR
      	begin
      		#1 alucnt <=2'b11;	sel<=1'b0;	we<=1'b1;	branch <= 2'b00;
      	end
      
      4'b0111:	//LDI
      	begin
      		#1 alucnt <=2'b00; sel<=1'b1;	we<=1'b1;	branch <= 2'b00;
      	end
      	
      4'b1100:	//BEQ
      	begin
      		#1 alucnt <= 2'b00; sel<=1'b0; we<=1'b0;	branch <= 2'b01;
      	end
      
      4'b1101:	//BLT
      	begin
      		#1 alucnt <= 2'b00; sel<=1'b0; we<=1'b0;	branch <= 2'b10;
      	end
      
      default:
      	begin
      		alucnt <= #1 2'bxx;	sel <= #1 1'bx;	we <= #1 1'bx;
      	end

	endcase
    end
  end

endmodule
