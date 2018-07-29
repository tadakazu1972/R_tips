library(readr)
library(dplyr)

setwd("~/Desktop/work")

#csvファイル読み込み　Windows作業そのままCP932で読み込み
data <- read_csv("xxxx.csv", locale=locale(encoding="CP932"))

#データ表示で使うため項目名を代入
column <- colnames(data)

#質問23-25　カラム 41:43
for (i in 41:43){

  #質問23:回答ごとにデータを切り分け
  data1 <- data %>% filter(data[[column[i]]]=="1")
  data2 <- data %>% filter(data[[column[i]]]=="2")
  data3 <- data %>% filter(data[[column[i]]]=="3")
  data4 <- data %>% filter(data[[column[i]]]=="4")

  #回答1 ヒストグラム ファイル書出
  {
    quartz(type="pdf", file=sprintf("yyyyx質問%s_回答1.pdf", column[i]))
    par(family="HiraKakuProN-W3")
    hist(data1$総合, col="cyan", xlab="yyyy　総合", ylab="人", main=paste("yyyyx質問", column[i], "_回答1", sep=""))
    dev.off()
  }

  #回答2 ヒストグラム ファイル書出
  {
    quartz(type="pdf", file=sprintf("yyyyx質問%s_回答2.pdf", column[i]))
    par(family="HiraKakuProN-W3")
    hist(data2$総合, col="cyan", xlab="yyyy　総合", ylab="人", main=paste("yyyyx質問", column[i], "_回答2", sep=""))
    dev.off()
  }

  #回答3 ヒストグラム ファイル書出
  {
    quartz(type="pdf", file=sprintf("yyyyx質問%s_回答3.pdf", column[i]))
    par(family="HiraKakuProN-W3")
    hist(data3$総合, col="cyan", xlab="yyyy　総合", ylab="人", main=paste("yyyyx質問", column[i], "_回答3", sep=""))
    dev.off()
  }

  #回答4 ヒストグラム ファイル書出
  {
    quartz(type="pdf", file=sprintf("yyyyx質問%s_回答4.pdf", column[i]))
    par(family="HiraKakuProN-W3")
    hist(data4$総合, col="cyan", xlab="yyyy　総合", ylab="人", main=paste("yyyyx質問", column[i], "_回答4", sep=""))
    dev.off()
  }
}
