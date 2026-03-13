`timescale 1ps/1ps

//フォワーディング
module forwarding (Rdest, Rsrc, dest, src, we_e, dest_e, wdata_e, we_m, dest_m, wdata_m, fRdest,fRsrc);

	input [15:0] Rdest, Rsrc;				//レジスタファイルからの読み出しデータ
	input [15:0] wdata_e, wdata_m;			//EXステージとMAステージの書き込みデータ
	input [3:0] dest, src;					//読み出しデータの書き込み先アドレス
	input [3:0] dest_e, dest_m;				//EXステージとMAステージの書き込み先アドレス
	input we_e, we_m;						//EXステージとMAステージの書き込み許可フラグ
	output [15:0] fRdest, fRsrc;				//フォワーディング後の読み出しデータ
	reg [15:0] fRdest, fRsrc;

	always @ (*) begin
	
		//第一オペラント
		if (we_e==1 && dest_e==dest) begin					//EXステージの結果が必要なら
    		fRdest = wdata_e;
    	end else if (we_m==1 && dest_m==dest) begin			//MAステージの結果が必要なら
    		fRdest = wdata_m;
    	end else begin										//必要でないならそのまま
    		fRdest = Rdest;
    	end
    	
    	//第二オペラント
    	if (we_e==1 && dest_e==src) begin					//EXステージの結果が必要なら
    		fRsrc = wdata_e;
    	end else if (we_m==1 && dest_m==src) begin			//MAステージの結果が必要なら
    		fRsrc = wdata_m;
    	end else begin										//必要でないならそのまま
    		fRsrc = Rsrc;
    	end
    
	end
	

	
endmodule