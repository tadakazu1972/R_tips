#東淀川区
#待機児童、保育所位置　可視化

#ライブラリ読込
library(dplyr)
library(sf)
library(readr)
library(RColorBrewer)
library(classInt)

#作業ディレクトリを作成して指定(Mac)
setwd("~/Desktop/work")

#シェープファイル読込
#.dbf .prj .shxも合わせて作業ディレクトリに入れておくべし。
shape <- st_read("h27ka27114.shp") 

#待機児童数csv読込
data1 <- read_csv("taiki.csv", locale=locale(encoding="SJIS"))

#shapeファイルとcsvを結合
data <- left_join(shape, data1, by=c("MOJI"="町丁目名"))

#保育所csv, 企業型csv読込
hoikusyo <- read_csv("sukusukudata.csv")
kigyo <- read_csv("sukusukudata3.csv")

column="０歳"
kuname="東淀川区"

column <- c("０歳","１歳","２歳","３歳","４歳","５歳")

for(i in 1:6){
  #pdf書き出し
  quartz(type="pdf", file=sprintf("%s%s.pdf", kuname, column[i]))
  
  #mexで拡大率を操作
  par(mex="0.3", family="HiraKakuProN-W3")
  
  #描画
  #カラーパレット作成
  pal <- c("white", "green3")
  cls <- classIntervals(data[[column[i]]], n=10, style="equal")
  color.pal <- findColours(cls, pal)
  #col_km <- data[[column[i]]] %>% classIntervals(., 7, style="fixed", fixedBreaks=c(min(.),1,2,3,4,5,max(.))) %>% findColours(.,pal=brewer.pal(7,"Greens"))
  plot(st_geometry(shape[7]), col=color.pal, main=paste(kuname, column[i], " (平成30年4月1日現在)", sep="　"))
  text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2], labels=shape$MOJI, cex=0.4)
  text(st_coordinates(shape %>% st_centroid)[,1], st_coordinates(shape %>% st_centroid)[,2]-0.0007, labels=data[[column[i]]], cex=0.6)

  #保育所　描画　該当区だけ抽出
  hoikusyo <- hoikusyo %>% filter(hoikusyo$区==kuname)
  points(hoikusyo$経度, hoikusyo$緯度, pch=16, col="red")
  
  #企業型
  kigyo <- kigyo %>% filter(kigyo$区==kuname)
  points(kigyo$経度, kigyo$緯度, pch=17, col="blue")
  
  #描画終了
  dev.off()
}