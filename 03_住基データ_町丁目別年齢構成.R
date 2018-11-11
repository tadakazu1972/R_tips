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
#町丁目ごとに、住基データ8年分をファイルに書き出し
for(j in 1:last){
  quartz(type="pdf", file=sprintf("住之江区住基年齢構成H2303_H3003_%d%s.pdf",j, name[j]))
  for(i in 1:8){
    p <- total %>% filter(total$町丁目名==name[j])
	par(new=TRUE, family="HiraKakuProN-W3", xpd=TRUE, xaxt="n")
	plot(c(0:100), p[i,8:108], type="l", col=c(i), xlim=c(0, 100), ylim=c(0, 200), main=paste("住之江区  住基　各年齢別　人口　", name[j], sep=""), xlab="年齢", ylab="人")
	text(50+0.55, 80, labels=name[j], cex=1.5)
	par(xaxt="s")
	axis(side=1, at=0:100, labels=c(0:100))
 }
 dev.off()
}
