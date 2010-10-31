【必要なもの】

1. TokyoCabinet
2. TokyoCabinetのperlモジュール
3. wget
4. xz

【インストール手順】

1. gitからnerimonoをpull

2. ${NERIMONO}/install/install.shを実行

   辞書ファイル格納用ディレクトリを必ず指定
   $ sh install.sh "/home/${UserName}/dat"

3. ${NERIMONO}/sample/test.pl を実行してみる

   $ cd ${NERIMONO}/sample
   $ perl test.pl

