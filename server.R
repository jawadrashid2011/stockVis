
# server.R

library(quantmod)
source("helper.R")

shinyServer(function(input, output) {
        
        dataInput <- reactive({
                getSymbols(input$symb, src = "yahoo", 
                           from = input$dates[1],
                           to = input$dates[2],
                           auto.assign = FALSE)
        })
        
        adjusted <- reactive({
                if(input$adjust) return(adjust(dataInput()))
                else return(dataInput())
        })
        
        output$plot <- renderPlot({    
                
                
                chartSeries(adjusted(), theme = chartTheme("white"), 
                            type = "line", log.scale = input$log, TA = NULL)
        })
})