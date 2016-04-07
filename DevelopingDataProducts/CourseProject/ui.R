library(shiny)

shinyUI(
  pageWithSidebar(
    headerPanel("Browse the mtcars dataset"),
    sidebarPanel(
      h3("Filter"),
      p("Use the following keys to filter the car models."),
      selectInput('x', 'Select the number of cylinders', c(4,6,8),selected="Cylinders"),
      sliderInput('y', 'Select the horsepower of the engine', min = 50, 
                  max = 270, value=c(50,270), step=1),
      h4("Click the submit key to see  the result"),
      submitButton('Submit')
    ),
    mainPanel(
      h4('You selected a model with the following number of cylinders'),
      verbatimTextOutput('inputValue1'),
      h4('and the horsepower in the following interval (hps):'),
      verbatimTextOutput('inputValue2'),
      h4('The list of the models is:'),
      verbatimTextOutput('prediction'),
      h4('The output plot is:'),
      plotOutput('plot')
      
    )
  )
)