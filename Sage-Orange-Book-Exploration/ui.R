#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Orange Book Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("application_count",
                        "Minimum Number of Applications:",
                        min = 10,
                        max = 500,
                        value = 200),
            
            #Make a select box 
            selectInput("drug_type", 
                        label = h3("Prescription (RX), OTC, or Discontinued?"), 
                        choices = drug_types, 
                        selected = drug_types[1]),
            
            #Make a select box 
            selectInput("application_type", 
                        label = h3("New Drug (NDA) or Generic (ANDA)?"), 
                        choices = appl_types, 
                        selected = appl_types[1])
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
)
