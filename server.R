library(dplyr)
library(ggplot2)
library(shiny)
library(shinydashboard)
library(dashboardthemes)
library(plotly)


server <- function(input, output) { 
  # Create our validation function
  v <- reactive({
    validate(
      need(input$select_topn >= 2 & input$select_topn <= 50, "Please select a number between 3 and 50")
    )
  })
  
  df_filtered <- reactive({
    df_sum %>%
      top_n(input$select_topn)
  }) 
  
  output$plot1 <- plotly::renderPlotly({
   
    plotly::ggplotly( 
      df_filtered() %>% 
        ggplot(aes(x=word, 
                   y=occurrences)) +
        geom_col() +
        ylab("count") +
        coord_flip() +
        theme_minimal() +
        scale_fill_gradient(high = "#f6a97a", low="#ca3c97") +
        ggtitle(paste("Top", input$select_topn, "frequently used words")) + 
        geom_blank()
    )
  })
  
  output$table1 <- renderDataTable({
   
    df_filtered()
  })
}

shinyApp(ui, server)
