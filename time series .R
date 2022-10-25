library(readr)
library(magrittr)
library(plotly)

ops_data <- read_csv("~/Projects/Water_Leak_detection-/ops_data.csv", 
                     col_types = cols(...1 = col_skip()))
d_nodes <- ops_data[,1:32]
d_nodes$time <- seq(from = as.POSIXct("2012/01/01 00:00:00"), length.out = nrow(d_nodes), by = '30 mins')

#######################time series#########################################################
fig <- plot_ly(x = as.Date(d_nodes$time), y = d_nodes$Demand_Node_4, type = 'scatter', mode = 'lines',width = 400, height = 400
               , name = 'Demand Node 4')%>% 
  layout(title = 'Water Demand',
         plot_bgcolor='#e5ecf6',  
         xaxis = list(  
           title = 'AAPL_x',
           zerolinecolor = '#ffff',  
           zerolinewidth = 2,  
           gridcolor = 'ffff'),  
         yaxis = list(  
           title = 'AAPL_y',
           zerolinecolor = '#ffff',  
           zerolinewidth = 2,  
           gridcolor = 'ffff'),
         showlegend = TRUE, width = 1100)
fig
