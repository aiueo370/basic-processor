`timescale 1ps/1ps

//命令読解器
module control (clk, rst, opcd, sel_1, sel_2, sel_3, sel_4, sel_5, alucnt, aluimm, Mem_we, we, br, rst_flag, ld);

	input [3:0] opcd;		//命令
	input clk, rst;			//クロック・リセット
	output [1:0] alucnt;	//演算選択信号
	output [1:0] br;		//条件分岐命令フラグ
	output sel_1;			//0のときADDI,1のときADDIU
	output sel_2;			//0のときADD,SUB,AND,ORのどれか, 1のときLI
	output sel_3;			//0のときADDI,ADDIUのどれか, 1のときADD,SUB,AND,OR,LIのどれか
	output sel_4;			//0のときADDI,ADDIU,ADD,SUB,AND,OR,LIのどれか, １のときLUI
	output sel_5;			//0のときADDI,ADDIU,ADD,SUB,AND,OR,LI,LUIのどれか, 1のときLDかST
	output aluimm;			//即値算術選択ユニット
	output Mem_we;			//データメモリ書き込み許可フラグ
	output we;				//レジスタ書き込み許可フラグ
	output rst_flag;		//リセットフラグ
	output ld;				//LD命令フラグ
	reg [1:0] alucnt,br;
	reg sel_1,sel_2,sel_3,sel_4,sel_5,aluimm,Mem_we,we,rst_flag,ld;

	 always @ (negedge rst or posedge clk) begin		//同期回路
        if(!rst)begin									 // rst=1でリセット
            alucnt <= #1 2'b0;
            br <= #1 2'b0;
            sel_1 <= #1 1'b0;
            sel_2 <= #1 1'b0;
            sel_3 <= #1 1'b0;
            sel_4 <= #1 1'b0;
            sel_5 <= #1 1'b0;
            aluimm <= #1 1'b0;
            Mem_we <= #1 1'b0;
            we <= #1 1'b0;
            rst_flag <= #1 1'b1;
            ld <= #1 1'b0;
        end
        else begin   
	
	case(opcd)
		4'b0001:	//ADD
			begin
				#1 sel_1 <= 1'b0; sel_2 <= 1'b0; sel_3 <= 1'b1; sel_4 <= 1'b0; sel_5 <= 1'b0; 
				alucnt <= 2'b00; aluimm <= 1'b0; Mem_we <= 1'b0;  we <= 1'b1; br <= 2'b00;
				rst_flag <= #1 1'b0; ld <= 1'b0;
			end
			
		4'b0010:	//SUB
			begin
				#1 sel_1 <= 1'b0; sel_2 <= 1'b0; sel_3 <= 1'b1; sel_4 <= 1'b0; sel_5 <= 1'b0; 
				alucnt <= 2'b01; aluimm <= 1'b0; Mem_we <= 1'b0;  we <= 1'b1; br <= 2'b00;
				rst_flag <= #1 1'b0; ld <= 1'b0;
			end
			
		4'b0011:	//AND
			begin
				#1 sel_1 <= 1'b0; sel_2 <= 1'b0; sel_3 <= 1'b1; sel_4 <= 1'b0; sel_5 <= 1'b0; 
				alucnt <= 2'b10; aluimm <= 1'b0; Mem_we <= 1'b0;  we <= 1'b1; br <= 2'b00;
				rst_flag <= #1 1'b0; ld <= 1'b0;
			end
			
		4'b0100:	//OR
			begin
				#1 sel_1 <= 1'b0; sel_2 <= 1'b0; sel_3 <= 1'b1; sel_4 <= 1'b0; sel_5 <= 1'b0; 
				alucnt <= 2'b11; aluimm <= 1'b0; Mem_we <= 1'b0;  we <= 1'b1; br <= 2'b00;
				rst_flag <= #1 1'b0; ld <= 1'b0;
			end
			
		4'b0101:	//ADDI 
			begin
				#1 sel_1 <= 1'b0; sel_2 <= 1'b0; sel_3 <= 1'b0; sel_4 <= 1'b0; sel_5 <= 1'b0; 
				alucnt <= 2'b00; aluimm <= 1'b0; Mem_we <= 1'b0;  we <= 1'b1; br <= 2'b00;
				rst_flag <= #1 1'b0; ld <= 1'b0;
			end
			
		4'b0110:	 //ADDIU
			begin
				#1 sel_1 <= 1'b1; sel_2 <= 1'b0; sel_3 <= 1'b0; sel_4 <= 1'b0; sel_5 <= 1'b0; 
				alucnt <= 2'b00; aluimm <= 1'b0; Mem_we <= 1'b0;  we <= 1'b1; br <= 2'b00;
				rst_flag <= #1 1'b0; ld <= 1'b0;
			end
			
		4'b0111:	//SUBI
			begin
				#1 sel_1 <= 1'b0; sel_2 <= 1'b0; sel_3 <= 1'b0; sel_4 <= 1'b0; sel_5 <= 1'b0; 
				alucnt <= 2'b00; aluimm <= 1'b1; Mem_we <= 1'b0;  we <= 1'b1; br <= 2'b00;
				rst_flag <= #1 1'b0; ld <= 1'b0;
			end
		
		4'b1000:	//LI
			begin
				#1 sel_1 <= 1'b1; sel_2 <= 1'b1; sel_3 <= 1'b1; sel_4 <= 1'b0; sel_5 <= 1'b0; 
				alucnt <= 2'b00; aluimm <= 1'b0; Mem_we <= 1'b0;  we <= 1'b1; br <= 2'b00;
				rst_flag <= #1 1'b0; ld <= 1'b0;
			end
			
		4'b1001:	//LIU
			begin
				#1 sel_1 <= 1'b0; sel_2 <= 1'b0; sel_3 <= 1'b0; sel_4 <= 1'b1; sel_5 <= 1'b0; 
				alucnt <= 2'b00; aluimm <= 1'b0; Mem_we <= 1'b0;  we <= 1'b1; br <= 2'b00;
				rst_flag <= #1 1'b0; ld <= 1'b0;
			end
			
		4'b1010:	//LD
			begin
				#1 sel_1 <= 1'b0; sel_2 <= 1'b0; sel_3 <= 1'b0; sel_4 <= 1'b0; sel_5 <= 1'b1; 
				alucnt <= 2'b00; aluimm <= 1'b0; Mem_we <= 1'b0;  we <= 1'b1; br <= 2'b00;
				rst_flag <= #1 1'b0; ld <= 1'b1;
			end
			
		4'b1011:	//ST
			begin
				#1 sel_1 <= 1'b0; sel_2 <= 1'b0; sel_3 <= 1'b0; sel_4 <= 1'b0; sel_5 <= 1'b1; 
				alucnt <= 2'b00; aluimm <= 1'b0; Mem_we <= 1'b1;  we <= 1'b0; br <= 2'b00;
				rst_flag <= #1 1'b0; ld <= 1'b0;
			end
			
		4'b1100:	//BEQ
			begin
				#1 sel_1 <= 1'b0; sel_2 <= 1'b0; sel_3 <= 1'b0; sel_4 <= 1'b0; sel_5 <= 1'b0; 
				alucnt <= 2'b00; aluimm <= 1'b0; Mem_we <= 1'b0;  we <= 1'b0; br <= 2'b01;
				rst_flag <= #1 1'b0; ld <= 1'b0;
			end
			
		4'b1101:	//BGT
			begin
				#1  sel_1 <= 1'b0; sel_2 <= 1'b0; sel_3 <= 1'b0; sel_4 <= 1'b0; sel_5 <= 1'b0; 
				alucnt <= 2'b00; aluimm <= 1'b0; Mem_we <= 1'b0;  we <= 1'b0; br <= 2'b10;
				rst_flag <= #1 1'b0; ld <= 1'b0;
			end
			
		4'b1110:	//JUMP
			begin
				#1 sel_1 <= 1'b0; sel_2 <= 1'b0; sel_3 <= 1'b0; sel_4 <= 1'b0; sel_5 <= 1'b0; 
				alucnt <= 2'b00; aluimm <= 1'b0; Mem_we <= 1'b0;  we <= 1'b0; br <= 2'b00;
				rst_flag <= #1 1'b0; ld <= 1'b0;
			end
		
		4'b0000:	//NOP
			begin
				#1 sel_1 <= 1'b0; sel_2 <= 1'b0; sel_3 <= 1'b0; sel_4 <= 1'b0; sel_5 <= 1'b0; 
				alucnt <= 2'b00; aluimm <= 1'b0; Mem_we <= 1'b0;  we <= 1'b0; br <= 2'b00;
				rst_flag <= #1 1'b0; ld <= 1'b0;
			end
			
		4'b1111:	//HALT
			begin
				#1 sel_1 <= 1'b0; sel_2 <= 1'b0; sel_3 <= 1'b0; sel_4 <= 1'b0; sel_5 <= 1'b0; 
				alucnt <= 2'b00; aluimm <= 1'b0; Mem_we <= 1'b0;  we <= 1'b0; br <= 2'b00;
				rst_flag <= #1 1'b0; ld <= 1'b0;
			end
	
	endcase
	end
	end

endmodule