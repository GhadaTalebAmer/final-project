  ## Install necessary packages and download libraries 
  ## as below.

library(shiny)
library(tidyverse)
library(tidytext)
library(ggplot2)
library(shinythemes)
library(shinydashboard)
library(DT)

  ## Read in the .rds files from the Initial App folder in
  ## the repository. Read in additional csv file of a list of 
  ## actors to include in the report.

map <- read_rds("map_variable.rds")
plot <- read_rds("plot_deaths_time.rds")
regional_calculations <- read_rds("regional_calculations.rds")
actors_list <- read_csv("actorlist.csv") %>% 
select("Abbreviated Name of Actor" = "Name", "Full Name of Actor" = "NameFull")

    
    ui <- fluidPage(theme = shinytheme("cyborg"),
                    
      
      titlePanel(h1("Global Armed Conflict Exploratory Dashboard"),
                 windowTitle = "Armed Conflict Dashboard"),
                 h4("Ghada Amer"),
      
      ## Created a tabset panel to create a dashboard-like 
      ## appearance for the app. It consists of four 
      ## tabs. Each tab contains a side bar
      ## with descriptions/instructions and a main panel
      ## of relevant outputs. For text outputs, I chose to
      ## include text directly in main panel outputs to 
      ## make it easier to manipulate the appearance.
      
      tabsetPanel(
  
        tabPanel(
          title = "Interactive Map",
          sidebarPanel(width = 2,
                         h5("Instructions"),
                         p("Poke around this interactive map to explore different armed 
                          conflict events between 1989 and 2017 around the world. Hover
                          over markers to view information related to each event, such 
                          as the number of casualties or the names of actors involved.
                          You can also toggle between different map types and filter
                          conflicts depending on the type of violence that occured.")),
          mainPanel(
            h4("World Map of Armed Conflict Events (1989 - 2017)"),
            leafletOutput(outputId = "leaflet_map", width = 950, height = 600)
                  )
                ),
            
         tabPanel(
          title = "Charts",
          sidebarPanel(width = 2,
                       h5("Description"),
                       p("The charts displayed show the annual total of casualties 
                         in each region over time. Each line represents conflicts with
                         different types of violence. The summary table below displays
                         the percentage of total global armed conflicts that occured 
                         in the specified region between 1989 and 2017. The table also
                         displays the cumulative number of regional casualties (including
                         civilians) on all sides within that time period.")),
          mainPanel(width = 10,
            plotOutput(outputId = "lineplot", width = 950, height = 600),
            hr(),
            h5("View Regional Breakdown of Total Casualties and Percentage of Global Conflicts"),
            tableOutput(outputId = "table")
                    )
                ),
        
         tabPanel(
          title = "List of Actors",
          sidebarPanel(width = 3,
                       h5("Description"),
                       p("The label markers of individual armed conflict events in the 
                         interactive map contain abbreviated non-state actor names. For 
                         example, CPI refers to the Communist Party of India. To get a 
                         better understanding of who was involved in the conflict,
                         use the list to search for the full name of the actor.")),
          mainPanel(
            h5("Actors List"),
            dataTableOutput("actors_list")
                    )
                ),
          
         tabPanel(
            title = "Report",
            sidebarPanel(width = 3),
            mainPanel(
              h5(tags$em("Understanding the Findings of the Armed Conflict Exploratory Dashboard")),
              br(),
              h5("Overview of the Data"),
              br(),
              p("The data used in this dashboard has been collected by the",
                tags$b("Uppsala Conflict Data Program (UCDP)"), "of the", 
                tags$b(" Department of Peace and Conflict Research and the International 
                     Peace Research Institute (PRIO)"), "in Oslo."),
              p("The dataset contains information on 142,902 incidents of armed conflict between
                the years 1989 and 2017. The term armed conflict refers to any act of organized  
                violence between two actors that involved at least one fatality. Each event in the
                dataset contains information on: the geographic location of the conflict, the actors involved,
                the type of violence displayed and various estimations of the number of casualties involved."),
              br(),
              h5("Significance and Purpose of the Project"),
              br(),
              p("The rationale for the project created here is an academic exploration of armed conflicts
                 around the world. By taking a historical perspective on conflict, those interested in the topic
                 can understand global trends in violence and how these trends play out regionally. With a 
                 contemporary increase in non-state actors such as militias and armed resistance groups, it is
                 important to study the emergence of such groups and map their activities globally. By breaking down
                 the visualizations of the data into categories of violence, one can also get a better understanding 
                 of aggressor states that are involved in one-sided violence against their people."),
              br(),
              h5("Summary of Main Findings"),
              br(),
              p("The basic unit of analysis here is an armed conflict event. Between 1989 and 2017, approximately
                143,000 distinct events occured across the world (excluding Syria). In all these events,
                the cumulative death toll of all fatalities was", tags$b("2,022,229"), "with the most 
                deaths concentrated in continental Africa. Continental Asia recorded the second highest
                death toll with approximately 444,333 casualties within the specified time period. Continental
                Asia also saw the highest number of armed conflict events in proportion to other regions while 
                Europe saw the lowest number of armed conflicts globally. North and South America 
                saw the lowest death toll relative to other regions and the second lowest percentage of armed 
                conflicts relative to the rest of the world."),
              br(),
              h5("Key Trends in Armed Conflict and Important Events"),
              br(),
              p("The most fatalities in all regions (excluding Africa) have been a result of state-based conflict,
                in which the governments of at least two states are involved in organized armed violence. By considering
                the distribution of casualities in each region over time, key trends and changes can be seen. These
                trends will be analyzed by region."), 
              br(),
              h6("The Middle East"),
              br(),
              p("In the Middle East, a sharp increase in state-based conflict in 2012 was met with a steady decline 
                 post-2015. As a result of civil wars in Syria and Iraq, the number of regional deaths and state-based
                 violence significantly increased. However, when considered relative to the entire time period,
                 the Middle East witnessed the third lowest number of deaths and armed conflicts in comparison
                 to the rest of the world."),
              br(),
              h6("Africa"),
              br(),
              p("Continental Africa witnessed the highest number of deaths between 1989 and 2017. The majority of deaths
                 have been a result of one-sided violence. A key peak in one-sided violence occured in 1994 as a result
                 of the Rwandan Genocide. The best estimate of deaths in the Rwandan Genocide is approximately 500,000. 
                 Post-2000, continental Africa has witnessed low rates of state-based conflict, non-state conflict and
                 one-sided violence. "),
              br(),
              h6("Asia"),
              br(),
              p("Continental Asia has witnessed the second-highest rates of state-based conflict in the world. In 
                  comparison to other regions, the trend of state-based conflict has increased in recent years. 
                  Central and South Asia in particular display the second-highest rates of organized one-sided violence."),
              br(),
              h6("Europe"),
              br(),
              p("The European continent has witnessed the lowest number of armed conflicts between 1989 and 2017 relative
                  to the rest of the world. However, trends in European casualities over time appear more sudden and changing
                  than those of other regions. Contemporary events of armed violence in Europe stand out, such as
                  the Insurgency in the North Caucasus and the ongoing conflict between Russia and Ukraine."),
              br(),
              h6("North and South America"),
              br(),
              p("The majority of armed conflict events and subsequent deaths in this region occured in Central 
                 and South America. Notable civil wars stand out such as that of Guatemala and El Salvador. An
                 increase in regional gang violence and armed revolutionary groups contributed to increased rates
                 of non-state violence.")
              )
            )
          )
        )

    
    
    server <- function(input, output) {

      ## My main outputs consist of a faceted line plot, a table,
      ## a searchable data table and a leaflet map. None of these
      ## outputs are reactive. I made the decision to only
      ## include an interactive map that would be sufficient
      ## enough for the user to toggle between. 
      
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
          theme(title = element_text(size = 20, face = "bold", colour = "white"),
                legend.text = element_text(size = 12, colour = "white"),
                panel.background = element_rect(fill = "black"),
                strip.text = element_text(size = 14),
                panel.grid = element_line(colour = "gray"),
                plot.background = element_rect(fill = "black"),
                legend.key = element_rect(fill = "black"),
                legend.title = element_text(face = "bold", size = 12, colour = "white"),
                legend.background = element_rect(fill = "black"),
                legend.justification = c("right", "top"),
                legend.position = "right",
                axis.title.x = element_text(size = 14, vjust = -0.4, colour = "white"), 
                axis.title.y = element_text(size = 14, vjust = 0.4, colour = "white")) +
          scale_color_manual("Type of Violence", values = c("State-Based Conflict" = "orange", 
                                                            "Non-State Conflict" = "darkred", 
                                                            "One-Sided Violence" = "lightpink"))
      })
      
      output$leaflet_map <- renderLeaflet({
        
        map
        
      })
      
      output$table <- renderTable(
        
        {regional_calculations},
        striped = TRUE,
        spacing = "l",
        align = "ccc",
        digits = 4,
        position = "left",
        width = "90%",
        title = "Regional Breakdown of Total Casualties and Percentage of Global Conflicts"
      ) 
      
      
      output$actors_list <- renderDataTable({
        
        datatable(actors_list, 
                  caption = "Search for Full Names of State and Non-State Actors 
                            in Interactive Map Descriptions", selection = "none")  %>%  
          formatStyle(c('Abbreviated Name of Actor','Full Name of Actor'),
                      backgroundColor = 'black')
        
        
      })
    }
    
    
    # Run the application 
    shinyApp(ui = ui, server = server) 
    
    
  
    