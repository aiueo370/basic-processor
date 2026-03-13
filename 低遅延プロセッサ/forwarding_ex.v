`timescale 1ps/1ps

//LD命令のフォワーディング
module forwarding_ex (fRdest, fRsrc, mdata, ld_e, ffRdest, ffRsrc);

	input [15:0] fRdest, fRsrc;			//レジスタファイルからの読み出しデータ
	input [15:0] mdata;					//データメモリからのデータ
	input ld_e;							//LD命令フラグ
	output [15:0] ffRdest,ffRsrc;		//フォワーディング後のデータ
		
	reg [15:0] ffRdest,ffRsrc;

	always @ (*) begin
		ffRsrc <= #1 fRsrc;
		if(ld_e==1) begin				//EXステージがLD命令の場合
			ffRdest <= #1 mdata;		//データメモリからのデータをフォワーディング
		end else begin					//それ以外はそのまま
			ffRdest <= #1 fRdest;
		end
	end
	
endmodule