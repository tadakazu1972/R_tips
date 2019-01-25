#ライブラリ
library(dplyr)
library(sf)
library(readr)
library(RColorBrewer)
library(classInt)

setwd("~/Desktop/北本市/")

#シェープファイル読込
#eStatから取得 .dbf .prj .shxも合わせて作業ディレクトリ下部のshapeフォルダに入れておくべし。
shape <- st_read(dsn = "~/Desktop/北本市/", layer = "h27ka11233")

#カラム名取得
column = colnames(data)

kuname="北本市"

#人口　描画
par(new=TRUE, mex="0.2", family="HiraKakuProN-W3", xpd=TRUE, xaxt="n")
data = shape$JINKO
col_km <- data %>% classIntervals(., 10, style="fixed", fixedBreaks=c(99,100,200,300,400,500,1000,2000,3000,3500,max(.))) %>% findColours(.,pal=brewer.pal(10,"YlGnBu"))
plot(st_geometry(shape[,7]), col=col_km, main=paste(kuname, " ", "人口 (2015年国勢調査)", sep=""))
text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2]+0.001, labels=shape$MOJI, cex=0.3)
text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2], labels=data, cex=0.5)

#世帯/人口　描画
par(new=TRUE, mex="0.2", family="HiraKakuProN-W3", xpd=TRUE, xaxt="n")
data = shape$SETAI/ shape$JINKO
col_km <- data %>% classIntervals(., 10, style="fixed", fixedBreaks=c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,max(.))) %>% findColours(.,pal=brewer.pal(10,"Reds"))
plot(st_geometry(shape[,7]), col=col_km, main=paste(kuname, " ", "世帯/人口 (2015年国勢調査)", sep=""))
text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2]+0.001, labels=shape$MOJI, cex=0.3)
text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2], labels=round(data, digits=2), cex=0.5)
