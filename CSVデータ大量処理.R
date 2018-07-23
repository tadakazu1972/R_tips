library(readr)
library(dplyr)

setwd("~/Desktop/work")

#csvファイル　Windows作業そのままCP932で読み込み
data <- read_csv("H28question.csv", locale=locale(encoding="CP932"))

#NAを0置換　平均をとるため１つでもNAが混じると答えがNAとなるのを防止
data[is.na(data)] <- 0

#データ項目を呼び出ししやすくするため項目名を代入
column <- colnames(data)

#データ項目名が数字で始まるため``で囲む　data$`1`
#data1 <- data %>% group_by(学校名) %>% summarise(avg=mean(data$`1`))

#全部のカラムがmeanで計算される
data1 <- data %>% group_by(学校名) %>% summarise_all(mean)

#学校名と9:43しかなくなる
data2 <- data %>% group_by(学校名) %>% select(9:43) %>% summarise_all(mean)
