setwd("H:\\open course\\introduction to Rprogramming Hopkins\\10-Capstone Proram (Final Project)\\Capstone")
destination_file <- "Coursera-SwiftKey.zip"
if (!file.exists("Coursera-SwiftKey.zip")){
  setInternet2(use = TRUE)
  destination_file <- "Coursera-SwiftKey.zip"
  source_file <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
  
  # execute the download
  download.file(source_file, destination_file)
  
  # extract the files from the zip file
  unzip(destination_file)
}