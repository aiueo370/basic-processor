`timescale 1ps/1ps

module ma (clk, rst, Mwe_e, Mem_address_e, wdata_e, dest_e, we_e, wdata_m, we_m, dest_m, mdata);

    input [15:0] wdata_e;			//データメモリまたはレジスタファイルの書き込みデータ
    input [8:0] Mem_address_e;		//データメモリの書き込みアドレス
    input [3:0] dest_e;				//レジスタファイルのの書込許可アドレス
    input clk, rst;					//クロック・リセット
    input Mwe_e;					//データメモリの書き込み許可
    input we_e;						//レジスタファイルの書き込み許可
    
    output [15:0] wdata_m;			//WBへ渡すデータ
    output [15:0] mdata;			//LD命令フォワーディング用のデータメモリの出力
    output [3:0] dest_m;			//WBへ渡すレジスタファイルの書き込みアドレス
    output we_m;					//WBへ渡すレジスタファイルの書き込み許可
    
    //配線
    wire [15:0] wdata;
    wire [8:0] Mem_address_e_r, Mem_address;
    wire [3:0] dest;
    wire we, Mwe_e_r;
    
    //同期回路化
    data_mem i0 (.rst(rst), .in0(wdata), .in1(Mwe_e_r), .in2(Mem_address_e_r), .in3(Mem_address), .out(mdata));			//データメモリ
    register_16 i1 (.clk(clk), .rst(rst), .in(wdata_e), .out(wdata));
    register_4 i3(.clk(clk), .rst(rst), .in(dest_e), .out(dest));
    register_1 i4(.clk(clk), .rst(rst), .in(we_e), .out(we));
    register_1 i5(.clk(clk), .rst(rst), .in(Mwe_e), .out(Mwe_e_r));
    register_9 i6(.clk(clk), .rst(rst), .in(Mem_address_e), .out(Mem_address_e_r));
    
    //遅延
    assign #1 dest_m = dest;
    assign #1 wdata_m = wdata;
	assign #1 we_m = we;
    assign #1 Mem_address = Mem_address_e;

    
endmodule

