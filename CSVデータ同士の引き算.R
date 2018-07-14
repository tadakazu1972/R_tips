#２つのCSVデータを項目名を維持しつつ、引き算する
#read_csvは項目名を読み込まないので、標準のread.csvを用いる

#1列目を項目名に指定して読み込み
data1 <- read.csv("xxxx.csv", row.names=1)
data2 <- read.csv("yyyy.csv", row.names=1)

#行列減算
data3 <- data1 - data2

#ファイル書き出し
write.csv(data3, "zzzz.csv")
