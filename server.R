#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

        sport<-read.csv("./data/sport.csv", sep=";")
        sport<-rename(sport, year=Jahr, age=Alter, number.of.sport.club.members=Anzahl.Vereinsmitglieder)
        sport<-mutate(sport, age=ifelse(age=="bis 6", "<=6", ifelse(age=="6 bis 14", "6-14", ifelse(age=="14 bis 18", "14-18", ifelse(age=="18 bis 26", "18-26", ifelse(age=="26 bis 40", "26-40", ifelse(age=="40 bis 60", "40-60", ">=60")))))))
        

        year_age_value<-reactive({
                subset(sport, year==input$yearInput & age==input$ageInput)[1, 3]
        })
   
        output$linePlot <- renderPlot({
                ggplot(sport, aes(year, number.of.sport.club.members))+geom_smooth(aes(group=age), size=1, col="grey")+
                        geom_point(aes(color=age), size=2)+geom_point(x=input$yearInput, y=year_age_value(), size=8, shape=18)

        })
  
        sum_of_members_by_year<-reactive({
                subset(aggregate(sport$number.of.sport.club.members, by=list(year=sport$year), FUN=sum), year==input$yearInput)[,2]
        })
        
        output$membersAge <- renderText({ year_age_value() })
        output$membersYear<-renderText({ sum_of_members_by_year() })
  
})
