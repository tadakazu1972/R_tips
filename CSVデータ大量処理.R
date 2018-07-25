library(readr)
library(dplyr)

setwd("~/Desktop/work")

#csvファイル　Windows作業そのままCP932で読み込み
data <- read_csv("H28question.csv", locale=locale(encoding="CP932"))

#NAを0置換　平均をとるため１つでもNAが混じると答えがNAとなるのを防止
data[is.na(data)] <- 0

#データ項目を呼び出ししやすくするため項目名を代入
column <- colnames(data)

#集約
data1 <- data %>% group_by(学校名,学年) %>% summarise_at(c(9:43),mean)

#csv書き出し 標準はutf-8になるので、あとでExcelで読めるようにCP932でエンコーディング　行見出しを自動でつけない指定あり
write.csv(data1, "xxxx.csv", fileEncoding="CP932", row.names=FALSE)
