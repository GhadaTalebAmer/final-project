#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(tidytext)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Global Armed Conflict Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
     data <- read_csv("ged181.csv")
    
      data %>%
       ggplot(aes(x = year, fill = region)) + geom_bar() + 
       xlab("Year") +
       ylab("Number of Conflicts") +
       theme(legend.position = "bottom", plot.title = element_text(size=15, face = "bold")) + 
       ggtitle("Increase in the number of armed conflicts globally since 1946")
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

