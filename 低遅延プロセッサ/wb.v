`timescale 1ps/1ps

module wb (clk, rst, wdata_m, dest_m, we_m, wdata_w, dest_w, we_w);

	input [15:0] wdata_m;				//MAからのレジスタファイルの書き込みデータ
	input [3:0] dest_m;					//MAからのレジスタファイルの書き込みアドレス
	input we_m;							//MAからのレジスタファイルの書き込み許可
	input rst, clk;						//リセット・クロック
	
	output [15:0] wdata_w;				//レジスタファイルへ送る書き込みデータ
	output [3:0] dest_w;				//レジスタファイルへ送る書き込みアドレス
	output we_w;						//ジスタファイルへ送る書き込み許可
	
	wire [15:0] wdata;
	wire [3:0] dest;
	wire we;
	
	//同期回路化
	register_16 i1 (.clk(clk), .rst(rst), .in(wdata_m), .out(wdata));
	register_4 i2 (.clk(clk), .rst(rst), .in(dest_m), .out(dest));
	register_1 i3 (.clk(clk), .rst(rst), .in(we_m), .out(we));
	
	assign #1 wdata_w = wdata;
	assign #1 dest_w = dest;
	assign #1 we_w = we;
                      
endmodule