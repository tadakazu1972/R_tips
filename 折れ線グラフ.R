#５歳階級　折れ線グラフ
#区名を最大値のX座標,Y座標に表示する

##################################################
#データ準備
#大阪市HPから推計人口　５歳階級のcsv取得
#Numbersで2017年11月と2017年12月分のデータ削除
#Rでそのファイルを読み込んで男女計の計のみをファイルに書き出し

data <- read.csv("20180101.csv", stringsAsFactors=F)
data_total <- data %>% filter(data$男女計=="計")
write.csv(data_total, "20180101_total.csv")

#Rの変数は数字・記号から始まることができないためcheck.names=Fを指定して再度読み込み
#ただしその副作用で$が使用できなくなるため、使うならば変数をバッククオート(SHIFT+@)で囲むこと
data <- read.csv("20180101_total.csv", check.names=F, stringsAsFactor=F)

##################################################
#24区の５歳階級別年齢を折れ線グラフで可視化
#区名をwhichとmaxを使って最大値のcolのインデックス,Y座標に表示する

for(i in 1:24){
 par(new=TRUE, family="HiraKakuProN-W3", xpd=TRUE, xaxt="n")
 plot(c(1:21), data[i,6:26], col=c(i), xlim=c(1, 21), ylim=c(0, 15000), main="区別　５歳階級別　推計人口　2018年1月1日現在", xlab="年齢", ylab="人")
 lines(c(1:21), data[i,6:26], col=c(i))
 text(which.max(data[i,6:26]), max(data[i,6:26])+500, labels=data[i,3], cex=0.8)
 par(xaxt="s")
 axis(side=1, at=1:21, labels=colnames(data)[6:26], cex=0.25)
}