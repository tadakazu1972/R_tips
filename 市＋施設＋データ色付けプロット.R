#施設　データに応じて色付けしてプロット
#ライブラリ
library(dplyr)
library(sf)
library(readr)
library(RColorBrewer)
library(classInt)

#作業フォルダセット
setwd("~/Desktop/work")

#シェープファイル読み込み eStatから大阪府全体のファイル
shape <- st_read("h27_did_27.shp")

#施設の緯度経度ファイル
master <- read_csv("xxxx.csv")

#データ
data0 <- read_csv("XXXX.csv")

#データと緯度経度を結合
data <- left_join(data0, master, by=c("xxxx"="yyyy"))

#データ表示で使うため項目名を代入
column <- colnames(data)

#mexで境界線全体の拡大率を操作
par(mex="0.3", family="HiraKakuProN-W3")

#境界線描画
plot(st_geometry(shape[1:24,1]), main=paste("平成28年度　", column[4], "　標準化得点" , sep=""))

#色付け　データを　赤黄青 色をkmeansで(項目名が数字で始まっている場合は$のあとに``で囲む)
color <- data$`1ZZZZ` %>% classIntervals(., 6, style="kmeans") %>% findColours(.,pal=brewer.pal(6,"RdYlBu"))

#施設をpointで描画
points(data$X, data$Y, ps=24, pch=16, col=color)

#点数をY座標ずらして描画
text(data$X, data$Y-0.0024, labels=data[[column[4]]], cex=0.5)
