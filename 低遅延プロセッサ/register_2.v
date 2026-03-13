`timescale 1ps/1ps
module register_2 (rst,clk,in,out);
    input rst,clk;
    input[1:0] in;
    output[1:0] out;
    reg[1:0]  out;
    
    always @ (negedge rst or posedge clk) begin
        if(!rst)begin      // rst=1でリセット
            out <= #1 2'b00;
        end
        else begin             // rst=0で通常動作
            out <=#1 in;
        end
    end
endmodule