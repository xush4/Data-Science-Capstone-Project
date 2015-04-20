Quiz 1
============ 
  Question 1
------------
  setwd("H:\\open course\\introduction to Rprogramming Hopkins\\10-Capstone Proram (Final Project)\\Capstone")
  file.info("data\\en_US/en_US.blogs.txt")$size / 1024^2
# find the Size of data

Question 2
------------
  # import the blogs and twitter datasets in text mode
  blogs <- readLines("final/en_US/en_US.blogs.txt", encoding="UTF-8")
twitter <- readLines("final/en_US/en_US.twitter.txt", encoding="UTF-8")

# import the news dataset in binary mode
con <- file("final/en_US/en_US.news.txt", open="rb")
news <- readLines(con, encoding="UTF-8")
close(con)
rm(con)
length(twitter)
# find the Length of data

Question 3
------------
countblogs=na.omit(nchar(as.character(blogs), allowNA=TRUE))
countnews=na.omit(nchar(as.character(news), allowNA=TRUE))
counttwitter=na.omit(nchar(as.character(twitter), allowNA=TRUE))
# 计算所有blogs/news/twitter中各段落字符数，允许NA值出现（以免程序出错），然后去除所有NA值
longblogs=max(countblogs)
longnews=max(countnews)
longtwitter=max(counttwitter)
max(longblogs,longnews,longtwitter)

Question 4
------------
  love_count <- sum(grepl("love", twitter))
hate_count <- sum(grepl("hate", twitter))
love_count / hate_count
# 抓取关键文字
Question 5
------------
biostats <- grep("biostats", twitter)
twitter[biostats]

Question 6
------------
sum(grepl("A computer once beat me at chess, but it was no match for me at kickboxing", twitter))