#区　町丁目　住基データ　可視化　拡大表示

#ライブラリ読込
library(dplyr)
library(sf)
library(readr)
library(RColorBrewer)
library(classInt)

#作業ディレクトリを作成して指定(Mac)
setwd("~/Desktop/work")

#シェープファイル読込
#eStatから取得：例は北区。.dbf .prj .shxも合わせて作業ディレクトリに入れておくべし。
shape <- st_read("h27ka27121.shp") 

#住民基本台帳データ 文字コードShift-JISを変換指定しないとエラーになる
data1 <- read_csv("22higasisumiyosiJyukiH2909.csv", locale=locale(encoding="SJIS")) 

#男女別が「計」のデータだけ抽出
data2 <- data1 %>% filter(data1$男女別=="計")

#shapeファイルとcsvを結合
data <- left_join(shape, data2, by=c("MOJI"="町丁目名"))

column="７０歳"
kuname="東住吉区"

#mexで拡大率を操作
par(mex="0.3", family="HiraKakuProN-W3")
col_km <- data[[column]] %>% classIntervals(., 6, style="fixed", fixedBreaks=c(9,10,20,30,40,50,max(.))) %>% findColours(.,pal=brewer.pal(6,"Reds"))
plot(st_geometry(shape[7]), col=col_km, main=paste(kuname, column, "  (平成29年9月末現在)", sep=""))
text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2], labels=shape$MOJI, cex=0.4)
text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2]-0.0007, labels=data[[column]], cex=0.6)
