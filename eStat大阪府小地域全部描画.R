#ライブラリ読込
library(dplyr)
library(sf)
library(readr)
library(RColorBrewer)
library(classInt)

#作業ディレクトリ指定
setwd("~/Documents/****")

#必要なファイル読込
shape <- st_read("h27ka27.shp") #eStatから大阪府を取得

#境界線を濃い緑で描画
plot(shape[,2], border='green4')

#世帯/人口　可視化
shape <- shape %>% mutate(TANSIN=SETAI/JINKO)
plot(shape[,36])

#大阪市のみ描画
plot(shape[2:1914,36])
