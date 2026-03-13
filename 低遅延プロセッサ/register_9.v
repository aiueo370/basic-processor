`timescale 1ps/1ps
module register_9 (rst,clk,in,out);
    input rst,clk;
    input [8:0] in;
    output [8:0] out;
    reg [8:0] out;
    
    always @ (negedge rst or posedge clk) begin
        if(!rst)begin      // rst=1でリセット
            out <= #1 9'b0;
        end
        else begin             // rst=0で通常動作
            out <=#1 in;
        end
    end
endmodule