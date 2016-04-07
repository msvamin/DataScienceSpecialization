# Data Science Capstone Project
# Amin Mousavi 1/19/2016                                                                           ##            

library(tm)
library(RWeka)
library(googleVis)
library(wordcloud)
#library(RWekajars)
#library(qdapDictionaries)
#library(qdapRegex)
#library(qdapTools)
#library(RColorBrewer)
#library(qdap)
#library(NLP)
#library(SnowballC)
#library(slam)
#library(rJava)

#library(stringr)
#library(DT)
#library(stringi)

# Setting path
setwd("C:/Amin/Coursera/CapstoneCoursera/")

# Loading the data 
blogs <- readLines("./final/en_US/en_US.blogs.txt", encoding = "UTF-8", skipNul=TRUE)
news <- readLines("./final/en_US/en_US.news.txt", encoding = "UTF-8", skipNul=TRUE)
twitter <- readLines("./final/en_US/en_US.twitter.txt", encoding = "UTF-8", skipNul=TRUE)

## Generating a random sapmle of all sources
sampleTwitter <- twitter[sample(1:length(twitter),10000)]
sampleNews <- news[sample(1:length(news),10000)]
sampleBlogs <- blogs[sample(1:length(blogs),10000)]
textSample <- c(sampleTwitter,sampleNews,sampleBlogs)

## Save sample
writeLines(textSample, "textSample.txt")

## Checking the size and length of the files and calculate the word count
blogsFile <- file.info("./final/en_US/en_US.blogs.txt")$size / 1024.0 / 1024.0
newsFile <- file.info("./final/en_US/en_US.news.txt")$size / 1024.0 / 1024.0
twitterFile <- file.info("./final/en_US/en_US.twitter.txt")$size / 1024.0 / 1024.0
sampleFile <- file.info("./MilestoneReport/textSample.txt")$size / 1024.0 / 1024.0

blogsLength <- length(blogs)
newsLength <- length(news)
twitterLength <- length(twitter)
sampleLength <- length(textSample)

blogsWords <- sum(sapply(gregexpr("\\S+", blogs), length))
newsWords <- sum(sapply(gregexpr("\\S+", news), length))
twitterWords <- sum(sapply(gregexpr("\\S+", twitter), length))
sampleWords <- sum(sapply(gregexpr("\\S+", textSample), length))


## Building a clean corpus
#profanityWords <- read.table("profanityfilter.txt", header = FALSE)
conprofane <- file("./profanityfilter.txt", "r")
profanity_vector <- VectorSource(readLines(conprofane))

corpus <- VCorpus(VectorSource(textSample)) # main corpus with all sample files
corpus <- tm_map(corpus, removeNumbers) 
corpus <- tm_map(corpus, stripWhitespace) 
corpus <- tm_map(corpus, tolower) 
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, removeWords, profanity_vector) 
corpus <- tm_map(corpus, stemDocument)
corpus <- tm_map(corpus, stripWhitespace)

## Saving the final corpus
saveRDS(corpus, file = "finalCorpus.RDS")



## Exploratory analysis 

## Budilding the n-grams

finalCorpus <- readRDS("finalCorpus.RDS")
finalCorpusDF <-data.frame(text=unlist(sapply(finalCorpus,`[`, "content")), 
                           stringsAsFactors = FALSE)

## Building the tokenization function for the n-grams
ngramTokenizer <- function(theCorpus, ngramCount) {
        ngramFunction <- NGramTokenizer(theCorpus, 
                                Weka_control(min = ngramCount, max = ngramCount, 
                                delimiters = " \\r\\n\\t.,;:\"()?!"))
        ngramFunction <- data.frame(table(ngramFunction))
        ngramFunction <- ngramFunction[order(ngramFunction$Freq, 
                                             decreasing = TRUE),][1:10,]
        colnames(ngramFunction) <- c("String","Count")
        ngramFunction
}

onegram <- ngramTokenizer(finalCorpusDF, 1)
saveRDS(onegram, file = "onegram.RDS")
bigram <- ngramTokenizer(finalCorpusDF, 2)
saveRDS(bigram, file = "bigram.RDS")
trigram <- ngramTokenizer(finalCorpusDF, 3)
saveRDS(trigram, file = "trigram.RDS")

## trigram plot
onegram <- readRDS("onegram.RDS")
onegramPlot <- gvisColumnChart(trigram, "String", "Count",                  
                            options=list(legend="none"))

## bigram plot
bigram <- readRDS("bigram.RDS")
bigramPlot <- gvisColumnChart(bigram, "String", "Count",                  
                               options=list(legend="none"))


## trigram plot
trigram <- readRDS("trigram.RDS")
trigramPlot <- gvisColumnChart(trigram, "String", "Count",                  
                               options=list(legend="none"))


## Creating a wordcloud

trigramTDM <- TermDocumentMatrix(finalCorpus)
wcloud <- as.matrix(trigramTDM)
v <- sort(rowSums(wcloud),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
wordcloud(d$word,d$freq,
          c(5,.3),50,
          random.order=FALSE,
          colors=brewer.pal(8, "Dark2"))

