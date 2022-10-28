#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(readr)
library(ggplot2)
ops_data <- as.matrix(read_csv("ops_data.csv", 
                               col_types = cols(...1 = col_skip())))

ops_data <- ops_data[1:600,]

Demand <- ops_data[,2:10]
Pressure <- ops_data[,68:78]
Flow <- ops_data[,34:44]



library(reshape2)


date <- seq(from = as.POSIXct("2012/07/09 00:00: 00"), length.out = nrow(Demand),
            by = '30 mins')
demand_time$date  <- date
lon_demand <- reshape2::melt(demand_time, id.var = "date")



# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- as.numeric(ops_data[, 2])
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Weekly Water Demand (in cfm)',
             main = 'Peak/Off water demand Distribution')

    })
    
    
      datasetInput <- reactive({
        switch(input$dataset,
               "Demand" = Demand,
               "pressure" = Pressure,
               "Flow" = Flow)
      })
      
      output$ops_dara <- renderTable({
        ops_data
      })
      
      
      output$caption <- renderText({
        input$caption
      })
      
      
      output$summary <- renderPrint({
        dataset <- datasetInput()
        summary(dataset)
      })
      
      output$view <- renderTable({
        head(datasetInput(), n = input$obs)
      })
      
      
      output$plot1 <- renderPlot({
        plot(demand_time$date, demand_time$Pressure_Node_2, type = "b", pch = 19)
      })
      
      output$info <- renderText({
        xy_str <- function(e) {
          if(is.null(e)) return("NULL\n")
          paste0("x=", round(e$x, 1), " y=", round(e$y, 1), "\n")
        }
        xy_range_str <- function(e) {
          if(is.null(e)) return("NULL\n")
          paste0("xmin=", round(e$xmin, 1), " xmax=", round(e$xmax, 1), 
                 " ymin=", round(e$ymin, 1), " ymax=", round(e$ymax, 1))
        }
        
        paste0(
          "click: ", xy_str(input$plot_click),
          "dblclick: ", xy_str(input$plot_dblclick),
          "hover: ", xy_str(input$plot_hover),
          "brush: ", xy_range_str(input$plot_brush)
        )
      })
      
    }

)


