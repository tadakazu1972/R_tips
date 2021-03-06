#CuÇ
library(dplyr)
library(sf)
library(readr)
library(RColorBrewer)
library(classInt)

#ìÆfBNgwè
setwd("~/Desktop/Ct")

#csvÇÝÝ
data1 <- read.csv("CtwZ2018_19.csv", fileEncoding="CP932")
data2 <- read.csv("CtwZ2018_20.csv", fileEncoding="CP932")

#########################################
#@TÌ³Òðär
#data1@³Ò@¡T
data1m <- as.matrix(data1)
data1m13 <- as.integer(data1m[,12])

#data2@³Ò@¡T
data2m <- as.matrix(data2)
data2m13 <- as.integer(data2m[,12])

#¼
dataM13 <- rbind(data1m13, data2m13)

#¶»¯
par(family="HiraKakuProN-W3")

#_Ot@¡«
op <- par(cex=0.6)
barplot(dataM13, beside=TRUE, col=c("blue","red"), las=2, names.arg=data1[,1], main="CtGUwÂ½(Ûç,c,¬)@T@³Ò", legend=c("H31.1.7-13","H31.1.14-20"))


##########################################
# TÌwÂ½ixZAwNÂ½ÜÞjðär
data1m2 <- as.integer(data1m[,2])
data2m2 <- as.integer(data2m[,2])
dataM2 <- rbind(data1m2, data2m2)

#¶»¯
par(family="HiraKakuProN-W3")

#_Ot@¡«
op <- par(cex=0.6)
barplot(dataM2, beside=TRUE, col=c("blue","red"), las=2, names.arg=data1[,1], main="CtGUwÂ½(Ûç,c,¬)@T@{Ý", legend=c("H31.1.7-13","H31.1.14-20"))
