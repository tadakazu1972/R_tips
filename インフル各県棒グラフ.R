#ライブラリ読込
library(dplyr)
library(sf)
library(readr)
library(RColorBrewer)
library(classInt)

#作業ディレクトリ指定
setwd("~/Desktop/インフル")

#csv読み込み
data1 <- read.csv("インフル学校2018_19.csv", fileEncoding="CP932")
data2 <- read.csv("インフル学校2018_20.csv", fileEncoding="CP932")

#########################################
#　週の患者数を比較
#data1　患者数　今週
data1m <- as.matrix(data1)
data1m13 <- as.integer(data1m[,12])

#data2　患者数　今週
data2m <- as.matrix(data2)
data2m13 <- as.integer(data2m[,12])

#垂直統合
dataM13 <- rbind(data1m13, data2m13)

#文字化け
par(family="HiraKakuProN-W3")

#棒グラフ　横書き
op <- par(cex=0.6)
barplot(dataM13, beside=TRUE, col=c("blue","red"), las=2, names.arg=data1[,1], main="インフルエンザ学級閉鎖(保育園,幼,小中高)　週　患者数", legend=c("H31.1.7-13","H31.1.14-20"))


##########################################
# 週の学級閉鎖（休校、学年閉鎖含む）を比較
data1m2 <- as.integer(data1m[,2])
data2m2 <- as.integer(data2m[,2])
dataM2 <- rbind(data1m2, data2m2)

#文字化け
par(family="HiraKakuProN-W3")

#棒グラフ　横書き
op <- par(cex=0.6)
barplot(dataM2, beside=TRUE, col=c("blue","red"), las=2, names.arg=data1[,1], main="インフルエンザ学級閉鎖(保育園,幼,小中高)　週　施設数", legend=c("H31.1.7-13","H31.1.14-20"))
