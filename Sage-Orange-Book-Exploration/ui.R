#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application
fluidPage(

    # Application title
    titlePanel("Orange Book Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("application_count",
                        "Minimum Number of Applications:",
                        min = 0,
                        max = 500,
                        value = 300),
            
            #Make a select box 
            selectInput("drug_type", 
                        label = h3("Prescription (RX), OTC, or Discontinued?"), 
                        choices = drug_types, 
                        selected = drug_types[1]),
            
            #Make a select box 
            selectInput("application_type", 
                        label = h3("New Drug (NDA) or Generic (ANDA)?"), 
                        choices = appl_types, 
                         selected = appl_types[1]),
            
            # #Make a select box 
            selectInput("drug_form",
                        label = h3("What form does the drug come in?"),
                        choices = drug_forms,
                        selected = drug_forms[1]),

            # #Make a select box 
            selectInput("application_method",
                        label = h3("How is the drug applied?"),
                        choices = application_methods,
                        selected = application_methods[1])
        ),

        # Show a plot of the generated distribution
        mainPanel(
            fluidRow(plotOutput("companyPlot")),
            fluidRow(column(width = 12, style = 'padding:20px;'), plotOutput("yearPlot")),
            fluidRow(column(width = 12, style = 'padding:50px;'), dataTableOutput("table"))
        )
    )
)
