#区　町丁目　住基データ　可視化

#ライブラリ読込
library(dplyr)
library(sf)
library(readr)
library(RColorBrewer)
library(classInt)

#作業ディレクトリを作成して(この場合はhoiku)指定(Mac)
setwd("~/Desktop/hoiku")

#シェープファイル読込
#eStatから取得：例は北区。.dbf .prj .shxも合わせて作業ディレクトリに入れておくべし。
shape <- st_read("h27ka27127.shp") 

#住民基本台帳データ 文字コードShift-JISを変換指定しないとエラーになる
data1 <- read_csv("01kitaJyukiH2909.csv", locale=locale(encoding="SJIS")) 

#男女別が「計」のデータだけ抽出
data2 <- data1 %>% filter(data1$男女別=="計")

#shapeファイルとcsvを結合
data <- left_join(shape, data2, by=c("MOJI"="町丁目名"))

#０歳　描画
par(family="HiraKakuProN-W3") #Macの文字化け解消おまじない

column <- "１歳" #ここを１歳、２歳と住基データのカラム名に変更していく　数字は「全角」に注意!
kuname <- "北区" #ここを変更

col_km <- data[[column]] %>% classIntervals(., 6, style="fixed", fixedBreaks=c(9,10,20,30,40,50,max(.))) %>% findColours(.,pal=brewer.pal(6,"Greens"))
plot(st_geometry(shape[7]), col=col_km, main=paste(kuname, column, "  (平成29年9月末現在)", sep=""))
text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2], labels=shape$MOJI, cex=0.5)
text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2]-0.0007, labels=data[[column]], cex=0.7)

#保育所　描画
#すべての認可保育園データ読み込み（幼稚園保育所マップで毎月更新しているデータ）
hoikusyo1 <- read_csv("sukusukudata.csv")

#該当区だけ抽出
hoikusyo2 <- hoikusyo1 %>% filter(hoikusyo1$区==kuname)
points(hoikusyo2$経度, hoikusyo2$緯度, pch=16, col="red")
#施設名も描画するとごちゃごちゃなのでとりあえず実行しない
#text(hoikusyo2$経度, hoikusyo2$緯度+0.0007, labels=hoikusyo2$施設名, cex=1)

#企業型保育事業　描画
#すべての企業型保育事業データ読み込み（幼稚園保育所マップで毎月更新しているデータ）
kigyo1 <- read_csv("sukusukudata3.csv")

#該当区だけ抽出
kigyo2 <- kigyo1 %>% filter(kigyo1$区==kuname)
points(kigyo2$経度, kigyo2$緯度, pch=17, col="blue")


#######################################################################
#　０歳〜５歳までを一気にpdfで書き出す

#区名
kuname <- "旭区"

#ファイル接頭番号
kuindex <- "16"

#シェープファイル読込
shape <- st_read("h27ka27117.shp") 

#住民基本台帳データ読込
data1 <- read_csv("16asahiJyukiH2909.csv", locale=locale(encoding="SJIS")) 

#男女別が「計」のデータだけ抽出
data2 <- data1 %>% filter(data1$男女別=="計")

#shapeファイルとcsvを結合
data <- left_join(shape, data2, by=c("MOJI"="町丁目名"))

#保育所データ、企業型保育事業データ読み込み
hoikusyo1 <- read_csv("sukusukudata.csv")
kigyo1 <- read_csv("sukusukudata3.csv")

column <- c("０歳","１歳","２歳","３歳","４歳","５歳")

for(i in 1:6){
  #書き出しファイル設定 ファイル名の並び替えのため区が変わるたびにインデックスを変更していくべし
  quartz(type="pdf", file=sprintf("%s%s%s.pdf",kuindex, kuname, column[i]))
  
  #quartz設定
  par(family="HiraKakuProN-W3", xpd=TRUE, xaxt="n")
  
  #人口　描画
  col_km <- data[[column[i]]] %>% classIntervals(., 6, style="fixed", fixedBreaks=c(9,10,20,30,40,50,max(.))) %>% findColours(.,pal=brewer.pal(6,"Greens"))
  plot(st_geometry(shape[7]), col=col_km, main=paste(kuname, column[i], "  (平成29年9月末現在)", sep=""))
  text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2], labels=shape$MOJI, cex=0.5)
  text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2]-0.0007, labels=data[[column[i]]], cex=0.7)

  #保育所　描画  該当区だけ抽出
  hoikusyo2 <- hoikusyo1 %>% filter(hoikusyo1$区==kuname)
  points(hoikusyo2$経度, hoikusyo2$緯度, pch=16, col="red")
  
  #企業型保育事業　描画  該当区だけ抽出
  kigyo2 <- kigyo1 %>% filter(kigyo1$区==kuname)
  points(kigyo2$経度, kigyo2$緯度, pch=17, col="blue")
  
  #描画終了
  dev.off()
}