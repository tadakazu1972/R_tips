#ライブラリ
library(dplyr)
library(sf)
library(readr)
library(RColorBrewer)
library(classInt)

setwd("~/Desktop/住之江区/")

#シェープファイル読込
#eStatから取得 .dbf .prj .shxも合わせて作業ディレクトリ下部のshapeフォルダに入れておくべし。
shape <- st_read(dsn = "~/Desktop/住之江区/shape/", layer = "h27ka27125") 

#住民基本台帳csv読込
data1 <- read_csv("./住基データ/02-20_jyu-ki(suminoe)----H30_3.csv") 

#Shift-JIS版
#data1 <- read_csv("./住基データ/02-20_jyu-ki(suminoe)----H30_3.csv", locale=locale(encoding="SJIS")) 

#男女別が「計」のデータだけ抽出
data2 <- data1 %>% filter(data1$男女別=="計")

#shapeファイルとcsvを結合
data <- left_join(shape, data2, by=c("MOJI"="町丁目名"))

column="０歳"
kuname="住之江区"

#mexで拡大率を操作
par(mex="0.2", family="HiraKakuProN-W3")
col_km <- data[[column]] %>% classIntervals(., 10, style="fixed", fixedBreaks=c(9,10,20,30,40,50,60,70,80,90,max(.))) %>% findColours(.,pal=brewer.pal(10,"YlGnBu"))
plot(st_geometry(shape[7]), col=col_km, main=paste(kuname, " ", column, "  (平成30年3月末現在)", sep=""))
text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2]+0.001, labels=shape$MOJI, cex=0.3)
text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2], labels=data[[column]], cex=0.4)


#######################################################

#総数　0歳～100歳以上まで各年齢別にファイルに書き出し
#町丁目ごとに色を変更する
for(j in 8:108){
  quartz(type="pdf", file=sprintf("住之江区住基H2303_H3003_%d歳.pdf",j-8))
  for(i in 1:last){
    p <- total %>% filter(total$町丁目名==name[i])
	par(new=TRUE, family="HiraKakuProN-W3", xpd=TRUE, xaxt="n")
	ts.plot(ts(p[,j]), col=c(i), xlim=c(1, 8), ylim=c(0, 200), main=paste("住之江区  ", colnames(data_bind)[j], sep= ""), xlab="住民基本台帳", ylab="人")
	text(8+0.4, p[8,j], labels=name[i], cex=0.5)
	par(xaxt="s")
	axis(side=1, at=1:8, labels=c("H23/3", "H24/3", "H25/3", "H26/3", "H27/3", "H28/3", "H29/3", "H30/3"))
 }
 dev.off()
}

###############################################
# GIFアニメ用 pngファイル生成
#総数　0歳～100歳以上まで各年齢別にファイルに書き出し
#町丁目ごとに色を変更する
for(j in 8:108){
  quartz(type="png", file=sprintf("住之江区住基H2303_H3003_%d.png",j-8), dpi=144, bg="white")
  for(i in 1:last){
    p <- total %>% filter(total$町丁目名==name[i])
	par(new=TRUE, family="HiraKakuProN-W3", xpd=TRUE, xaxt="n")
	ts.plot(ts(p[,j]), col=c(i), xlim=c(1, 14), ylim=c(0, 100), main=paste("住之江区  ", colnames(data_bind)[j], sep= ""), xlab="住民基本台帳", ylab="人")
	text(8+0.25, p[8,j], labels=name[i], cex=0.5)
	par(xaxt="s")
	axis(side=1, at=1:8, labels=c("H23/3", "H24/3", "H25/3", "H26/3", "H27/3", "H28/3", "H29/3", "H30/3"))
 }
 dev.off()
}
