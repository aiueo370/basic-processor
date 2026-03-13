`timescale 1ps/1ps

module reg_file (rst,in,wad,we,rad1,rad2,out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11);

		input [15:0] in;
		input [3:0] wad;
		input we,rst;
		input [3:0] rad1,rad2;
		output  [15:0] out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11;
		
		reg[15:0] out3,out4,out5,out6,out7,out8,out9,out10,out11;
		reg[15:0]  mem[15:0];
		
		integer i;
		
	    always @ (rst or in or wad or we or rad1 or rad2) begin
        
        	if(!rst) begin

               	for(i = 0;i <= 15 ; i=i+1) begin    //Cのfor文と同様だが，++演算子はないので注意

                  	mem[i] <= 16'h0000;

               	end

          	 end
        
			if(we == 1)begin
				if(wad != 0)begin
					mem[wad] <=  in;//アドレスが0でなければinを代入する
				end else begin
					mem[wad] <= 16'h0;//ゼロレジスタ
				end
			end
			
			out3 <= mem[1];
			out4 <= mem[2];
			out5 <= mem[3];
			out6 <= mem[4];
			out7 <= mem[5];
			out8 <= mem[6];
			out9 <= mem[7];
			out10 <= mem[8];
			out11 <= mem[9];
			
			
		end
	
	assign #1 out1 = mem[rad1];
	assign #1 out2 = mem[rad2];


endmodule