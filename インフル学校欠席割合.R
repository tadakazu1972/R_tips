#ライブラリ読込
library(dplyr)
library(sf)
library(readr)
library(RColorBrewer)
library(classInt)

#作業ディレクトリ指定
setwd("~/Desktop/インフル")

#日本のシェープファイル読込
shape <- st_read("JPN_adm1.shp")

#インフル欠席者数
data1 <- read.csv("インフル学校2018_19.csv", fileEncoding="CP932")

#結合
data <- left_join(shape, data1, by=c("NL_NAME_1"="都道府県"))

#色　欠席者数のとき
#col_km <- data$患者数 %>% classIntervals(., 7, style="fixed", fixedBreaks=c(min(.),100,300,700,1000,2000,max(.))) %>% findColours(.,pal=brewer.pal(7,"Reds"))

#色　欠席者数/在籍者数*100 少数点以下1桁で四捨五入
temp <- round((data$患者数 / data$在籍者数)*100, digits = 1)
col_km <- temp %>% classIntervals(., 7, style="fixed", fixedBreaks=c(min(.),10,20,30,40,50,max(.))) %>% findColours(.,pal=brewer.pal(7,"Reds"))

#文字化け
par(family="HiraKakuProN-W3")

plot(st_geometry(shape[5]), col=col_km, main="インフルエンザ　学校欠席割合(%) (平成31年1月13日現在)")

#text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2], labels=shape$NL_NAME_1, cex=0.4)

text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2]-0.0007, labels=temp, cex=0.3)
