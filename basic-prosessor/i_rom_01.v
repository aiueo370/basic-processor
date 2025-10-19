`timescale 1ps/1ps

//BEQ命令が成立しないパターン

module i_rom_01 (clk, address, q);

  input         clk;
  input [7:0]   address;
  output [15:0] q;
  reg [15:0]  core[0:255], q;

  initial begin
 	core[0] = 16'h7107;	//LDI R1,7
  	core[1] = 16'h7203;	//LDI R2,3
  	core[2]  =16'h7304;	//LDI R3,4
  	core[3]  =16'h740D;	//LDI R4,13
	core[4] = 16'hC125;	//BEQ R1,R2,5	(R1!=R2だから飛ばないはず)
	core[5] = 16'h0000;	//NOP
	core[6] = 16'h2430;	//SUB R4,R3	これは実行されるはず
	core[7] = 16'h0000;	//NOP
	core[8] = 16'h0000;	//NOP
	core[9] = 16'h1410;	//ADD R4,R1	上のSUBが実行されるから16になるはず
	core[10] = 16'h0000;	//NOP
   end
 
   always @ (posedge clk)  begin
	q <= #1 core[address];
   end

endmodule
