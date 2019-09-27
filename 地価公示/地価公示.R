library(dplyr)
library(sf)
library(readr)
library(RColorBrewer)
library(classInt)

setwd("~/Desktop/地価公示/")

#まずは下図を描く
#国勢調査小地域境界シェープファイル読込
#eStatから取得 .dbf .prj .shxも合わせて作業ディレクトリ下部のshapeフォルダに入れておくべし
shape0 <- st_read(dsn = "~/Desktop/地価公示/base/", layer = "N03-19_27_190101")

#境界　描画
par(new=TRUE, mex="0.2", family="HiraKakuProN-W3", xpd=TRUE, xaxt="n")
plot(st_geometry(shape0[,4]), xlim=c(135.0913,135.7466), ylim=c(34.27182,35.05129), main=paste(kuname, " ", "地価公示 (2019年)", sep=""))

#次に代表地点の地価公示を描く
#地価公示シェープファイル読込
shape <- st_read(dsn = "~/Desktop/地価公示/H31/", layer = "L01-19_27")

#公示価格　標準地の地価.単位を「円/m2」とする。
#Factor型を数値に変換するのだが、一度文字変換してからでないとカテゴリーを変換してしまう
data = as.numeric(as.character(shape$L01_006))

#カラム名取得
column = colnames(data)
kuname="大阪府"

#色
#col_km <- data %>% classIntervals(., 8, style="kmeans") %>% findColours(.,pal=rev(brewer.pal(10,"Spectral")))
#色　Spectralの色順序を逆で　fixedBreaks
col_km <- data %>% classIntervals(., 11, style="fixed", fixedBreaks=c(0,5000,10000,30000,50000,100000,200000,300000,500000,1000000,max(.))) %>% findColours(.,pal=rev(brewer.pal(11,"Spectral")))

#代表地点　描画 xlimとylimをshape0と合わせないとずれる
par(new=TRUE, mex="0.2", family="HiraKakuProN-W3", xpd=TRUE, xaxt="n")
plot(st_geometry(shape[,6]), pch=16, cex=0.8, col=col_km, xlim=c(135.0913,135.7466), ylim=c(34.27182,35.05129))

#凡例
legend("topleft", legend=c("5,000円/㎡","10,000円/㎡","30,000円/㎡","50,000円/㎡","100,000円/㎡","200,000円/㎡","300,000円/㎡","500,000円/㎡","1,000,000円/㎡"), pch=c(16,16,16,16,16,16,16,16), lty=c(1,2,3,4,5,6,7,8), col=c("#5E4FA2","#3288BD","#66C2A5","#ABDDA4","#E6F598","#FEE08B","#FDAE61","#F46D43","#D53E4F","#9E0142"), cex=0.8)
