#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("sport club members in Leipzig per year"),
  
  sidebarLayout(
         
    sidebarPanel(
            
        helpText("This small application tries to visualize the number of persons who are members in a sport club in the german city Leipzig. Please select the year and age of interest. Then the number of members is shown on the right hand side."),
        numericInput("yearInput",label="select a year: ", value=2008),
        selectInput("ageInput", label="select an age range: ", choices=list("<=6"="<=6", 
                                                            "6-14"="6-14",
                                                            "14-18"="14-18",
                                                            "18-26"="18-26",
                                                            "26-40"="26-40",
                                                            "40-60"="40-60",
                                                            ">=60"=">=60"))
        
    ),
    
    mainPanel(
        h4("sport club members for selected year and age: "),
        verbatimTextOutput("membersAge"),
        h4("sport club members for selected year: "),
        verbatimTextOutput("membersYear"),
        
        plotOutput("linePlot")
        
    )
  )
))
