#!/bin/bash

DAT_DIR=${1}

if [ "${DAT_DIR}" = "" ]
then
    echo "データ格納用のディレクトリを指定してください"
    exit
fi

if [ ! -d "${DAT_DIR}" ]
then
    mkdir -p ${DAT_DIR}
fi

echo "DAT_DIR=${DAT_DIR}" > ../conf/nerimono.conf

echo "[ dic file download start ]"

wget -P ${DAT_DIR} http://dist.s-yata.jp/corpus/nwc2010/ngrams/char/over999/2gms/2gm-0000.xz
wget -P ${DAT_DIR} http://dist.s-yata.jp/corpus/nwc2010/ngrams/char/over999/3gms/3gm-0000.xz

echo ""
echo "[ download completed ]"
echo ""
echo "[ xzfile decompressing start ]"
echo ""

xz --decompress ${DAT_DIR}/2gm-0000.xz
xz --decompress ${DAT_DIR}/3gm-0000.xz

echo "...completed!"
echo ""
echo "[ TokyoCabinet hash file making start ]"

perl ./makeDB.pl "${DAT_DIR}" "2"
perl ./makeDB.pl "${DAT_DIR}" "3"

echo ""
echo "...completed!"

exit