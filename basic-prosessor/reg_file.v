`timescale 1ps/1ps

module  reg_file(in, wad, we, rad1, rad2, out1, out2, rst, clk);

	input [15:0] in;
	input [3:0] wad, rad1, rad2;
	input we, rst, clk;
	output [15:0] out1, out2;
	reg [15:0] mem[0:15];
	integer i;

  always @ (negedge rst or posedge clk) begin
	if(rst==0) begin
		for (i = 0; i < 16; i = i + 1) begin
        	mem[i] <= 16'h0000;
        end
	end
	
    else if(we==1)begin
     	 mem[wad]<= #1 in;
    end
  end
  
	assign #1 out1= mem[rad1];
	assign #1 out2 = mem[rad2];

endmodule
