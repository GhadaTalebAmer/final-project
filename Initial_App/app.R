  # Install necessary packages and download libraries 
  # as below.



library(shiny)
library(tidyverse)
library(tidytext)
library(ggplot2)
library(shinythemes)
library(leaflet)
library(RColorBrewer)
library(leaflet.extras)
library(DT)
library(scales)
library(knitr)
library(formattable)
library(janitor)
library(readr)
library(dplyr)
library(devtools)
library(dplyr)


  # Read in the .rds files from the Initial App folder in
  # the repository. 


plot <- read_rds("plot_deaths_time.rds")
regional_calculations <- read_rds("regional_calculations.rds")
africa_all_actors <- read_rds("africa_all_actors.rds")
asia_all_actors <- read_rds("asia_all_actors.rds")
europe_all_actors <- read_rds("europe_all_actors.rds")
americas_all_actors <- read_rds("americas_all_actors.rds")
mideast_all_actors <- read_rds("mideast_all_actors.rds")
full_name_both <- read_rds("full_name_both.rds")
point <- format_format(big.mark = "," , scientific = FALSE)

    
    ui <- fluidPage(theme = shinytheme("cyborg"),
                    
      
      titlePanel(h3("Global Armed Conflict Exploratory Dashboard"),
                 windowTitle = "Armed Conflict Dashboard"),
                 h4("Ghada Amer"),
      
      # Created a tabset panel to create a dashboard-like 
      # appearance for the app. It consists of two overview
      # tabs followed by a tab for each region. I chose to do 
      # provide users with outputs that showed overviews of the 
      # data and outputs that were specific to each region to 
      # provide a more in-depth understanding of the data.
      
      tabsetPanel(
  
        tabPanel(
          title = "Interactive Map",
          sidebarPanel(width = 3,
                         h5("Overview"),
                         p("The data used in this dashboard has been collected by the
                            The Uppsala Conflict Data Program (UCDP) Department of
                            Peace and Conflict Research and the International 
                            Peace Research Institute (PRIO) in Oslo."),
                        br(),
                        p("Through this project, I was interested in exploring regional and 
                          global trends in armed conflict following the Cold War era. The dataset 
                          used here contains information on 142,902 incidents of armed conflict between
                          the years 1989 and 2017. The term armed conflict refers to any act 
                          of organized violence between two actors that involved at least one 
                          fatality. Each event in the  dataset contains information on: the
                          geographic location of the conflict, the actors involved,
                          the type of violence displayed and various estimations of the number 
                          of casualties involved."),
                        br(),
                        img(src = "https://cdn.freebiesupply.com/logos/large/2x/uppsala-universitet-logo-black-and-white.png", 
                            width = "230px",
                           height = "230px")),
          
          
          # Choice of leaflet output size to make sure
          # all features that the user can toggle with are 
          # visible in the front page without having to scroll.
          
          
          mainPanel(
            h4("World Map of Armed Conflict Events from 1989 to 2017"),
            leafletOutput(outputId = "leaflet_map", width = 1010, height = 650)
                  )
                ),
            
         tabPanel(
          title = "Explore Conflict over Time",
          sidebarPanel(width = 2,
                       h5("Overview"),
                       p("Between 1989 and 2017, approximately 143,000 distinct conflict events
                          occured across the world (excluding Syria). In all these events,
                          the cumulative death toll of all fatalities was 2,022,229 with the most 
                          deaths concentrated in continental Africa. The most fatalities in all 
                          regions (excluding Africa) have been a result of state-based conflict,
                          in which the governments of at least two states are involved in organized 
                          armed violence. By considering the distribution of casualities in each 
                          region over time, key trends and changes can be seen.")),
          mainPanel(width = 10,
            plotOutput(outputId = "lineplot", width = 950, height = 600),
            hr(),
            h5("Regional Breakdown of Total Casualties and Percentage of Global Conflicts"),
            tableOutput(outputId = "table")
                    )
                ),
        
        
        # Each tab for each region contains a side bar with an overview
        # decription that gives users a quick summary of main 
        # findings. This would give users a small overview of important trends 
        # and events that may be interesting to them. Also, for 
        # such text outputs, I chose to include text 
        # directly in main panel outputs to 
        # make it easier to manipulate the content and appearance.
        
         tabPanel(
          title = "Africa",
          sidebarPanel(width = 2,
                       h5("Overview"),
                       p("The label markers of individual armed conflict events in the 
                         interactive map contain abbreviated non-state actor names. For 
                         example, CPI refers to the Communist Party of India. To get a 
                         better understanding of who was involved in the conflict,
                         use the list to search for the full name of the actor.")),
          mainPanel( 
            br(),
            plotOutput(outputId = "africa_deaths_country", width = 975),
            hr(),
            h5("Top 10 Most Active State and Non-State Actors in Africa"),
            p("In Africa, The Government of Algeria was involved in the highest number
              of armed conflicts post-Cold War"),
            tableOutput(outputId = "actor_table_africa")
                    )
                ),
          
         tabPanel(
            title = "North, Central & South America",
            sidebarPanel(width = 2,
                         h5("Overview"),
                         p("The majority of armed conflict events and subsequent deaths in this 
                           region occured in Central  and South America. Notable civil wars stand 
                           out such as that of Guatemala and El Salvador. An increase in regional gang
                           violence and armed revolutionary groups contributed to increased rates
                           of non-state violence.")), 
            mainPanel(
              br(),
              plotOutput(outputId = "americas_deaths_country", width = 800),
              hr(),
              h5("Top 10 Most Active State and Non-State Actors in the Americas"),
              p("In the Americas, the Government of Colombia was involved in the highest
                number of armed conflicts post-Cold War"),
              tableOutput(outputId = "actor_table_americas")
                    )
                ),
        tabPanel(
          title = "Asia",
          sidebarPanel(width = 2,
                       h5("Overview"),
                       p("Continental Asia has witnessed the second-highest rates of state-based 
                          conflict in the world. In comparison to other regions, the trend of
                          state-based conflict has increased in recent years. Central and South 
                          Asia in particular display the second-highest rates of organized one-sided violence.")),
          mainPanel(
            br(),
            plotOutput(outputId = "asia_deaths_country", width = 800),
            hr(),
            h5("Top 10 Most Active State and Non-State Actors in Asia"),
            p("In Asia, the Government of Afghanistan was involved in the highest
              number of armed conflicts post-Cold War"),
            tableOutput(outputId = "actor_table_asia")
                  )
                ),
        tabPanel(
          title = "Middle East",
          sidebarPanel(width = 2,
                       h5("Overview"),
                       p("In the Middle East, a sharp increase in state-based conflict in 2012
                          was met with a steady decline post-2015. As a result of civil wars in
                          Syria and Iraq, the number of regional deaths and state-based
                          violence significantly increased. However, when considered relative to 
                          the entire time period, the Middle East witnessed the third lowest
                          number of deaths and armed conflicts in comparison
                          to the rest of the world.")),
          mainPanel(
            br(),
            plotOutput(outputId = "mideast_deaths_country", width = 800),
            hr(),
            h5("Top 10 Most Active State and Non-State Actors in the Middle East"),
            p("In the Middle East, the Government of Iraq was involved in the
              highest number of armed conflicts post-Cold War"),
            tableOutput(outputId = "actor_table_mideast")
                   )
                ),
        tabPanel(
          title = "Europe",
          sidebarPanel(width = 2,
                       h5("Overview"),
                       p("The European continent has witnessed the lowest number of armed conflicts 
                          between 1989 and 2017 relative to the rest of the world. However, trends 
                          in European casualities over time appear more sudden and changing than those 
                          of other regions. Contemporary events of armed violence in Europe stand out, 
                          such as the Insurgency in the North Caucasus and the ongoing conflict between 
                          Russia and Ukraine.")),
          mainPanel(
            br(),
            plotOutput(outputId = "europe_deaths_country", width = 800),
            hr(),
            h5("Top 10 Most Active State and Non-State Actors in Europe"),
            p("In Europe, the Government of the Soviet Union was involved in 
              the highest number of armed conflicts post-Cold War"),
            tableOutput(outputId = "actor_table_europe")
          )
        )
      )
    )
    
    
    server <- function(input, output) {

      # My main outputs consist of a faceted line plot, a table,
      # a searchable data table and a leaflet map. None of these
      # outputs are reactive. I made the decision to only
      # include an interactive map that would be sufficient
      # enough for the user to toggle between. All the other
      # visualizations such as tables and graphs are not interactive
      # because I wanted the user to focus on overview trends. 
      
      output$lineplot <- renderPlot({
    
        # Created point value that removed scientific notation 
        # to improve appears of y-axis labels and for better
        # user readability. 
        
        point <- format_format(big.mark = "," , scientific = FALSE)  
        
        # I created a line plot of
        # total deaths over time faceted by region and 
        # coloured by type of violence. To do this, I 
        # grouped the data by year, type of violence and 
        # region then calculated the sums of the groups.
        # I chose to use a line plot to better display
        # trends over time. I also added stylistic features 
        # to the plot to improve its appearance and readability.
        # Choice of pastel-like colours for violence
        # groups for added contrast with the black
        # background. Also added points to the line
        # plot to improve readability and show different
        # years clearly. 
        
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
          theme(title = element_text(size = 16, face = "bold", colour = "white"),
                legend.text = element_text(size = 12, colour = "white"),
                plot.background = element_rect(fill = "black", colour = "black"),
                panel.background = element_rect(fill = "black"),
                strip.text = element_text(size = 14, face = "bold"),
                panel.grid = element_line(colour = "gray"),
                legend.key = element_rect(fill = "black"),
                legend.title = element_text(face = "bold", size = 12, colour = "white"),
                legend.background = element_rect(fill = "black"),
                legend.justification = c("right", "top"),
                legend.position = "right",
                axis.title.x = element_text(size = 15, vjust = -0.4, colour = "white"), 
                axis.title.y = element_text(size = 15, vjust = 0.4, colour = "white")) +
          scale_color_manual("Type of Violence", values = c("State-Based Conflict" = "orange", 
                                                            "Non-State Conflict" = "darkred", 
                                                            "One-Sided Violence" = "lightpink"))
      })
      
      output$leaflet_map <- renderLeaflet({
        
        # In this code chunk, I created some objects that I 
        # will need in my leaflet map. I split up my data into
        # groups of violence types that will later be integrated
        # into my map to allow the user to toggle between different
        # violence categories. I created the map directly in this file
        # instead of reading in an r object because I was having errors
        # in launching the app with a read in map. 
        
        clean_data_2 <-
          full_name_both %>% 
          unite("full_conflict_name", c("name_full_a","name_full_b"), sep = " vs. ")
        
        map_data <-
          clean_data_2 %>% 
          distinct(id, .keep_all = TRUE)
        
        one_sided_con <-
          map_data %>% 
          filter(type_of_violence == "One-Sided Violence")
        
        non_state_con <-
          map_data %>% 
          filter(type_of_violence == "Non-State Conflict")
        
        state_con <-
          map_data %>% 
          filter(type_of_violence == "State-Based Conflict")
        
        # I also created a colour palette for the type of 
        # conflict groups that will later be integrated into my map
        # to colour markers by type. I chose reds as my chosen 
        # palette to also increase contrast with black map. 
        
        violence_palette <- 
          colorFactor(palette = "Reds", 
                      levels = c("State-Based Conflict", 
                                 "Non-State Conflict",
                                 "One-Sided Violence"))
        
        # In this code chunk, I created a leaflet map. I found
        # a geo-referenced dataset that contained longitude and
        # latitude information which I could use to plot markers.
        # I added circle markers in three layers for each group.
        # I also added base map in three layers to allow the user
        # to toggle between different map types for 
        # visualization purposes. I chose a black and white map to
        # be the default map for contrast with the coloured markers.
        
        map <-
        leaflet(options = leafletOptions(minZoom = 2)) %>% 
          addProviderTiles("CartoDB.DarkMatter", 
                           group = "Black and White Political Boundaries Map") %>% 
          setMaxBounds(lng1 = 180 ,
                       lat1 = 90, 
                       lng2 = -180, 
                       lat2 = -90) %>% 
          
          # I added circle markers in layers so that the user can 
          # choose which conflict types to display. Each conflict
          # group is represented by a different shade of red.
          
          addCircleMarkers(lng = one_sided_con$longitude, 
                           lat = one_sided_con$latitude,
                           group = "One-Sided Violence",
                           color = violence_palette(one_sided_con$type_of_violence),
                           radius = 5, 
                           popup = paste0("The actors involved in the conflict are: ",
                                          one_sided_con$full_conflict_name, "."," ",
                                          "The conflict started in ", one_sided_con$year, ".", " ",
                                          "It consisted of ",  one_sided_con$type_of_violence, "."," ",
                                          "Total number of deaths: ", one_sided_con$total_deaths," ", "."),
                           label = paste0(one_sided_con$full_conflict_name, " in ", one_sided_con$location),
                           clusterOptions = markerClusterOptions(),
                           labelOptions = labelOptions(noHide = F, 
                                                       textsize = "10px", 
                                                       direction = "bottom")) %>% 
          
          # Added both labels and popups to provide more info. I chose to 
          # only display labels on hover so as to not clutter the map. I also 
          # chose to display popups on click and not automatically to make
          # the map clearer to read. I chose to cluster the markers for added
          # readibility and to show zones which zones witnessed greater conflict.
          
          addCircleMarkers(lng = non_state_con$longitude, 
                           lat = non_state_con$latitude,
                           group = "Non-State Conflict",
                           color = violence_palette(non_state_con$type_of_violence),
                           radius = 5, 
                           popup = paste0("The actors involved in the conflict are: ",
                                          non_state_con$full_conflict_name, "."," ",
                                          "The conflict started in ", non_state_con$year, ".", " ",
                                          "It consisted of ",  non_state_con$type_of_violence, "."," ",
                                          "Total number of deaths: ", non_state_con$total_deaths," ", "."),
                           popupOptions = popupOptions(direction = "auto"),
                           label = paste0(non_state_con$full_conflict_name, " in ", non_state_con$location),
                           clusterOptions = markerClusterOptions(),
                           labelOptions = labelOptions(noHide = F, 
                                                       textsize = "10px", 
                                                       direction = "auto",
                                                       opacity = 0.75,
                                                       interactive = TRUE )) %>% 
          addCircleMarkers(lng = state_con$longitude,
                           lat = state_con$latitude,
                           group = "State-Based Conflict",
                           color = violence_palette(state_con$type_of_violence),
                           radius = 5, 
                           popup = paste0("The actors involved in the conflict are: ",
                                          state_con$full_conflict_name, "."," ",
                                          "The conflict event occured in ", state_con$year, ".", " ",
                                          "It consisted of ",  state_con$type_of_violence, "."," ",
                                          "Total number of deaths: ", state_con$total_deaths," ", "."),
                           label = paste0(state_con$full_conflict_name, " in ", state_con$location),
                           clusterOptions = markerClusterOptions(),
                           labelOptions = labelOptions(noHide = F, 
                                                       textsize = "10px", 
                                                       direction = "bottom")) %>% 
          addLegend(pal = violence_palette,
                    values = c("State-Based Conflict",
                               "Non-State conflict",
                               "One-Sided Violence" ),
                    opacity = 0.7,
                    title = "Type of Violence",
                    position = "bottomright") %>% 
          addSearchFeatures(targetGroups = 
                              c('One-Sided Violence', 
                                'Non-State Conflict', 
                                'State-Based Conflict')) %>% 
          addSearchOSM() %>%  
          addResetMapButton()
        
        # Chose to also include different base maps to 
        # give the user the option to choose which type of map
        # is best for their individual purposes (e.g. political that
        # displays state boundaries vs. physical that displays
        # geographic features). 
        
       
          map %>% 
          addProviderTiles("Wikimedia", 
                           group = "Coloured Political Boundaries Map") %>% 
          addProviderTiles("Esri.WorldImagery",
                           group = "Coloured Physical Map") %>% 
          addProviderTiles("CartoDB.DarkMatter", 
                           group = "Black and White Political Boundaries Map") %>% 
          addLayersControl(baseGroups = c("Black and White Political Boundaries Map", 
                                          "Coloured Political Boundaries Map",
                                          "Coloured Physical Map"),
                           overlayGroups = 
                             c("One-Sided Violence", 
                               "Non-State Conflict", 
                               "State-Based Conflict")) 
        
      })
      
      output$table <- renderTable(
        
        # Read in calculations made in rmd file
        # into a table format instead of performing repeated
        # calculations on this file. Only added stylistic
        # table features here to improve appearance of the 
        # table output.
        
        {regional_calculations},
          striped = TRUE,
          spacing = "l",
          align = "ccc",
          digits = 4,
          position = "left",
          width = "90%",
          title = "Regional Breakdown of Total Casualties and Percentage of Global Conflicts"
      )
      
      
      output$actor_table_asia <- renderTable(
        
        # For each region, created a table of top
        # 10 actors involved in conflict. Only chose to 
        # show 10 to provide a useful overview that would 
        # be significant. Added similar table for each region
        # tab with same stylistic choices to maintain
        # consistency across all tabs. 
        
        {asia_all_actors},
          striped = TRUE,
          spacing = "l",
          align = "cc",
          position = "right",
          width = "90%"
      )
      
      output$actor_table_africa <- renderTable(
        
        {africa_all_actors},
        striped = TRUE,
        spacing = "l",
        align = "cc",
        position = "right",
        width = "90%"
      )
      
      output$actor_table_europe <- renderTable(
        
        {europe_all_actors},
        striped = TRUE,
        spacing = "l",
        align = "cc",
        position = "right",
        width = "90%"
      )

      output$actor_table_americas <- renderTable(
        
        {americas_all_actors},
        striped = TRUE,
        spacing = "l",
        align = "cc",
        position = "right",
        width = "90%"
      )
      
      output$actor_table_mideast <- renderTable(
        
        {mideast_all_actors},
        striped = TRUE,
        spacing = "l",
        align = "cc",
        position = "right",
        width = "90%"
      )
      
      output$asia_deaths_country <- renderPlot(
        
        # Created line plot of deaths by country in each 
        # region over time to show a different perspective 
        # on the data. Choice of stacked bar plot to clearly
        # show differences between countries. Repeated 
        # this for all region tabs to maintain consistency. 
        
          full_name_both %>%
          filter(region == "Asia") %>% 
          group_by(country, year) %>% 
          summarize(total_deaths = sum(total_deaths)) %>% 
          arrange(desc(year)) %>% 
          ggplot(aes(x = year, y = total_deaths, fill = country)) +
          geom_col() +
          theme_dark() +
          labs(title = "Breakdown of Annual Casualties by Country in Asia",
               subtitle = "On average, Afghanistan consistently witnessed the most casualties",
               x = "Year",
               y = "Total Casualties",
               fill = "Country") +
          scale_y_continuous(labels = point) + 
          theme(title = element_text(size = 16, face = "bold", colour = "white"),
                plot.subtitle = element_text(size = 14), 
                plot.background = element_rect(fill = "black", colour = "black"),
                legend.text = element_text(size = 12, colour = "white"),
                legend.background = element_rect(fill = "black"),
                panel.background = element_rect(fill = "black"),
                legend.key = element_rect(fill = "black"),
                legend.title = element_text(face = "bold", size = 12),
                legend.justification = c("right"),
                legend.position = "right",
                axis.title.x = element_text(size = 15, vjust = -0.4), 
                axis.title.y = element_text(size = 15, vjust = 0.4)) 
      )
      
      output$africa_deaths_country <- renderPlot(
        
        full_name_both %>%
          filter(region == "Africa") %>% 
          group_by(country, year) %>% 
          summarize(total_deaths = sum(total_deaths)) %>% 
          arrange(desc(year)) %>% 
          ggplot(aes(x = year, y = total_deaths, fill = country)) +
          geom_col() +
          theme_dark() +
          labs(title = "Breakdown of Annual Casualties by Country in Africa",
               subtitle = "With the exception of Rwanda in 1994, no African country witnesses consistently high rates of casualties",
               x = "Year",
               y = "Total Casualties",
               fill = "Country") +
          scale_y_continuous(labels = point) + 
          theme(title = element_text(size = 15, face = "bold", colour = "white"),
                plot.subtitle = element_text(size = 14),
                plot.background = element_rect(fill = "black", colour = "black"),
                legend.text = element_text(size = 12, colour = "white"),
                legend.background = element_rect(fill = "black"),
                panel.background = element_rect(fill = "black"),
                legend.key = element_rect(fill = "black"),
                legend.title = element_text(face = "bold", size = 12),
                legend.justification = c("right"),
                legend.position = "right",
                axis.title.x = element_text(size = 15, vjust = -0.4), 
                axis.title.y = element_text(size = 15, vjust = 0.4)) 
      )
      
      output$europe_deaths_country <- renderPlot(
        
        
        full_name_both %>%
          filter(region == "Europe") %>% 
          group_by(country, year) %>% 
          summarize(total_deaths = sum(total_deaths)) %>% 
          arrange(desc(year)) %>%
          ggplot(aes(x = year, y = total_deaths, fill = country)) +
          geom_col() +
          theme_dark() +
          labs(title = "Breakdown of Annual Casualties by Country in Europe ",
               subtitle = "Countries in Eastern Europe witnessed higher rates of casualties than Western Europe",
               x = "Year",
               y = "Total Casualties",
               fill = "Country") +
          scale_y_continuous(labels = point) + 
          theme(title = element_text(size = 16, face = "bold", colour = "white"),
                plot.subtitle = element_text(size = 14),
                plot.background = element_rect(fill = "black", colour = "black"),
                legend.text = element_text(size = 12, colour = "white"),
                legend.background = element_rect(fill = "black"),
                panel.background = element_rect(fill = "black"),
                legend.key = element_rect(fill = "black"),
                legend.title = element_text(face = "bold", size = 12),
                legend.justification = c("right"),
                legend.position = "right",
                axis.title.x = element_text(size = 15, vjust = -0.4), 
                axis.title.y = element_text(size = 15, vjust = 0.4)) 
      )
      
      output$americas_deaths_country <- renderPlot(
        
        
        full_name_both %>%
          filter(region == "Americas") %>% 
          group_by(country, year) %>% 
          summarize(total_deaths = sum(total_deaths)) %>% 
          arrange(desc(year)) %>%  
          ggplot(aes(x = year, y = total_deaths, fill = country)) +
          geom_col() +
          theme_dark() +
          scale_y_continuous(labels = point) + 
          labs(title = "Breakdown of Annual Casualties by Country in the Americas",
               subtitle = "Mexico and Colombia consistently witnessed the highest rates of casualties",
               x = "Year",
               y = "Total Casualties",
               fill = "Country") +
          theme(title = element_text(size = 16, face = "bold", colour = "white"),
                plot.subtitle = element_text(size = 14),
                plot.background = element_rect(fill = "black", colour = "black"),
                legend.text = element_text(size = 12, colour = "white"),
                legend.background = element_rect(fill = "black"),
                panel.background = element_rect(fill = "black"),
                legend.key = element_rect(fill = "black"),
                legend.title = element_text(face = "bold", size = 12),
                legend.justification = c("right"),
                legend.position = "right",
                axis.title.x = element_text(size = 15, vjust = -0.4), 
                axis.title.y = element_text(size = 15, vjust = 0.4)) 
      )
      
      output$mideast_deaths_country <- renderPlot(
        
        
        full_name_both %>%
          filter(region == "Middle East") %>% 
          group_by(country, year) %>% 
          summarize(total_deaths = sum(total_deaths)) %>% 
          arrange(desc(year)) %>%  
          ggplot(aes(x = year, y = total_deaths, fill = country)) +
          geom_col() +
          scale_y_continuous(labels = point) + 
          theme_dark() +
          labs(title = "Breakdown of Annual Casualties by Country in the Middle East ",
               subtitle = "Egypt and Iraq consistently witnessed the highest rates of casualties over time",
               x = "Year",
               y = "Total Casualties",
               fill = "Country") +
          theme(title = element_text(size = 16, face = "bold", colour = "white"),
                plot.subtitle = element_text(size = 14),
                plot.background = element_rect(fill = "black", colour = "black"),
                legend.text = element_text(size = 12, colour = "white"),
                legend.background = element_rect(fill = "black"),
                panel.background = element_rect(fill = "black"),
                legend.key = element_rect(fill = "black"),
                legend.title = element_text(face = "bold", size = 12),
                legend.justification = c("right"),
                legend.position = "right",
                axis.title.x = element_text(size = 15, vjust = -0.4), 
                axis.title.y = element_text(size = 15, vjust = 0.4)) 
      )
    }
    
    
    # Run the application 
    shinyApp(ui = ui, server = server) 
    
    
  
    