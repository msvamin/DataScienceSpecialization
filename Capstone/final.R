# Setting path
setwd("C:/Amin/Coursera/Capstone/")

# Loading data
blogs <- readLines("./final/en_US/en_US.blogs.txt", encoding = "UTF-8", skipNul=TRUE)
news <- readLines("./final/en_US/en_US.news.txt", encoding = "UTF-8", skipNul=TRUE)
twitter <- readLines("./final/en_US/en_US.twitter.txt", encoding = "UTF-8", skipNul=TRUE)

# Cleaning the data
library(tm)
cleanSample <- tm_map(blogs, content_transformer(function(x) iconv(x, to="UTF-8", sub="byte")), 
                      mc.cores=2)

