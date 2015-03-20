# load the stingi library for text manipulation
library(stringi)

# inspect the data
list.files("final")
list.files("final/en_US")

# import the blogs and twitter datasets in text mode
blogs <- readLines("final/en_US/en_US.blogs.txt", encoding="UTF-8")
twitter <- readLines("final/en_US/en_US.twitter.txt", encoding="UTF-8")

# import the news dataset in binary mode
con <- file("final/en_US/en_US.news.txt", open="rb")
news <- readLines(con, encoding="UTF-8")
close(con)
rm(con)

# sample data (20% of each)
blog_number<-ceiling(0.2*length(blogs))
news_number<-ceiling(0.2*length(news))
twitter_number<-ceiling(0.2*length(twitter))
sample_blogs   <- sample(blogs,blog_number)
sample_news    <- sample(news, news_number)
sample_twitter <- sample(twitter, twitter_number)


# clean non UTF-8 characters and other useless words.
clean<-function(t){
  t <- iconv(t, from = "latin1", to = "UTF-8", sub="")
  t <- stri_replace_all_regex(t, "\u2019|`","'")
  t <- stri_replace_all_regex(t, "\u201c|\u201d|u201f|``",'"')
  t <- gsub("\\.\\.\\.", " <ellipse> ", t) 
  t <- gsub("\\.", " <period>", t)
  t <- gsub("\\?", " <question>", t)
  t <- gsub("\\!", " <exclamation>", t)
  t <- sub("^", "<start> ", t) #Distribution of first word differs from . 
  t <- gsub(" teh ", " the ", t) #fix common spelling errors
  t <- gsub(" siad ", " said ", t) #fix common spelling errors
  t <- gsub("fuck ", "", t) #Profanity filter
  t <- gsub("boobs ", "", t)   
}
clean(sample_twitter)
clean(sample_blogs)
clean(sample_news)

# save samples
save(sample_blogs, sample_news, sample_twitter, file= "sample_data.RData")