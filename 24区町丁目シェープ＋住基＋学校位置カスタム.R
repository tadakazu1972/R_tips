#24区町丁目シェープファイル書き出し
#前処理：作業フォルダ[work]をデスクトップに作成
#前処理：24区すべてのシェープファイルをフォルダ名[24shapeAll]として作業フォルダにコピーしておく
#前処理：24区すべての描画したい住基データをフォルダ名[JyukiH2909]として作業フォルダにコピーしておく　※フォルダ内のファイルの順番は区と同じになるよう気をつけること
#前処理：オープンデータポータルから学校情報のcsvをダウンロード
#前処理：学校基本統計の生徒数を学校情報のcsvの最後カラムに追加して作業フォルダにコピーしておく

#ライブラリ読込
library(dplyr)
library(sf)
library(readr)
library(RColorBrewer)
library(classInt)

#作業ディレクトリ
setwd("~/Desktop/work")

#区名
kuName <- c("北区","都島区","福島区","此花区","中央区","西区","港区","大正区","天王寺区","浪速区","西淀川区","淀川区","東淀川区","東成区","生野区","旭区","城東区","鶴見区","阿倍野区","住之江区", "住吉区", "東住吉区", "平野区","西成区")

#24区シェープファイル名　設定
shapeFile <- c("h27ka27127.shp","h27ka27102.shp","h27ka27103.shp","h27ka27104.shp","h27ka27128.shp","h27ka27106.shp","h27ka27107.shp","h27ka27108.shp","h27ka27109.shp","h27ka27111.shp","h27ka27113.shp","h27ka27123.shp","h27ka27114.shp","h27ka27115.shp","h27ka27116.shp","h27ka27117.shp","h27ka27118.shp","h27ka27124.shp","h27ka27119.shp","h27ka27125.shp","h27ka27120.shp","h27ka27121.shp","h27ka27126.shp","h27ka27122.shp")

#24区住基データ csvファイル名　設定
csvFile <- list.files(path="JyukiH2909")

#小中学校のデータ読込 オープンデータポータルから
sisetsu <- read_csv("shochugakkou.csv")

for(i in 1:24){
  #シェープファイル読み込み
  shape <- st_read(paste("24shapeAll/", shapeFile[i], sep=""))
  
  #住民基本台帳データ 文字コードShift-JISを変換指定しないとエラーになる
  data1 <- read_csv(paste("JyukiH2909/", csvFile[i], sep=""), locale=locale(encoding="SJIS")) 
  
  #男女別が「計」のデータだけ抽出
  data2 <- data1 %>% filter(data1$男女別=="計")

  #shapeファイルとcsvを結合
  data <- left_join(shape, data2, by=c("MOJI"="町丁目名"))
  
  #生徒数を足し算：住基データのカラム名に変更していく　数字は「全角」に注意!
  num <- data$６歳+data$７歳+data$８歳+data$９歳+data$１０歳+data$１１歳+data$１２歳
  
  #住基人口データに基づいて色付け とりあえず8段階にわけている
  col_km <- num %>% classIntervals(., 8, style="fixed", fixedBreaks=c(19,20,40,60,80,100,120,140,max(.))) %>% findColours(.,pal=brewer.pal(6,"Greens"))
  
  #書き出しファイル設定 
  quartz(type="pdf", file=sprintf("%02d%s.pdf",i, kuName[i]))
  
  #quartz設定(Mac文字化け解消) 
  par(family="HiraKakuProN-W3", xpd=TRUE, xaxt="n")
  
  #描画
  plot(st_geometry(shape[7]), col=col_km, main=paste(kuName[i], "  ６歳〜12歳(平成29年9月末現在)", sep=""))
  text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2], labels=shape$MOJI, cex=0.4)
  text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2]-0.0007, labels=num, cex=0.7)
  
  #小学校　描画　該当区だけ抽出
  elementary <- sisetsu %>% filter(sisetsu$地区名==kuName[i] & sisetsu$小分類=="小学校")
  points(elementary$X, elementary$Y, ps=24, pch=15, col="red")
  text(elementary$X, elementary$Y-0.0007, labels=elementary$施設名, cex=0.7)
  
  #中学校
  junior <- sisetsu %>% filter(sisetsu$地区名==kuName[i] & sisetsu$小分類=="中学校")
  points(junior$X, junior$Y, ps=24, pch=16, col="blue")
  text(junior$X, junior$Y-0.0007, labels=junior$施設名, cex=0.7)
    
  #描画終了
  dev.off()
}