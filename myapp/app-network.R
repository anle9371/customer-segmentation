library(visNetwork)
library(shiny)

options(browser="C:/Program Files (x86)/Mozilla Firefox/firefox.exe")

server <- function(input, output) {
    output$network <- renderVisNetwork({
        stg <- c("New", "1-Time Purch", "Reg Custmrs", "Subscr Upgrd", "1st Time Rcmdrs", "Reg Rcmdrs", "Mature")
        myg <- c(rep("NR",4),rep("R",3))
        myc <- c(rep("#005EB8",4),rep("#EAAA00",3))

        ## from node
        fp <- 2:7
        fg <- 1:6

        ## to node
        tp <- 2:7
        tg <- 2:7

        ## edge labels
        fl <- rep("R",6)
        gl <- rep("G",6)
        pl <- rep("C",6)

        ## edge colors
        ec <- c(rep('#DE8626',6),rep('#00A3A1',6),rep('#6D2077',6))

        nodes <- data.frame(id = 1:7, label = stg, group = myg, color = myc)
        edges <- data.frame(from = c(fp,fg), to = c(tp,tg))

        visNetwork(nodes, edges, height = "700px", width = "100%") %>%
            visOptions(highlightNearest = TRUE) %>%
            visPhysics(stabilization = FALSE) %>%
            visEdges(arrows = "to") %>%
            visHierarchicalLayout(direction = "LR")
    })

    output$shiny_return <- renderPrint({
        input$current_node_id
    })
}

ui <- fluidPage(
    visNetworkOutput("network"),
    verbatimTextOutput("shiny_return")
)

shinyApp(ui = ui, server = server)
