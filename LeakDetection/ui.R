library(shiny)
library(ggplot2)

ui <- fluidPage(
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "bins",
                  label = "30 minutes Int:",
                  min = 1,
                  max = 50,
                  value = 30),
      textInput(inputId = "caption",
                label = "Description:",
                value = "Data Historian"),
      selectInput(inputId = "dataset",
                  label = "Choose a Node Type:",
                  choices = c("Demand", "Pressure", "Flow")),
      numericInput(inputId = "obs",
                   label = "Number of observations to view:",
                   value = 10)
      
    ),
    
    
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tab",
                  tabPanel("Water Demand",plotOutput("distPlot")),
                  tabPanel("Pressures",plotOutput("")),
                  tabPanel("Analytics",plotOutput("")),
                  tabPanel("Time Series",plotOutput("plot1",
                                               click = "plot_click",
                                               dblclick = "plot_dblclick",
                                               hover = "plot_hover",
                                               brush = "plot_brush"
                  ),verbatimTextOutput("info")),
                  tabPanel("Historian",verbatimTextOutput("summary")
                           ,h3(textOutput("caption", container = span)),
                           tableOutput("view"))
      )
    )
    
  )
  
)









