#全小学校　得点に応じて色付けしてプロット
#前処理：元データのヘッダーを整形
#前処理：元データをUTF-8でエクスポート

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

#全小学校の緯度経度ファイル
master <- read_csv("小学校マスター.csv")

#得点データ
data0 <- read_csv("H29小学校偏差値.csv")

#得点データと緯度経度を結合
data <- left_join(data0, master, by=c("小学校"="学校名"))

#得点表示で使うため項目名を代入
column <- colnames(data)

for (i in 2:21){
  #書き出しファイル設定
  quartz(type="pdf", file=sprintf("平成29年度小学校%s_偏差値.pdf", column[i]))

  #mexで境界線全体の拡大率を操作
  par(mex="0.3", family="HiraKakuProN-W3")

  #境界線描画
  plot(st_geometry(shape[1:24,1]), main=paste("平成29年度　", column[i], "　偏差値" , sep=""))

  #小学校の色付け　点数を　赤黄青 色をkmeansで
  color <- data[[column[i]]] %>% classIntervals(., 6, style="fixed", fixedBreaks=c(20,30,40,50,60,70,max(.))) %>% findColours(.,pal=brewer.pal(6,"RdYlBu"))

  #小学校をpointで描画
  points(data$X, data$Y, ps=24, pch=16, col=color)

  #点数をY座標ずらして描画
  text(data$X, data$Y-0.0024, labels=data[[column[i]]], cex=0.5)

  #描画終了
  dev.off()
}
