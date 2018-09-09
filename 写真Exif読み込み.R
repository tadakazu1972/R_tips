library("exifr")

setwd("~/Desktop/work")

#exifデータ読み込み
data <- read_exif("image.jpg", args= NULL)

#csvに書き出し
write.csv(data, "exifdata.csv", fileEncoding="CP932")
