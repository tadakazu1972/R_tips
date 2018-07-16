#作業ディレクトリ設定
setwd("~/Desktop/work")

#データ読み込み
data <- read.csv("xxxx.csv")

#余白調整
par(family="HiraKakuProN-W3", mar=c(10,5,5,5))

#ヒストグラム描画　X軸非表示
hist(data[,2], breaks=seq(-40,40,5), ylim=c(0,100), label=T, xaxt="n", xlab=colnames(data)[2], col="cyan", main=paste("XXXX", colnames(data)[2], "　YYYY" , sep=""))

#X軸描画
axis(side=1, at=c(-40,-35,-30,-25,-20,-15,-10,-5,0,5,10,15,20,25,30,35,40), labels=c(-40,-35,-30,-25,-20,-15,-10,-5,0,5,10,15,20,25,30,35,40), padj=0)
