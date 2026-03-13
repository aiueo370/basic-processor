`timescale 1ps/1ps

module ma (clk, rst, Mwe_e, Mem_address_e, wdata_e, dest_e, we_e, wdata_m, we_m, dest_m, mdata);
    input [15:0] wdata_e;
    input [8:0] Mem_address_e;
    input [3:0] dest_e;
    input clk, rst, Mwe_e, we_e;
    
    
    output [15:0] wdata_m, mdata;
    output [3:0] dest_m;
    output we_m;
   
    wire [8:0] Mem_address_e_r, Mem_address;
    wire [3:0] dest;
    wire we, Mwe_e_r;

    data_mem i0 (.rst(rst), .in0(wdata_m), .in1(Mwe_e_r), .in2(Mem_address_e_r), .in3(Mem_address), .out(mdata));
    register_16 i1 (.clk(clk), .rst(rst), .in(wdata_e), .out(wdata_m));
    register_4 i3(.clk(clk), .rst(rst), .in(dest_e), .out(dest));
    register_1 i4(.clk(clk), .rst(rst), .in(we_e), .out(we));
    register_1 i5(.clk(clk), .rst(rst), .in(Mwe_e), .out(Mwe_e_r));
    register_9 i6(.clk(clk), .rst(rst), .in(Mem_address_e), .out(Mem_address_e_r));
    
    assign #1 dest_m = dest;
	assign #1 we_m = we;
    assign #1 Mem_address = Mem_address_e;

    
endmodule

