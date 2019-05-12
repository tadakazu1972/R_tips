library(openxlsx) #インストールしてなければ -> install.packages('openxlsx')
library(dplyr)

setwd("~/Desktop/水道/data/")

#元データのファイルをdataフォルダに展開して一気に読み込み
#カレントディレクトリ下のファイル名を全て取得
files <- list.files()

for (i in 1:length(files)){
  #ファイル名から先頭3桁を変数名に
  assign(paste("data", substr(as.character(files[i]),1,3), sep="_"), read.xlsx(files[i]))
}

#まずはdata_131を1日ごとに書き出し
data <- data_131

#データが上下逆なので降順でソート カンマを忘れないように注意
data <- data[order(data$"data/Time"),]

#data/Timeの文字列を分解
year  <- as.numeric(substr(data$"data/Time", 1, 2)) + 2000
month <- as.numeric(substr(data$"data/Time", 3, 4))
day   <- as.numeric(substr(data$"data/Time", 5, 6))
hour  <- as.numeric(substr(data$"data/Time", 7, 8))
min   <- as.numeric(substr(data$"data/Time", 9,10))
hourmin <- hour * 100 + min
time  <- ISOdate(year, month, day, hour, min)

#後でフィルターかけやすいように新規列として、上記各項目を追加
data <- data %>% mutate(Year=year,Month=month,Day=day,Hour=hour,Min=min,Time=time, Hourmin=hourmin)

#累積値から使用量を算出する。diff()じゃなくてlag()を使用
#水道使用量を文字列から整数値に変換
data$"data/Dearee" <- as.integer(data$"data/Dearee")
data <- data %>% mutate(Amount =  data$"data/Dearee" - lag(data$"data/Dearee"))

#1日ごとにpngで切り出し
#全世帯は6日-16日開始すれば揃う
for(i in 6:16){
  #書き出しファイル設定
  quartz(type="png", file=sprintf("data_131_%s.png",i), dpi=144, bg="white")
  data_temp <- data %>% filter(data$Day==i)

  #描画設定
  par(family="HiraKakuProN-W3")
  plot(data_temp$Hourmin, data_temp$Amount, ylim=c(0,700), col=2, type="l", main=paste(files[1], i, "日", sep="　"), xlab="時間", ylab="水道使用量")

  dev.off()
}


#12月7日,8日を抽出 filter
data_1207 <- data %>% filter(data$Day==7)
data_1208 <- data %>% filter(data$Day==8)

#重ねて描画
plot(data_1207$Hourmin, data_1207$Amount, ylim=c(0,700), col=1, type="l")
par(new=T)
plot(data_1208$Hourmin, data_1208$Amount, ylim=c(0,700), col=2, type="l")
