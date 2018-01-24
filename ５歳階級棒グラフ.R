#5歳階級　人口　棒グラフ

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

for(i in 1:24){
 par(new=TRUE, family="HiraKakuProN-W3", xpd=TRUE, xaxt="n")
 plot(c(1:21), data[i,6:26], col=c(i), xlim=c(1, 21), ylim=c(0, 15000), main="区別　５歳階級別　推計人口　2018年1月1日現在", xlab="年齢", ylab="人")
 lines(c(1:21), data[i,6:26], col=c(i))
 text(21, data[i,16]+10, labels=data[i,3], cex=0.8)
 par(xaxt="s")
 axis(side=1, at=1:21, labels=colnames(data)[6:26], cex=0.25)
}

#棒グラフ
#24区分をファイルに書き出し
for(i in 1:24){
  quartz(type="pdf", file=sprintf("区別５歳階級別推計人口_%d%s.pdf", i, data[i,3]))
  .main=paste(data[i,3], "　５歳階級別　推計人口　2018年1月1日現在", sep="")
  par(new=TRUE, family="HiraKakuProN-W3", xpd=TRUE)
  barplot(as.integer(data[i,6:26]), width=0.9, col=2, xlim=c(1, 21), ylim=c(0, 15000), main=.main, xlab="", ylab="人", names.arg=c("０~４歳","５～９歳","10～14歳","15～19歳","20～24歳","25～29歳","30～34歳","35～39歳","40～44歳","45～49歳","50～54歳","55～59歳","60～64歳","65～69歳","70～74歳","75～79歳","80～84歳","85～89歳","90～94歳","95～99歳","100歳以上"), las=2)
  dev.off()
}
