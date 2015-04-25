library(data.table)
library(stringi)
load("ProbabilityTable.rds")
load("uniqueWords.RData")
load("profanity.rds")

parseString <- function(thePhrase){
  SD1 <- tolower(thePhrase)
  #remove profanity
  SD1 <- gsub(paste(profanity, collapse='|'), " ", SD1)
  #collapse all ' to join words
  if (SD1==""){
    SD1="i"
  }
  SD1split <- strsplit(SD1, " ")
  SD1splitlength <- length(SD1split[[1]])
  if(SD1splitlength > 2){
    return(SD1split[[1]][(SD1splitlength-2):SD1splitlength])
  }
  else{
    
    return(SD1split[[1]][1:SD1splitlength])
  }
}

filterUnknownWords <- function(wordArray){
  for(i in 1:length(wordArray)){
    if(!(wordArray[i] %in% uniqueWords)){
      wordArray[i] <- "<unk>"
    }
  }
  
  return(wordArray)
}

createNGrams <- function(wordArray){
  ngramsToFind <- c()
  wordArrayLength <- length(wordArray)
  for(i in 1:wordArrayLength){
    ngramsToFind <- c(ngramsToFind, paste(wordArray[i:wordArrayLength], collapse=" "))
  }
  return(ngramsToFind)
  
}

findTopWords <- function(ngramArray, probTable, n){
  selectedWords <- probTable[probTable$firstWord %in% ngramArray,]
  if(!(length(selectedWords) > 0)){
    selectedWords <- predictThis("<unk> <unk> <unk>")
  }
  
  
  aggWords <- aggregate(V1 ~ lastWord, data=selectedWords, sum)
  aggWords <- aggWords[with(aggWords, order(-V1)),]
  
  return(head(aggWords, n))
  
}

predictThis <- function(phrase){
  if(nchar(phrase) > 0){
    pred <- parseString(phrase)
    pred <- filterUnknownWords(pred)
    pred <- createNGrams(pred)
    pred <- findTopWords(pred, ProbabilityTable, 20)
    
    return(pred$lastWord)
  }
  else{
    pred <- "i"
    pred <- filterUnknownWords(pred)
    pred <- createNGrams(pred)
    pred <- findTopWords(pred, ProbabilityTable, 20)
    
    return(pred$lastWord)
  }
}