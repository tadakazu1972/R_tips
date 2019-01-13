#ライブラリ
library(dplyr)

#作業ディレクトリ
setwd("~/Desktop/気象/")

#データ読込
data2018 <- read.csv("kisyo_osaka2018.csv")
data2017 <- read.csv("kisyo_osaka2017.csv")
data2016 <- read.csv("kisyo_osaka2016.csv") #366日

#############################################
#1年間
#最高気温
par(new=TRUE, family="HiraKakuProN-W3", xpd=TRUE, xaxt="n", yaxt="n")
plot(data2018[,3], type="l", col=1, xlim=c(1,365), ylim=c(-5,35), ylab="度", main="最高気温")
par(new=TRUE)
plot(data2017[,3], type="l", col=2, xlim=c(1,365), ylim=c(-5,35), ylab="")
par(new=TRUE)
plot(data2016[,3], type="l", col=3, xlim=c(1,365), ylim=c(-5,35), ylab="")
par(xaxt="s")
axis(side=1, at=c(1,32,60,91,121,152,182,213,244,274,305,335), labels=c("1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"), cex.axis=0.5)
par(yaxt="s")
axis(side=2, at=c(-5,0,5,10,15,20,25,30,35), labels=c("-5","0","5","10","15","20","25","30","35"))

#最低気温
par(new=TRUE, family="HiraKakuProN-W3", xpd=TRUE, xaxt="n", yaxt="n")
plot(data2018[,4], type="l", col=1, xlim=c(1,365), ylim=c(-5,35), ylab="度", main="最低気温")
par(new=TRUE)
plot(data2017[,4], type="l", col=2, xlim=c(1,365), ylim=c(-5,35), ylab="")
par(new=TRUE)
plot(data2016[,4], type="l", col=3, xlim=c(1,365), ylim=c(-5,35), ylab="")
par(xaxt="s")
axis(side=1, at=c(1,32,60,91,121,152,182,213,244,274,305,335), labels=c("1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"), cex.axis=0.5)
par(yaxt="s")
axis(side=2, at=c(-5,0,5,10,15,20,25,30,35), labels=c("-5","0","5","10","15","20","25","30","35"))

####################################################
#2ヶ月（１月~2月）の描画
####################################################
#最高気温と最低気温
#初期設定
par(new=TRUE, family="HiraKakuProN-W3", xpd=TRUE, xaxt="n", yaxt="n")

#最高気温
plot(data2018[,3], type="l", lty=2, col=1, xlim=c(1,60), ylim=c(-5,35), ylab="度", main="最高気温と最低気温[大阪]")
par(new=TRUE)
plot(data2017[,3], type="l", lty=2, col=2, xlim=c(1,60), ylim=c(-5,35), ylab="")
par(new=TRUE)
plot(data2016[,3], type="l", lty=2, col=3, xlim=c(1,60), ylim=c(-5,35), ylab="")

#最低気温
par(new=TRUE)
plot(data2018[,4], type="l", col=1, xlim=c(1,60), ylim=c(-5,35), ylab="")
par(new=TRUE)
plot(data2017[,4], type="l", col=2, xlim=c(1,60), ylim=c(-5,35), ylab="")
par(new=TRUE)
plot(data2016[,4], type="l", col=3, xlim=c(1,60), ylim=c(-5,35), ylab="")

#X軸
par(xaxt="s")
axis(side=1, at=c(1,32,60,91,121,152,182,213,244,274,305,335), labels=c("1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"), cex.axis=0.5)

#Y軸
par(yaxt="s")
axis(side=2, at=c(-5,0,5,10,15,20,25,30,35), labels=c("-5","0","5","10","15","20","25","30","35"))

#凡例
labels = c("黒　2018年(破線:最高気温/実線:最低気温)","赤　2017年(破線:最高気温/実線:最低気温)","緑　2016年(破線:最高気温/実線:最低気温)")
pchs   = c(15,15,15)
cols   = c("black","red","green")
legend("topright", legend = labels, pch = pchs, col = cols)
