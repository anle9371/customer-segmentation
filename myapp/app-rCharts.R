library(shiny)
require(rCharts)

options(browser="C:/Program Files (x86)/Mozilla Firefox/firefox.exe")

ui <- fluidPage(
    pageWithSidebar(
        titlePanel("rCharts: Interactive Charts from R using polychart.js"),

        sidebarPanel(
            selectInput(inputId = "x",
                        label = "Choose X",
                        choices = c('SepalLength', 'SepalWidth', 'PetalLength', 'PetalWidth'),
                        selected = "SepalLength"),
            selectInput(inputId = "y",
                        label = "Choose Y",
                        choices = c('SepalLength', 'SepalWidth', 'PetalLength', 'PetalWidth'),
                        selected = "SepalWidth")
        ),
        mainPanel(
            showOutput("myChart", "morris")
        )
    ))

server <- function(input, output){
    output$myChart <- renderChart({
        data(economics, package = 'ggplot2')
        econ <- transform(economics, date = as.character(date))
        print(head(econ))
        m1 <- mPlot(x = 'date', y = c('psavert', 'uempmed'), type = 'Line',
                    data = econ)
        m1$set(pointSize = 0, lineWidth = 1)
        m1$addParams(dom = 'myChart')
##        names(iris) = gsub("\\.", "", names(iris))
##        p1 <- rPlot(input$x, input$y, data = iris, color = "Species",
##                    facet = "Species", type = 'point'
##        p1$addParams(dom = 'myChart')
        return(m1)
    })
}

shinyApp(ui=ui, server=server)
