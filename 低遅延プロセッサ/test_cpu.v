`timescale 1ps/1ps
`include "cpu.v"
module test_cpu;

	reg rst,clk;				//リセット・クロック
	wire [15:0] R1, R2, R3, R4, R5, R6, R7, R8, R9;		//レジスタ出力
	wire [15:0] clk_count;クロック数カウンタ
	wire flag_halt;				//HALT命令用フラグ
	
	integer i;
    
    //モジュールのインスタンス化
    cpu i0 (.rst(rst), .clk(clk),.R1(R1),.R2(R2),.R3(R3),.R4(R4),.R5(R5),.R6(R6),.R7(R7),.R8(R8),.R9(R9),.clk_count(clk_count),.flag_halt(flag_halt));
    
    // テストシーケンス
    initial begin
        #0   rst=1'b0; clk=1'b0;
        #100  rst = 1'b1;
        
        while(!flag_halt)begin
        	#100 clk=1'b1;
        	#100 clk=1'b0;
        end 
        
        for(i = 0; i < 5;i = i + 1)
        begin
        	#100 clk=1'b1;
        	#100 clk=1'b0;
        end 
      
        $finish(0);
    end
    
    // モニタ出力
    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0, test_cpu);
    end
endmodule