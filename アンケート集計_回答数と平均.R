library(readr)
library(dplyr)

setwd("~/Desktop/work")

#アンケートcsvファイル読み込み　Windows作業そのままCP932で読み込み
data <- read_csv("xxxx.csv", locale=locale(encoding="CP932"))

#インデックス操作するためカラム取得
column <- colnames(data)

#結果を格納するオブジェクトをNULLで定義しておく（後述のforループでrbind結合時にエラーを出させないため）
dataAll <- NULL

#質問1-35までの回答1-4毎の総合の人数と平均を算出し、列でつなげてファイルで書き出す
for(i in 19:53){

  #質問の回答1-4毎の回答数 #17:総合 19:質問1
  data1 <- aggregate(x=list(人=data[[column[17]]]), by=list(回答=data[[column[i]]]), FUN=length)

  #質問の回答1-4毎の総合の平均
  data2 <- aggregate(x=list(総合=data[[column[17]]]), by=list(回答=data[[column[i]]]), FUN=mean)

  #総合の回答人数と平均を結合
  data3 <- left_join(data1, data2)

  #新たに列追加：質問番号
  data3 <- mutate(data3, 質問=(i-18))

  #質問番号の列を先頭に位置変更するため列を並び替え
  data4 <- data3[,c(4,1,2,3)]

  #結果オブジェクトに連結
  dataAll <- rbind(dataAll, data4)
}

#結果をファイル書き出し
write.csv(dataAll, "yyyy.csv", fileEncoding="CP932", row.names=FALSE)
