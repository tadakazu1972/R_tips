library(readr)
library(dplyr)

setwd("~/Desktop/work")

#csvファイル読み込み　Windows作業そのままCP932で読み込み
data <- read_csv("xxxx.csv", locale=locale(encoding="CP932"))

#インデックス操作するためカラム取得
column <- colnames(data)

#結果を格納するオブジェクトをNULLで定義しておく（後述のforループでrbind結合時にエラーを出させないため）
dataAll <- NULL

#質問1-35までの回答1-4毎の総合の人数と平均を算出し、列でつなげてファイルで書き出す
for(i in 19:53){

  #質問の回答1-4毎の回答数 #17:総合 19:質問1
  data1 <- aggregate(x=list(人=data[[column[17]]]), by=list(学校=data[[column[2]]], 回答=data[[column[i]]]), FUN=length)
  #学校、回答の順に並べ替え
  data1 <- data1 %>% arrange(学校, 回答)

  #質問の回答1-4毎の総合の平均
  data2 <- aggregate(x=list(総合=data[[column[17]]]), by=list(学校=data[[column[2]]], 回答=data[[column[i]]]), FUN=mean)
  #学校、回答の順に並べ替え
  data2 <- data2 %>% arrange(学校, 回答)

  #総合の回答人数と平均を結合
  data3 <- left_join(data1, data2)

  #新たに列追加：質問番号
  data3 <- mutate(data3, 質問=(i-18))

  #質問番号の列を先頭に位置変更するため列を並び替え
  data4 <- data3[,c(1,5,2,3,4)]

  #結果オブジェクトに連結
  dataAll <- rbind(dataAll, data4)
}

#最後に、学校、質問の順で並び替え
dataAll <- dataAll %>% arrange(学校,質問)

#結果をファイル書き出し
write.csv(dataAll, "yyyy.csv", fileEncoding="CP932", row.names=FALSE)
