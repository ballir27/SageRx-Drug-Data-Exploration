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
    
    if (input$drug_form == "All"){
      drug_form_filter <- drug_forms
    } else{
      drug_form_filter <- input$drug_form
    }
    
    if (input$application_method == "All"){
      application_method_filter <- application_methods
    } else{
      application_method_filter <- input$application_method
    }
    
    orangebook_ndc_merged |>  
      filter(type %in% drug_type_filter) |> 
      filter(appl_type %in% appl_type_filter) |> 
      filter(drug_form %in% drug_form_filter) |> 
      filter(application_method %in% application_method_filter)
  })
  
  output$companyPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    #x    <- faithful[, 2]
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    filtered() |>
      group_by(applicant) |>
      filter(n()>input$application_count) |> 
      ggplot(aes(x = applicant)) +
      geom_bar() +
      labs(title = "Number of Orange Book Entries per Company", x = "Company", y = "Number of Orange Book Entries") +
      theme(plot.title = element_text(size = 20, hjust = 0.5), axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
      geom_text(aes(label = ..count..), stat = "count", vjust = -.25,)
  })
  
  output$yearPlot <- renderPlot({
    
    filtered() |>
      count(approval_year) |> 
      ggplot(aes(x = approval_year, y = n))+
      geom_line() +
      labs(title = "Orange Book Entries by Year", x = "Year", y = "Number of Approved Drugs") +
      theme(plot.title = element_text(size = 20, hjust = 0.5), axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
  })
  
  output$table <- renderDataTable({
    #orangebook_ndc_merged |> 
    filtered() |> 
      select(ingredient, drug_form, application_method, trade_name, applicant, strength, appl_type, appl_no, approval_date, type, pharm_classes)
  })
  
}
