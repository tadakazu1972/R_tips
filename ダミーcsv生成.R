library(readr)
library(dplyr)

setwd("~/Desktop/R_tips")

#各項目生成

#申請番号10万行
applyno <- 1:100000

#申請状況を繰り返しで生成
status  <- rep(c("申請受理","振込対応中","振込完了","不受理"), times=25000)

#日付を繰り返しで生成 まず50個、その後繰り返しで
dateA 　<- seq(as.Date("2020/05/01"), as.Date("2020/06/19"), "days")
date1   <- rep(dateA, times=2000)

dateB 　<- seq(as.Date("2020/07/01"), as.Date("2020/08/19"), "days")
date2   <- rep(dateB, times=2000)

#データフレーム合成
data <- data.frame(ApplyNo=applyno, Status=status, ApplyDate=date1, PlanDate=date2)

#csvファイル書き出し
write.csv(data, "dummy.csv", fileEncoding="CP932", row.names=FALSE)
