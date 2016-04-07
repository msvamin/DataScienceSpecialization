setwd("C:/Amin/Coursera/Capstone/")
blogs <- readLines("Coursera-Swiftkey/final/en_US/en_US.blogs.txt")
news <- readLines("Coursera-Swiftkey/final/en_US/en_US.news.txt")
twitter <- readLines("Coursera-Swiftkey/final/en_US/en_US.twitter.txt")
blogs_stats   <- stri_stats_general(blogs)
news_stats    <- stri_stats_general(news)
twitter_stats <- stri_stats_general(twitter)
blogs_words   <- stri_count_words(blogs)
news_words    <- stri_count_words(news)
twitter_words <- stri_count_words(twitter)
blogs_stats
summary( blogs_words   )
news_stats
summary( news_words    )
twitter_stats
summary( twitter_words )
blogs_sample   <- sample(blogs, 1000)
news_sample    <- sample(news, 1000)
twitter_sample <- sample(twitter, 1000)
save(blogs_sample, news_sample, twitter_sample, file= "sample_data.RData")

load("sample_data.RData")
vc_blogs <-
  blogs_sample %>%
  data.frame() %>%
  DataframeSource() %>%
  VCorpus %>%
  tm_map( stripWhitespace )
vc_news <-
  news_sample %>%
  data.frame() %>%
  DataframeSource() %>%
  VCorpus %>%
  tm_map( stripWhitespace )

vc_twitter <-
  twitter_sample %>%
  data.frame() %>%
  DataframeSource() %>%
  VCorpus %>%
  tm_map( stripWhitespace )

vc_all <- c(vc_blogs, vc_news, vc_twitter)

tdm_unigram <-
  vc_all %>%
  TermDocumentMatrix( control = list( removePunctuation = TRUE,
                                      removeNumbers = TRUE,
                                      wordLengths = c( 1, Inf) )
  )

freq_unigram <- 
  tdm_unigram %>%
  as.matrix %>%
  rowSums
