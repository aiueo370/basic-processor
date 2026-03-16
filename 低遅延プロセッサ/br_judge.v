`timescale 1ps/1ps

//分岐命令判定器
module br_judge (in0, in1, br, rst_flag, out);

	input [15:0] in0, in1;		//入力
	input [1:0] br;				//条件分岐命令フラグ
	input rst_flag;				//リセットフラグ
	output out;					//分岐フラグ
	reg out;
	   
    always @(in0, in1, br, rst_flag) begin
    	if(rst_flag)begin					//リセットの場合初期化するため1を出力
    		out<= #1 1'b1;
    	end
    	else begin
            case (br)
                2'b01: begin 					// BEQ命令
                    if (in0 == in1) begin		//入力が同じなら1を出力
                        out <= #1  1'b1;
                    end else begin				//それ以外は0を出力
                        out <= #1  1'b0;
                    end
                end
                2'b10: begin 					// BGT命令
                    if (in0 > in1) begin		//in0 > in1なら1を出力、
                        out <= #1    1'b1;
                    end else begin				//それ以外は0を出力
                        out <= #1  1'b0;
                    end
                end
                2'b00: begin 					// それ以外
                        out <= #1    1'b0;		//0を出力

                end
                
            endcase
        end
        
    end
    



endmodule