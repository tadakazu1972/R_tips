#行列可視化 image　ファイル書出　全部
#mac mini 2011 core-i5 で３分程度
#前処理：エクセルファイルをcsvに変換して保存
#前処理：メモ帳などエディタで文字コードをUTF-8に変換
#前処理：元データのファイル名を「rawdata05.csv」に変更

library(readr)
library(dplyr)
library(RColorBrewer)

setwd("~/Desktop/work")

#あらかじめUTF-8変換済み
data <- read_csv("rawdata05.csv")

#学校NO1~49データ抽出ループ
for( schoolNO in 1:49){

  #学年3〜6ループ
  for( gakunen in 3:6){

    #data[,5]:LA1K05:１回目学年
    data0 <- data %>% filter(data$K02==schoolNO & data[,5]==gakunen)

    #調査回次1~5ループ
    for( kaiji in 1:5){
      
      #生徒IDを確保
      colnames <- data0$K01
      #colnamesの長さが0ということは、その学校NOが存在しないことになるため、処理をやめてループを抜ける
      if (length(colnames)==0) break
      
      #範囲抽出 設問1~23　※24は答えのスケールが6段階なので以降は捨てる
      start = 9+36*(kaiji-1)
      end   = 31+36*(kaiji-1)
  
      #データ抽出
      data1 <- data0[,start:end]

      #data.frameを行列変換 
      data1M <- data.matrix(data1)

      #NAを0変換
      data1M[is.na(data1M)]<-0
      
      #異常値99を0変換
      data1M[data1M>98]<-0

      #そのままだと左下が行列の(1,1)成分なので行の上下を順番に入れ替えて転置（90度回転）
      data1MT <- t(apply(data1M, 2, rev))

      #書き出しファイル設定 
      quartz(type="pdf", file=sprintf("学校%d学年%d調査回次%d.pdf", schoolNO, gakunen, kaiji))

      #文字化け
      par(family="HiraKakuProN-W3")

      #描画
      image(data1MT, col=brewer.pal(8, "Blues"), axes=FALSE, main=paste("学校NO:", schoolNO, "  学年:", gakunen, "  調査回次:", kaiji, seq=""))

      #横軸:設問1-23
      axis(side=3, at=seq(0, 1, length=23), labels=dimnames(data1MT)[[1]], cex.axis=0.3)

      #縦軸:生徒ID
      axis(side=2, at=rev(seq(0, 1, length=ncol(data1MT))), labels=colnames, las=TRUE, cex.axis=0.3)

      #描画終了
      dev.off()
    }
  }
}