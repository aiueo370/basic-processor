`timescale 1ps/1ps

//１ビットレジスタ
module register_1 (rst, clk, in, out);
    input rst,clk;		//クロック・リセット
    input in;			//入力
    output out;			//出力
    reg  out;
    
    always @ (negedge rst or posedge clk) begin
        if(!rst)begin      // rst=1でリセット
            out <= #1 1'b0;
        end
        else begin             // rst=0で通常動作
            out <=#1 in;
        end
    end
endmodule