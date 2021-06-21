library(twitteR)
library(wordcloud)
library(tm)
library(xlsx)
library(stringr)
library(plyr)

consumer_key = "m2BwVwnoJV99e1KwemZZLOqGk"
consumer_secret = "eBluHf419cPTCD3WxgTd6YnuVFCOL80DB2Hb5J5brLRsPuwomd"
access_token = "69820722-g3nAAdyhgnQEPu8Vipq1jWY7dmVD50L4wITNK52G9"
access_secret ="eK0dPekfF1GHSoLOWJ6PyCsGyUfZs9gcnDU13xsMYPA6E"
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
some_tweets2 = searchTwitter('covid+haji', n = 12000, lang = "en",retryOnRateLimit = 10e3)

searchTwitter("covid+haji", n=500, lang="id")

tweets = searchTwitter("covid+haji", n=500, lang="id")

# convert tweets ke data frame
tweets_df = twListToDF(tweets)

# extract text content di tweet pertama
tweets[[1]]$getText()

# extract user name di tweet pertama
tweets[[1]]$getScreenName()

# extract tweet Id di tweet pertama
tweets[[1]]$getId()

# extract tanggal dan waktu posting di tweet pertama
tweets[[1]]$getCreated()

# untuk mengetahui di tweet menggunakan perangkat apa
tweets[[1]]$getStatusSource()

# extract text content di semua tweet
sapply(tweets, function(x) x$getText())

# extract  user name di semua tweet
sapply(tweets, function(x) x$getScreenName())

# extract Id number di semua tweet
sapply(tweets, function(x) x$getId())

# extract tanggal dan waktu posting di semua tweet
sapply(tweets, function(x) x$getCreated())

# untuk mengetahui di tweet menggunakan perangkat apa
sapply(tweets, function(x) x$getStatusSource())

# Extract the text from the tweets in a vector
tweets_text = sapply(tweets, function(x) x$getText())

#Buat Korpus
tweets_corpus= Corpus(VectorSource(tweets_text))

#Buat document term matriks untuk menerapkan beberapa perubahan dengan stopwords
tdm = TermDocumentMatrix(tweets_corpus, control = list(removePunctuation = TRUE, stopwords = TRUE, removeNumbers = TRUE, tolower = TRUE))

# definisi tdm sebagai matriks
m = as.matrix(tdm)

# Frekuensi kemunculan kata
word_freqs = sort(rowSums(m), decreasing=TRUE) 

# Membuat data frame dengan kata-kata dan frekuensinya
dm = data.frame(word=names(word_freqs), freq=word_freqs)

# plot wordcloud
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))

# simpan image ke format png

png("hjcovidCloud.png", width=12, height=8, units="in", res=300)
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))
dev.off()