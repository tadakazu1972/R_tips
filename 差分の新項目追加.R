library(readr)
library(dplyr)

setwd("~/Desktop/work")

data1 <- read_csv("xxxx.csv", locale=locale(encoding="CP932"))
data2 <- read_csv("yyyy.csv", locale=locale(encoding="CP932"))

#カラム名読み込み
column <- colnames(data1)
data <- inner_join(data1, data2, by=c(column[1],column[7]))

#改めて新テーブルのカラム名読み込み
column <- colnames(data)

#ｘの特定カラム NAを0置換
for (i in 9:43){
  data[[column[i]]][is.na(data[[column[i]]])]<-0
}

#ｘの特定カラム NAを0置換
for (i in 50:84){
  data[[column[i]]][is.na(data[[column[i]]])]<-0
}

#差分計算して、結果を新カラムとして追加
data <- data %>% mutate("1.z"=(data[[column[9]]]-data[[column[50]]]),
                        "2.z"=(data[[column[10]]]-data[[column[51]]]),
                        "3.z"=(data[[column[11]]]-data[[column[52]]]),
                        "4.z"=(data[[column[12]]]-data[[column[53]]]),
                        "5.z"=(data[[column[13]]]-data[[column[54]]]),
                        "6.z"=(data[[column[14]]]-data[[column[55]]]),
                        "7.z"=(data[[column[15]]]-data[[column[56]]]),
                        "8.z"=(data[[column[16]]]-data[[column[57]]]),
                        "9.z"=(data[[column[17]]]-data[[column[58]]]),
                        "10.z"=(data[[column[18]]]-data[[column[59]]]),
                        "11.z"=(data[[column[19]]]-data[[column[60]]]),
                        "12.z"=(data[[column[20]]]-data[[column[61]]]),
                        "13.z"=(data[[column[21]]]-data[[column[62]]]),
                        "14.z"=(data[[column[22]]]-data[[column[63]]]),
                        "15.z"=(data[[column[23]]]-data[[column[64]]]),
                        "16.z"=(data[[column[24]]]-data[[column[65]]]),
                        "17.z"=(data[[column[25]]]-data[[column[66]]]),
                        "18.z"=(data[[column[26]]]-data[[column[67]]]),
                        "19.z"=(data[[column[27]]]-data[[column[68]]]),
                        "20.z"=(data[[column[28]]]-data[[column[69]]]),
                        "21.z"=(data[[column[29]]]-data[[column[70]]]),
                        "22.z"=(data[[column[30]]]-data[[column[71]]]),
                        "23.z"=(data[[column[31]]]-data[[column[72]]]),
                        "24.z"=(data[[column[32]]]-data[[column[73]]]),
                        "25.z"=(data[[column[33]]]-data[[column[74]]]),
                        "26.z"=(data[[column[34]]]-data[[column[75]]]),
                        "27.z"=(data[[column[35]]]-data[[column[76]]]),
                        "28.z"=(data[[column[36]]]-data[[column[77]]]),
                        "29.z"=(data[[column[37]]]-data[[column[78]]]),
                        "30.z"=(data[[column[38]]]-data[[column[79]]]),
                        "31.z"=(data[[column[39]]]-data[[column[80]]]),
                        "32.z"=(data[[column[40]]]-data[[column[81]]]),
                        "33.z"=(data[[column[41]]]-data[[column[82]]]),
                        "34.z"=(data[[column[42]]]-data[[column[83]]]),
                        "35.z"=(data[[column[43]]]-data[[column[84]]]))

#ファイルに書き出し
write.csv(data, "zzzz.csv", fileEncoding="CP932", row.names=FALSE)
