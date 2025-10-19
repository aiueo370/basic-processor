`timescale 1ps/1ps

module branch (ina, inb, branch, bj, rst, clk);

	input rst, clk;
	input [15:0] ina;
	input [15:0] inb;
	input [1:0] branch;
	output bj;
	reg bj;
	
	//branch：01:BEQ、10:BLT、00:それ以外

  always @(posedge clk or negedge rst) begin
    if (rst == 0) begin
        bj <= 1'b0;
    end
      else if(branch == 2'b01) begin
      	if(ina == inb) begin
      		bj <= #1 1'b1;
      	end
      	else begin
      		bj <= #1 1'b0;
      	end
      end
      else if(branch == 2'b10) begin
      	if(ina < inb) begin
      		bj <= #1 1'b1;
      	end
      	else begin
      		bj <= #1 1'b0;
      	end
      end
      else begin
      	bj <= #1 1'b0;
      end

  end

endmodule
