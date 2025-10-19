`timescale 1ps/1ps
`include "cpu.v"	//ファイル名を学生番号付きにする

module test_cpu;	//module名を学生番号付きにする

	//適切に宣言を追加する
	reg rst,clk;
	wire [15:0] wdata_w;
	wire [3:0] dest_w;
	wire [15:0] inst;
	wire [15:0] wdata_e;

	integer i;	

	cpu i0 (.rst(rst), .clk(clk), .inst(inst), .wdata_w(wdata_w));

	initial begin
		#0	rst=1'b0; clk=1'b0;
		#100 	rst=1'b1; clk=1'b1;
	
		for(i=0;i<=13;i=i+1) begin
		#100	clk=1'b0;	
		#100	clk=1'b1;
		end
	
		#100
		$finish(0);
	end

	initial begin
		$monitor($time, , "rst=%b clk=%b inst=%h wdata_w=%h", rst, clk, inst, wdata_w);
		
		$dumpfile("cpu.vcd");
  		$dumpvars(0, test_cpu);
	end
endmodule

