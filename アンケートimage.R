#行列可視化 image

library(readr)
library(dplyr)
library(RColorBrewer)

setwd("~/Desktop/work")

#あらかじめUTF-8変換済み
data <- read_csv("student.csv")

#児童生徒IDで並べ替え、学校１,3年生で調査回次1のデータ抽出
schoolNO=4
gakunen=3
kaiji=1

data1 <- data %>% arrange(data$児童生徒ID) %>% filter(data$学校NO==schoolNO & data$学年==gakunen　& data$調査回次==kaiji)

#data.frameを行列変換 設問1~23　※24は答えのスケールが6段階なので以降は捨てる
data1M <- data.matrix(data1[,10:32])

#NAを0変換
data1M[is.na(data1M)]<-0

#そのままだと左下が行列の(1,1)成分なので行の上下を順番に入れ替えて転置（90度回転）
data1MT <- t(apply(data1M, 2, rev))

#文字化け
par(family="HiraKakuProN-W3")

#描画
image(data1MT, col=brewer.pal(8, "Blues"), axes=FALSE, main=paste("学校NO:", schoolNO, "  学年:", gakunen, "  調査回次:", kaiji, seq=""))

#横軸:設問1-23
axis(side=3, at=seq(0, 1, length=23), labels=dimnames(data1MT)[[1]], las=TRUE, cex.axis=0.3)

#縦軸:生徒数
axis(side=2, at=rev(seq(0, 1, length=ncol(data1MT))), labels=seq(1, ncol(data1MT)), las=TRUE, cex.axis=0.3)
