library(shiny)
library(tidyverse)
library(tidytext)
library(ggplot2)
library(shinythemes)
library(shinydashboard)

map <- read_rds("map_variable.rds")
plot <- read_rds("plot_deaths_time.rds")

total_percentages <-
  clean_data %>% 
  mutate(total_conflicts = n_distinct(id)) %>% 
  group_by(region, total_conflicts) %>% 
  count() %>% 
  mutate(percentage_conflicts = n/total_conflicts*100) %>% 
  ungroup() %>% 
  select(region, percentage_conflicts)

total_percentages_2 <-
  clean_data %>%
  group_by(region) %>% 
  summarize(death_per_region = sum(total_deaths))

joined_data <- 
  inner_join(total_percentages, total_percentages_2, by = "region") 


    # Define UI for application 
    ui <- fluidPage(theme = shinytheme("cyborg"),
                    
      # Application title
      titlePanel(title = "Global Armed Conflict Exploratory Dashboard",
                 windowTitle = "Armed Conflict Dashboard"),
                  
      tabsetPanel(
        tabPanel(
          title = "About",
          mainPanel(
            h4(tags$em("Welcome to the Armed Conflict Exploratory Dashboard produced using Shiny by R-Studio.")),
            p("The data used in this dashboard has been collected by the",
              tags$b("Uppsala Conflict Data Program (UCDP)"), "of the", 
              tags$b(" Department of Peace and Conflict Research and the International 
                     Peace Research Institute (PRIO)"), "in Oslo."), 
            img(src = "https://en.wikipedia.org/wiki/Uppsala_University#/media/File:Uppsala_University_seal.svg", 
                width = "10px", height = "30px"))),
        tabPanel(
          title = "Interactive Map",
          sidebarPanel(width = 2,
                       p("Poke around this interactive map to explore different armed 
                         conflict events between 1989 and 2017 around the world.
                        Hover over markers to view information related to each event, such 
                        as the number of casualties or the names of actors involved.
                        You can also toggle between different map types and filter
                         conflicts depending on the type of violence that occured.")),
          mainPanel(
            h4("World Map of Armed Conflict Events (1989 - 2017)"),
            leafletOutput(outputId = "leaflet_map", width = 950, height = 600)
           )),
        tabPanel(
          title = "Charts",
          sidebarPanel(width = 2),
          mainPanel(width = 10,
            plotOutput(outputId = "lineplot", width = 950, height = 600),
            hr(),
            helpText(""),
            paste0("-"),
            tableOutput(outputId = "table")),
        tabPanel(
          title = "Codebook",
          sidebarPanel(width = 3),
          mainPanel())
)
    )
    )  

    
    # Define server logic required to draw a histogram
    server <- function(input, output) {

      output$lineplot <- renderPlot({
    
     
        plot %>% 
        ggplot(aes(x = year, y = total_deaths, colour = type_of_violence)) +
          geom_line()  +
          geom_point(alpha = 0.8, size = 2) + 
          scale_y_continuous(labels = point) + 
          facet_wrap(~region, scales = "free", shrink = TRUE, nrow = 3) +
          theme_dark() + 
          labs(title = "Number of Casualties Over Time per Region (1989-2017)",
               subtitle = "by Type of Violence",
               x = "Year",
               y = "Number of Casualties",
               color = "Type of Violence") + 
          theme(title = element_text(size = 17, face = "bold", colour = "white"),
                legend.text = element_text(size = 12, colour = "white"),
                panel.background = element_rect(fill = "black"),
                plot.background = element_rect(fill = "black"),
                legend.key = element_rect(fill = "black"),
                legend.title = element_text(face = "bold", size = 12, colour = "white"),
                legend.background = element_rect(fill = "black"),
                legend.justification = c("right", "top"),
                legend.position = "right",
                axis.title.x = element_text(size = 14, vjust = -0.4, colour = "white"), 
                axis.title.y = element_text(size = 14, vjust = 0.4, colour = "white")) +
          scale_color_manual("Type of Violence", values = c("state-based conflict" = "orange", 
                                                            "non-state conflict" = "darkred", 
                                                            "one-sided violence" = "lightpink"))
      })
      
      output$leaflet_map <- renderLeaflet({
        
        map
        
      })
      
      output$table <- renderTable(
        
        {joined_data},
        striped = TRUE,
        spacing = "l",
        align = "ccc",
        digits = 4,
        position = "left",
        width = "90%",
        caption = "-."
      ) 
      
      output$text <- renderText({
        
        h5(textOutput("Hello"))
        
        
      })
    }
    
  
  
    
    # Run the application 
    shinyApp(ui = ui, server = server) 
    
    
  
    