# 住基データ区別町丁目別のcsvファイルを１つのファイルにする
# Windowsで利用前提として文字コードはSHIFT-JISのまま

# 事前準備
# 市HP住民基本台帳人口から、24区分のCSVをダウンロード
# デスクトップにjinkoフォルダを作成し、ダウンロードしたファイルを移動
# RStudio立ち上げ

# 作業ディレクトリ　RStudioのSessionで変更するほうが楽
setwd("C:/Users/tadak/Desktop/jinko")

# フォルダ内のCSVファイルをリスト化
csvlist <- list.files(pattern = "*.csv") 

# read.csvのstringsAsFactors=FALSEにすることで、千単位に入っているカンマがあると自動でFactor型に変換してしまうことを防ぎcharacter型にしておく。あとで数値型に変換する
# rbindで１つのデータフレームとして統合する
data <- do.call(rbind, lapply(csvlist, function(x) read.csv(x, header=TRUE, stringsAsFactors=FALSE)))

# 変数5番目から109番目まで、千単位のカンマを置換で消去、characterとして認識されているので数値変換
# 変数1番目から実行してしまうと町丁目名がNAになるので注意！
for(i in 5:109){
    data[,i] <- sub(",","", data[,i])
    data[,i] <- as.numeric(data[,i])
}

# １つのcsvファイルとしてdataを書き出す
write.csv(data, "all.csv")