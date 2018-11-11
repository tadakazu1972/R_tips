#ライブラリ
library(dplyr)

setwd("~/Desktop/住之江区/")

#住基csvを読み込んで縦に連結する
lf <- list.files(path="~/Desktop/住之江区/住基データ", full.names=T)
data <- lapply(lf, read.csv)
data_bind <- do.call(rbind, data)

#男女別が「計」のデータだけ抽出
total <- data_bind %>% filter(data_bind$男女別=="計")

#町丁目名を取得
last <- length(total$町丁目)/8-1 #最後が総数のため全行を8ファイル分で割って-1にして読み込まないようにする
name <- total[1:last,2]

#国勢調査データで使うために、町丁目データをcsvファイルに書き出しておく
#write.csv(name, "NAME.csv")

#######################################################
#全項目　一枚描き
for(i in 1:last){
 p <- total %>% filter(total$町丁目名==name[i])
 par(new=TRUE, family="HiraKakuProN-W3", xpd=TRUE, xaxt="n")
 ts.plot(ts(p[,8:108]), col=c(1:100), xlim=c(1, 8), ylim=c(0, 200), main="住之江区　住民基本台帳　各年齢別　人口", xlab="住民基本台帳", ylab="人")
 par(xaxt="s")
 axis(side=1, at=1:8, labels=c("H23/3", "H24/3", "H25/3", "H26/3", "H27/3", "H28/3", "H29/3", "H30/3"))
}

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
