library(shiny)
library(wordcloud)
source("Predict.R")

shinyServer(
  function(input,output){
    
    predictedWords <- reactive({predictThis(input$userText)})
    output$firstWord <- renderText({
      predictedWords()[1]
    })
    output$secondWord <- renderText({
      predictedWords()[2]
    })
    output$thirdWord <- renderText({
      predictedWords()[3]
    })
    output$otherWords <- renderText({
      predictedWords()[4:10]
    })    
    output$picture<-renderPlot({
      wordcloud(predictedWords()[1:20], c(20,15,12,10,8,6,4,3,3,3,3,3,3,3,3,3,3,3,3,3) ,random.order=T, max.words=200, colors=brewer.pal(8, "Dark2"))
    })
    }
)
