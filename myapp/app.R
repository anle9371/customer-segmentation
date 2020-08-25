library(shinydashboard)
library(shiny)

options(browser="C:/Program Files (x86)/Mozilla Firefox/firefox.exe")

ui <- dashboardPage(
  skin = "yellow",
  dashboardHeader(title = "Population Modeling"),
  dashboardSidebar(
      sliderInput("slider", "Number of observations:", 1, 100, 50)
  ),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(plotOutput("plot1", height = 250)),
      box(
        title = "Controls"
      )
    ),
    fluidRow(
        box(
            title = "Controls"
        )
    )
  )
)

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)

  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)
