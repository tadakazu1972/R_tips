library(dplyr)
library(sf)
library(readr)
library(RColorBrewer)
library(classInt)

#Mac　作業フォルダ設定
setwd("~/Desktop/地価公示/")

#グラフィックパラメータ
par(mex="0.2", family="HiraKakuProN-W3", xpd=FALSE, xaxt="n", bg="black")

#Windows
#par(mex="0.2", xpd=FALSE, xaxt="n", bg="black")
#windowsFonts(MEI = windowsFont("Meiryo"))

##########################################
#地価公示　描画
#地価公示　シェープファイル読込
shape <- st_read(dsn = "~/Desktop/地価公示/H31/", layer = "L01-19_27")

#windows H31/と最後に/を入れるとエラー
#shape <- st_read(dsn = "/Users/tadakazu/AppData/Local/Packages/CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc/LocalState/rootfs/home/tadakazu/R_tips/地価公示/H31", layer = "L01-19_27")

#公示価格　標準地の地価.単位を「円/m2」とする。
#Factor型を数値に変換するのだが、一度文字変換してからでないとカテゴリーを変換してしまう
data = as.numeric(as.character(shape$L01_006))

#公示価格　色設定　Spectralの色順序を逆で　fixedBreaks
col_km <- data %>% classIntervals(., 11, style="fixed", fixedBreaks=c(0,5000,10000,30000,50000,100000,200000,300000,500000,1000000,max(.))) %>% findColours(.,pal=rev(brewer.pal(11,"Spectral")))

#地価公示　描画 xlimとylimをshape0と合わせないとずれる
par(new=T)
plot(st_geometry(shape[,6]), pch=18, cex=1, col=col_km, xlim=c(135.0913,135.7466), ylim=c(34.27182,35.05129))

############################################
#鉄道　描画
#鉄道　シェープファイル読み込み
rails <- st_read(dsn = "~/Desktop/地価公示/rails", layer = "N02-18_RailroadSection")

#Windows WSL
#rails <- st_read(dsn = "/Users/tadakazu/AppData/Local/Packages/CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc/LocalState/rootfs/home/tadakazu/R_tips/地価公示/rails", layer = "N02-18_RailroadSection")

#鉄道　描画
par(new=T)
plot(st_geometry(rails), xlim=c(135.0913,135.7466), ylim=c(34.27182,35.05129), lwd=1, lty="solid", col="purple", bg="transparent")

############################################
#行政区域　描画
#行政区域　シェープファイル読込
#国土数値情報から取得 .dbf .prj .shxも合わせて作業ディレクトリ下部フォルダに入れておくべし
shape0 <- st_read(dsn = "~/Desktop/地価公示/base", layer = "N03-19_27_190101")

#Windows WSLの場合パス
#shape0 <- st_read(dsn = "/Users/tadakazu/AppData/Local/Packages/CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc/LocalState/rootfs/home/tadakazu/R_tips/地価公示/base", layer = "N03-19_27_190101")

#行政区域　描画
par(new=T)
plot(st_geometry(shape0[,4]), xlim=c(135.0913,135.7466), ylim=c(34.27182,35.05129), main=paste("大阪府　地価公示 (2019年)", sep=""), border="green4", bg="transparent")

##########################################
#凡例
legend("topleft", legend=c("5,000円/㎡","10,000円/㎡","30,000円/㎡","50,000円/㎡","100,000円/㎡","200,000円/㎡","300,000円/㎡","500,000円/㎡","1,000,000円/㎡"), pch=c(16,16,16,16,16,16,16,16), lty=c(1,2,3,4,5,6,7,8), col=c("#5E4FA2","#3288BD","#66C2A5","#ABDDA4","#E6F598","#FEE08B","#FDAE61","#F46D43","#D53E4F","#9E0142"), cex=0.8, text.col="white", bg="black")
