#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {
  
  filtered <- reactive({
    if (input$drug_type == "All"){
      drug_type_filter <- drug_types
    } else{
      drug_type_filter <- input$drug_type
    }
    
    if (input$application_type == "Both"){
      appl_type_filter <- appl_types
    } else{
      appl_type_filter <- input$application_type
    }
    
    orange_book_raw |>  
      filter(type %in% drug_type_filter) |> 
      filter(appl_type %in% appl_type_filter)
  })
  
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    #x    <- faithful[, 2]
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    filtered() |>
      group_by(applicant) |>
      filter(n()>input$application_count) |> 
      ggplot(aes(x = applicant)) +
      geom_bar() +
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
    
  })
  
}
