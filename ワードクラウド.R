#ライブラリ
library(dplyr)
library(RMeCab)
library(wordcloud)

#作業ディレクトリ
setwd("~/Desktop/work")

#文書読み込み
docDF0 = docDF("ICT1.txt", type=1)
docDF1 = docDF0 %>% filter(POS1 %in% c("名詞"), POS2 != "非自立")

#wordcloud描画
par(family="HiraKakuProN-W3")
wordcloud(docDF1$TERM, docDF1$ICT1.txt, min.freq=3, colors=brewer.pal(8, "Dark2"))