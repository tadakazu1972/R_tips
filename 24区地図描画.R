###################################################
#　24区地図描画
#ライブラリ読込
library(dplyr)
library(sf)
library(readr)
library(RColorBrewer)
library(classInt)

#作業ディレクトリ指定
setwd("~/Documents/****")

#必要なファイル読込
shape <- st_read("h27_did_27.shp") #eStatから大阪府を取得
data1 <- read_csv("20180101_total.csv") #読み込ませるデータ

#shapeファイルとcsvを結合し、24区のみ残す
data <- inner_join(shape, data1, by=c("CITYNAME"="区名"))

#推計人口　総数 
par(family="HiraKakuProN-W3")
col_km <- data$総数 %>% classIntervals(.,n=11 ,style="fixed", fixedBreaks=c(min(data$総数),20000,40000,60000,80000,100000,120000,140000,160000,180000,200000,max(data$総数))) %>% findColours(.,pal=brewer.pal(11,"YlOrRd")) #YlGnBu
plot(shape[1:24,4], col=col_km, main="区別　推計人口　平成30年1月1日現在")
text(st_coordinates(data %>% st_centroid)[,1], st_coordinates(data %>% st_centroid)[,2]+0.0005, labels=data$CITYNAME, cex=0.8)
text(st_coordinates(data %>% st_centroid)[,1], st_coordinates(data %>% st_centroid)[,2]-0.005, labels=data$総数, cex=0.8)