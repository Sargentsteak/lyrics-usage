library(dplyr)
library(ggplot2)
library(shiny)
library(shinydashboard)
library(dashboardthemes)
library(plotly)

artist_name <- "thebeatles"
df <- read.delim(paste0("C:\\Users\\piyus\\OneDrive\\Desktop\\Nutrient_Calculator-master\\", artist_name, "_lyrics.txt"))
# Ideally this summary would be performed outside of this app, 
# saved to file, and read into df instead of our raw data
df_sum <- df %>%
  group_by(word) %>% 
  summarise(occurrences=sum(n)) %>% 
  arrange(desc(occurrences))

ui <- dashboardPage(
  dashboardHeader(title = "Song Lyrics"),
  dashboardSidebar(  
    numericInput(inputId = "select_topn", 
                 label = "Select the number of words to display", 
                 value = 10, min = 3, max = 20, step=1)
  ),
  dashboardBody(  
    # Change theme here
    dashboardthemes::shinyDashboardThemes(
      theme = "onenote"
    ), 
    
    fluidPage(
      fluidRow(
        column(# width should be between 1 and 12
          width=6,
          box(plotly::plotlyOutput("plot1"), 
              title="Most Common Words Across Albums",
              # For column based layouts, we can set box width to NULL
              # This overrides the default value,
              width=NULL)
        ),
        column(# width should be between 1 and 12
          width=6,
          box(dataTableOutput("table1"), 
              title="Most Common Words Across Albums",
              # For column based layouts, we can set box width to NULL
              # This overrides the default value
              width=NULL)
        )
      )
    )
  )
)
