# Rでtweet取得
# 前作業1: https://apps.twitter.com/　にアクセス
# アプリのCallback URL: http://127.0.0.1:1410　を設定
# APPNAME, CONSUMERKEY, CONSUMERSECRETをあとで使用する
# 事前インストールしたパッケージ:
# rtweet, rjson, DBI, httr, base64enc, httpuv
library(rtweet)

setwd("~/Documents/TweetXX")

APPNAME = "XXXX"
CONSUMERKEY = "YYYY"
CONSUMERSECRET = "ZZZZ"

twitter_token = create_token(
 app = APPNAME,
 consumer_key = CONSUMERKEY,
 consumer_secret = CONSUMERSECRET )

#特定アカウントのツイート取得
tweet = get_timeline("nishiyodo_ku", n = 100, token = twitter_token)

#キーワード検索でツイート取得
x <- search_tweets("東西区", include_rts = FALSE)

#ツイートした日時とテキストを抽出 $created_atが２番目、$textが５番目
data <- tweet[, c(2,5)]
write.csv(data, "tweet_some.csv")

#概要
str(tweet)

#ツイート表示
tweet$text

#ツイートのみをcsvとして保存
csv = tweet$text
write.csv(csv, "tweet_data.csv")

#取得したツイートをファイルとして保存。テキストデータではない！
save(tweet, "tweet_XX.dat")

#保存したツイートのファイルを読み込み
load("tweet_xx.dat")
