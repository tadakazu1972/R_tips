#24区町丁目シェープファイル書き出し

#ライブラリ読込
library(dplyr)
library(sf)
library(readr)
library(RColorBrewer)
library(classInt)

#作業ディレクトリ
setwd("~/Desktop/work")

#区名
kuName <- c("北区","都島区","福島区","此花区","中央区","西区","港区","大正区","天王寺区","浪速区","西淀川区","淀川区","東淀川区","東成区","生野区","旭区","城東区","鶴見区","阿倍野区","住之江区", "住吉区", "東住吉区", "平野区","西成区")

#24区シェープファイル名　設定 フォルダ名24shapeAllとして作業フォルダにコピーしておく
shapeFile <- c("h27ka27127.shp","h27ka27102.shp","h27ka27103.shp","h27ka27104.shp","h27ka27128.shp","h27ka27106.shp","h27ka27107.shp","h27ka27108.shp","h27ka27109.shp","h27ka27111.shp","h27ka27113.shp","h27ka27123.shp","h27ka27114.shp","h27ka27115.shp","h27ka27116.shp","h27ka27117.shp","h27ka27118.shp","h27ka27124.shp","h27ka27119.shp","h27ka27125.shp","h27ka27120.shp","h27ka27121.shp","h27ka27126.shp","h27ka27122.shp")

for(i in 1:24){
  #シェープファイル読み込み
  shape <- st_read(paste("24shapeAll/", shapeFile[i], sep=""))
  
  #書き出しファイル設定 
  quartz(type="pdf", file=sprintf("%02d%s.pdf",i, kuName[i]))
  
  #quartz設定
  par(family="HiraKakuProN-W3", xpd=TRUE, xaxt="n")
  
  #描画
  plot(st_geometry(shape[7]), col="white", main=paste(kuName[i], "  (平成29年9月末現在)", sep=""))
  text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2], labels=shape$MOJI, cex=0.5)
  #text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2]-0.0007, labels=data[[column[i]]], cex=0.7)
  
  #描画終了
  dev.off()
}