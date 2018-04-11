# Rでtweet取得
# 前作業1: https://apps.twitter.com/　にアクセス
# アプリのCallback URL: http://127.0.0.1:1410　を設定
# APPNAME, CONSUMERKEY, CONSUMERSECRETをあとで使用する
# 事前インストールしたパッケージ:
# rtweet, rjson, DBI, httr, base64enc, httpuv

#ライブラリ
library(rtweet)
library(dplyr)

＃作業ディレクトリ設定
setwd("~/Documents/TweetXX")

#特定アカウントのツイート取得
APPNAME = "XXXX"
CONSUMERKEY = "YYYY"
CONSUMERSECRET = "ZZZZ"

twitter_token = create_token(
 app = APPNAME,
 consumer_key = CONSUMERKEY,
 consumer_secret = CONSUMERSECRET )

tweet = get_timeline("nishiyodo_ku", n = 100, token = twitter_token)


#キーワード検索でツイート取得 15分制約最大18000件にすると５分？くらいかかる
tweet <- search_tweets("東西区", n=18000, include_rts = FALSE)

#取得した概要確認
str(tweet)

#ツイート表示
tweet$text

#################################################
#　時間ごとにツイートを集計

#ツイートした日時とテキストを抽出 $created_atが２番目、$textが５番目
data <- tweet[, c(2,5)]
write.csv(data, "tweet_some.csv")

library(lubridate)

#分ごとにツイート件数を集計
time_tweet <- tweet %>% group_by(m = floor_date(created_at, unit = "minute")) %>% summarise(count = n())

#とりあえず可視化
par(family="HiraKakuProN-W3")
plot(time_tweet, type="l")

#################################################
#Word Cloud

library(RMeCab)
library(wordcloud)

#ツイートをすべてつなぎ合わせて、ひとつのファイルに保存
tweet1 <- tweet$text
tweets_all = ""
for (i in 1:length((tweet1))){
  tweets_all = paste(tweets_all, tweet1[i], seq="")
}
write.table(tweets_all, "xxx.txt")

#テキストファイルから形態素解析
docDF0 = docDF("xxx.txt", type=1)

#名詞情報かつ非自立でないものを抽出
docDF1 = docDF0 %>% filter(POS1 %in% c("名詞"), POS2 != "非自立")

#Word Cloud
par(family="HiraKakuProN-W3")
wordcloud(docDF1$TERM, docDF1$xxx.txt, min.freq=3, colors=brewer.pal(8, "Dark2"))


#################################################
# キーワード登場順にソート
data <- RMecabFreq("xxxx.txt")

#名詞だけ取り出してデータフレームdata_nounへ
data_noun <- data[data[,2]=="名詞",]

#3回以上登場する名詞の数 data[,4]で"Freq"列を参照
nrow(data_noun <- data[data[,2]=="名詞" & data[,4] > 2,])

#data_nounをFreqで降順ソート
data_noun[rev(order(data_noun$Freq)),]

#################################################
# 上の結果をグラフ化
library(ggplot2)

# 1列目と4列目を抜き出してデータフレームを作成
data_noun2 <- data.frame(word=as.character(data_noun[,1]), freq=data_noun[,4])

# 上位25位に絞り込む
data_noun2 <- subset(data_noun2, rank(-freq)<25)

# ggplotでグラフ
ggplot(data_noun2, aes(x=reorder(word,freq), y=freq)) +
  geom_bar(stat = "identity", fill="grey") +
  theme_bw(base_size = 10, base_family = "HiraKakuProN-W3") +
  coord_flip()


#################################################
# その他

#ツイートのみをcsvとして保存
csv = tweet$text
write.csv(csv, "tweet_data.csv")


#取得したツイートをファイルとして保存。テキストデータではない！
save(tweet, file="tweet_XX.dat")

#保存したツイートのファイルを読み込み
load("tweet_xx.dat")
