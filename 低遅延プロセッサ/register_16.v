`timescale 1ps/1ps
module register_16 (rst,clk,in,out);
    input rst,clk;
    input [15:0] in;
    output [15:0] out;
    reg [15:0] out;
    
    always @ (negedge rst or posedge clk) begin
        if(!rst)begin      // rst=1でリセット
            out <= #1 16'b0;
        end
        else begin             // rst=0で通常動作
            out <=#1 in;
        end
    end
endmodule