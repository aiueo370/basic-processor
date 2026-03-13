`timescale 1ps/1ps
module register_4 (rst,clk,in,out);
    input rst,clk;
    input [3:0] in;
    output [3:0] out;
    reg [3:0] out;
    
    always @ (negedge rst or posedge clk) begin
        if(!rst)begin      // rst=1でリセット
            out <= #1 4'b0;
        end
        else begin             // rst=0で通常動作
            out <=#1 in;
        end
    end
endmodule