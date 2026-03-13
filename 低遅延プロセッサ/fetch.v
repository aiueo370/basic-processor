// fetch.v
`timescale 1ps/1ps


module fetch (clk, rst, inst, pc_f, bj_i, pc_i, clk_count, flag_halt);
	input [8:0] pc_i;
    input clk, rst, bj_i;
    output [15:0] inst, clk_count;
    output [8:0] pc_f;
    output flag_halt;
    wire [15:0] pc_q;
    wire [8:0] pc, nxtadrs1, nxtadrs2, jm, pc_f, jm_pc;
    wire flag1, jm_j;
    


    i_rom i0 (.address(pc), .q(pc_q), .clk(clk),.flagin(flag1),.clk_count(clk_count),.flagout(flag_halt));
    adder_f i1 (.clk(clk), .rst(rst), .in0(pc), .in1(9'b000000001), .out(nxtadrs1), .flagin(flag_halt),.flagout(flag1));
    
    sel_9 i2(.in1(pc_i), .in0(nxtadrs2), .sel(bj_i), .out(pc));
    sel_16 i3(.in0(pc_q), .in1(16'h0000), .sel(bj_i), .out(inst));
    register_9 i4(.clk(clk),.rst(rst),.in(pc),.out(pc_f));	
    
    jump_j i5(.in(inst), .out1(jm_j), .out2(jm));
    adder_9 i6(.in0(jm), .in1(pc_f), .out(jm_pc));
    sel_9 i7(.in0(nxtadrs1), .in1(jm_pc), .sel(jm_j), .out(nxtadrs2));
    
    
    
endmodule

