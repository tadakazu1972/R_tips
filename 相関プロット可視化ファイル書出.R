library(readr)
library(dplyr)

setwd("~/Desktop/work")

#xファイル読み込み　Windows作業そのままCP932で読み込み
data1 <- read_csv("xxxx.csv", locale=locale(encoding="CP932"))

#yファイル読み込み
data2 <- read_csv("yyyy.csv", locale=locale(encoding="CP932"))

#結合
data <- left_join(data1, data2, by=c("hoge"="huga"))
write.csv(data, "xxxxyyyy.csv", fileEncoding="CP932", row.names=FALSE)

#NAの行を削除
na.omit(data)

#カラム名を格納
column <- colnames(data)

x = 23 #質問紙:1　のカラム番号
y = 6  #合計　のカラム番号

for (i in 1:22){
  #書き出しファイル設定
  quartz(type="pdf", file=sprintf("xxxxyyyy%s.pdf", column[y], column[x]))

  #描画
  par(family="HiraKakuProN-W3", xpd=TRUE)
  plot(data[[column[x]]], data[[column[y]]], pch=16, col="red", cex=0.5, xlab=paste("質問",column[x],sep=""), ylab=column[y], main=paste("xxxx　", column[y], "yyyy:", column[x], sep=""))
  text(data[[column[x]]], data[[column[y]]]+1, labels=data$hoge, cex=0.5)

  #相関係数計算　とりあえず休止
  #相関係数計算用にNAを0置換するためコピー　0で描画されて妙になるのを防ぐため別にする
  data0 <- data
  data0[is.na(data0)]<-0
  r <- cor(data0[[column[x]]], data0[[column[y]]])
  legend("bottom", legend=paste("相関係数=", r, sep=""))

  dev.off()

  #質問紙　項目1つすすめる
  x = x + 1
}
