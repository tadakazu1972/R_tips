# 5歳階級作成して境界図と結合してプロット
library(dplyr)
library(readr)
library(sf)
library(RColorBrewer)
library(classInt)

# 必要なファイル読込
# eStatから大阪府を取得
shape <- st_read("h27ka27.shp")
data1 <- read_csv("all.csv", locale=locale(encoding="SJIS"))

data2 <- data1 %>% filter(data1[, 5]=="計")

# 60歳以上5歳階級のカラムをデータフレームの最後尾に追加
data2 <- data2 %>% mutate('60-64歳' = select(.,c(69,70,71,72,73)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('65-69歳' = select(.,c(74,75,76,77,78)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('70-74歳' = select(.,c(79,80,81,82,83)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('75-79歳' = select(.,c(84,85,86,87,88)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('80-84歳' = select(.,c(89,90,91,92,93)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('85-89歳' = select(.,c(94,95,96,97,98)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('90-94歳' = select(.,c(99,100,101,102,103)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('95-99歳' = select(.,c(104,105,106,107,108)) %>% rowSums(na.rm=TRUE))
# 友淵１丁目が突出するため10歳階級も追加
data2 <- data2 %>% mutate('60-69歳' = select(.,c(69,70,71,72,73,74,75,76,77,78)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('70-79歳' = select(.,c(79,80,81,82,83,84,85,86,87,88)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('80-89歳' = select(.,c(89,90,91,92,93,94,95,96,97,98)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('90-99歳' = select(.,c(99,100,101,102,103,104,105,106,107,108)) %>% rowSums(na.rm=TRUE))
# 65歳以上積み上げ
data2 <- data2 %>% mutate('65歳以上' = select(.,c(74:109)) %>% rowSums(na.rm=TRUE))
# 75歳以上積み上げ
data2 <- data2 %>% mutate('75歳以上' = select(.,c(84:109)) %>% rowSums(na.rm=TRUE))

# 確認できるようにcsv書き出しておく
write.csv(data2, "all_sum.csv")

# 境界図と統合
data <- left_join(shape, data2, by=c("S_NAME"="町丁目名"))

# 色の設定
# データの区切りを75歳以上を見たいので50で区切ってみる
# 大きい値を明るく、小さい値を暗くしたいのでrev()を使用
temp = data2[,124]
colset <- temp %>% classIntervals(., 10, style="fixed", fixedBreaks=c(49,50,100,150,200,250,300,350,400,450,max(.))) %>% findColours(.,pal=rev(brewer.pal(10,"YlGnBu")))

colset <- classIntervals(data[,158], 10, style="fixed", fixedBreaks=c(49,50,100,150,200,250,300,350,400,450)) %>% findColours(.,pal=rev(brewer.pal(10,"YlGnBu")))

# 可視化　2:1914が大阪府のうち大阪市の町丁目の範囲
# 145:60-64歳 - 158:75歳以上
plot(data[2:1914, 145], col=colset)