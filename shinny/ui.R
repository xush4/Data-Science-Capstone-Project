library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Next Word Text Prediction"),
  
  sidebarPanel(
    p('The purpose of this app is to predict the next word after a given amount of text.  
      A predicted word will be provided after typing along with other possible words and their
      respective probabilities')
  ),
  mainPanel(
    h3('Begin Typing in the Box Below. If you do not input any words, your first word will be considered as I'),
    textInput("userText", "",""),
    textOutput("firstWord"),
    textOutput("secondWord"),
    textOutput("thirdWord"),
    textOutput("otherWords"),
    textOutput("moreotherWords"),
    plotOutput("picture")
  )
))