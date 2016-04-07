library(shiny)
library(datasets)
data(mtcars)

finalCars <- function(x,y) {
  row.names(subset(mtcars, mtcars$cyl == x & mtcars$hp >= y[1] & mtcars$hp <= y[2]))
}

shinyServer(function(input, output) {
  
  output$inputValue1 <- renderPrint({input$x})
  output$inputValue2 <- renderPrint({input$y})
  output$plot <- renderPlot({plot(mtcars$hp)})
  output$prediction <- renderPrint({
    ifelse(length(as.list(finalCars(input$x,input$y)))==0,
           "There is no car with these criteria, please change the filters and try again",
           list(finalCars(input$x,input$y)))
  })
}
)

