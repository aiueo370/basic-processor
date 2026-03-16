`timescale 1ps/1ps

//９ビットレジスタ
module register_9 (rst, clk, in, out);
    input rst, clk;				//リセット・クロック
    input [8:0] in;				//入力
    output [8:0] out;			//出力
    reg [8:0] out;
    
    always @ (negedge rst or posedge clk) begin
        if(!rst)begin      		// rst=1でリセット
            out <= #1 9'b0;
        end
        else begin             // rst=0で通常動作
            out <=#1 in;
        end
    end
endmodule