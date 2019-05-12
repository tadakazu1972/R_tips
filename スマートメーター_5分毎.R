library(openxlsx) #インストールしてなければ -> install.packages('openxlsx')
library(dplyr)
library(RColorBrewer)
library(classInt)

setwd("~/Desktop/水道")

#xlsx読込
data <- read.xlsx("131_20181128-20181216.xlsx")

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

#とりあえず全体をプロット:Timeをx軸に使う
plot(data$Time, data$Amount, type="l")

#12月5日を抽出 subset
data_1205 <- subset(data, data$"data/Time" >= 181205000 & data$"data/Time" < 1812060000)
plot(data_1205$Time, data_1205$Amount, type="l")

#12月7日,8日を抽出 filter
data_1207 <- data %>% filter(data$Day==7)
data_1208 <- data %>% filter(data$Day==8)

#重ねて描画
plot(data_1207$Hourmin, data_1207$Amount, ylim=c(0,700), col=1, type="l")
par(new=T)
plot(data_1208$Hourmin, data_1208$Amount, ylim=c(0,700), col=2, type="l")
