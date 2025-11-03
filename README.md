これは4段パイプラインプロセッサです。
パイプライン構成はIF→ID→EX→WBステージです。

実装されている命令は、ADD命令、SUB命令、AND命令、OR命令、LDI命令、BEQ命令、BLT命令です。
詳しい命令については 仕様書.pdf をご覧ください。

また、ファイルは以下の通りです。
  adder_8.v：8ビット加算器
  alu.v：算術論理演算ユニット
  branch.v：分岐命令判定器
  control.v：命令読解器
  extend_8.v：4から8ビットへの符号拡張器
  extend_16.v：8から16ビットへの符号拡張器
  reg_file.v：レジスタファイル
  register_1.v：1ビットレジスタ
  register_4.v：4ビットレジスタ
  register_8.v：8ビットレジスタ
  register_16.v：16ビットレジス
  selsctor_1.v：1セレクタ
  selsctor_2.v：2セレクタ
  selsctor_8.v：8セレクタ
  selsctor_16.v：16セレクタ
  fetch.v：FEステージ
  decode.v：IDステージ
  wb.v：WBステージ
  execution.v：EXステージ
  cpu.v：CPU
  i_rom：命令格納rom
  
