library(readr)
library(dplyr)

setwd("~/Desktop/work")

data <- read_csv("xxxx.csv", locale=locale(encoding="CP932"))

#結果を格納するオブジェクトをNULLで定義しておく（後述のforループでrbind結合時にエラーを出させないため）
dataAll <- NULL

column <- colnames(data)

#カラム85-119の差の人数を算出し、列でつなげてファイルで書き出す
for(i in 85:119){

  #xの差分:カラム85から
  data1 <- aggregate(x=list(人=data[[column[i]]]), by=list(H28H29差=data[[column[i]]]), FUN=length)

  #差分マイナスが下に位置するように降順で並べ替え
  data1 <- data1 %>% arrange(desc(H28H29差))

  #新たに列追加：質問番号
  data2 <- mutate(data1, 質問=(i-84))

  #質問番号の列を先頭に位置変更するため列を並び替え
  data3 <- data2[,c(3,1,2)]

  #人の割合(%)を計算して新たなカラムとして追加
  data4 <- mutate(data3, 割合=sprintf("%5.2f", 人/sum(人)*100))

  #結果オブジェクトに連結
  dataAll <- rbind(dataAll, data4)
}

#結果をファイル書き出し
write.csv(dataAll, "yyyy.csv", fileEncoding="CP932", row.names=FALSE)
