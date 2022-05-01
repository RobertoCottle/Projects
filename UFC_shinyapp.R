library(shiny)
library(tidyverse)
library(scales)
library(plotly)
library(rvest)
library(dplyr)
library(plyr)
library(data.table)
library(stringr)
library(gdata)
library(shinythemes)
library(bslib)
library(DT)
library(showtext) 
library(ggridges)

setwd("C:/Users/rober/OneDrive/Documents/Spring 2022 UTSA/R/UFC")

load("clean_data.RData")

Metrics <- c("Knock-Downs","Significant Strikes Landed","Significant Strikes Attempted",
             "Significant Strikes Accuracy","Take-Downs Landed",
             "Take-Downs Attempted","Take-Down Accuracy",
             "Submissions Attempted","Head Strikes Landed","Head Strikes Attempted","Head Strike Accuracy",
             "Body Strikes Landed","Body Strikes Attempted",
             "Body Strike Accuracy","Leg Strikes Landed","Leg Strikes Attempted",
             "Leg Strike Accuracy","Distance Strikes Landed","Distance Strikes Attempted",
             "Distance Strike Accuracy","Clinch Strikes Landed",
             "Clinch Strikes Attempted","Clinch Strike Accuracy")

my_theme <- bs_theme(bootswatch = "slate",
                     base_font = font_google("Rubik"))

ui <- tagList(
        navbarPage(theme = my_theme,
                   "UFC", 
                   tabPanel("Men's Weight Classes", 
                    sidebarLayout(
                  # Inputs: Select variables to plot ------------------------------
                        sidebarPanel(titlePanel("Metrics are averages of all fights within a specified year"),
                              hr(),
                          # Choose weight class (fight_type) 
                               selectInput(inputId = "wt.class1", 
                                           label = "Weight Class: Fight Type",
                                           choices = list("Flyweight Bout","Bantamweight Bout","Featherweight Bout","Lightweight Bout",
                                                          "Welterweight Bout","Middleweight Bout","Light Heavyweight Bout","Heavyweight Bout",
                                                          "Catch Weight Bout","Open Weight Bout"), 
                                           selected = "Middleweight Bout"),
                               
                               
                               # Choosing which Metric to plot
                               selectInput(inputId = "select1", label = "Fight Metric", 
                                           choices = Metrics, selected = Metrics[2]),
                               
                               
                               # Determine range of years
                               sliderInput(inputId = "years1", 
                                           label = "Year Range:", 
                                           min = 1994, max = 2021, 
                                           value = c(1994,2021), sep = ""),
                               
                               hr(), #Horizontal Line for visual separation
                               
                                      ),
                  
                  # Output: Show scatterplot --------------------------------------
                  mainPanel(
                    headerPanel("UFC Fight Statistic Trends"),
                    plotlyOutput(outputId = "scatterplot_1")
                  )
                 )
              ),
              tabPanel("Men's Title Bouts", 
                       sidebarLayout(
                         # Inputs: Select variables to plot ------------------------------
                         sidebarPanel(titlePanel("Metrics are averages of all fights within a specified year"),
                                      hr(),
                                      # Choose weight class (fight_type) 
                                      selectInput(inputId = "wt.class2", 
                                                  label = "Weight Class: Fight Type",
                                                  choices = list("UFC Flyweight Title Bout","UFC Bantamweight Title Bout","UFC Featherweight Title Bout",
                                                                 "UFC Lightweight Title Bout", "UFC Welterweight Title Bout","UFC Middleweight Title Bout", 
                                                                 "UFC Light Heavyweight Title Bout","UFC Heavyweight Title Bout"), 
                                                  selected = "UFC Heavyweight Title Bout"),
                                      
                                      
                                      # Choosing which Metric to plot
                                      selectInput(inputId = "select2", label = "Fight Metric", 
                                                  choices = Metrics, selected = Metrics[2]),
                                      
                                      
                                      # Determine range of years
                                      sliderInput(inputId = "years2", 
                                                  label = "Year Range:", 
                                                  min = 1994, max = 2021, 
                                                  value = c(1994,2021), sep = ""),
                                      
                                      hr(), #Horizontal Line for visual separation
                                      
                         ),
                         
                         # Output: Show scatterplot --------------------------------------
                         mainPanel(
                           headerPanel("UFC Fight Statistic Trends"),
                           plotlyOutput(outputId = "scatterplot_2")
                         )
                       )
              ),
              tabPanel("Women's Weight Classes", 
                       sidebarLayout(
                         # Inputs: Select variables to plot ------------------------------
                         sidebarPanel(titlePanel("Metrics are averages of all fights within a specified year"),
                                      hr(),
                                      # Choose weight class (fight_type) 
                                      selectInput(inputId = "wt.class3", 
                                                  label = "Weight Class: Fight Type",
                                                  choices = list("Women's Bantamweight Bout","Women's Featherweight Bout","Women's Flyweight Bout","Women's Strawweight Bout"), 
                                                  selected = "Women's Bantamweight Bout"),
                                      
                                      
                                      # Choosing which Metric to plot
                                      selectInput(inputId = "select3", label = "Fight Metric", 
                                                  choices = Metrics, selected = Metrics[2]),
                                      
                                      
                                      # Determine range of years
                                      sliderInput(inputId = "years3", 
                                                  label = "Year Range:", 
                                                  min = 1994, max = 2021, 
                                                  value = c(1994,2021), sep = ""),
                                      
                                      hr(), #Horizontal Line for visual separation
                                      
                         ),
                         
                         # Output: Show scatterplot --------------------------------------
                         mainPanel(
                           headerPanel("UFC Fight Statistic Trends"),
                           plotlyOutput(outputId = "scatterplot_3")
                         )
                       )
              ),
              tabPanel("Women's Title Bouts", 
                       sidebarLayout(
                         # Inputs: Select variables to plot ------------------------------
                         sidebarPanel(titlePanel("Metrics are averages of all fights within a specified year"),
                                      hr(),
                                      # Choose weight class (fight_type) 
                                      selectInput(inputId = "wt.class4", 
                                                  label = "Weight Class: Fight Type",
                                                  choices = list("UFC Women's Bantamweight Title Bout","UFC Women's Featherweight Title Bout",
                                                                 "UFC Women's Flyweight Title Bout","UFC Women's Strawweight Title Bout"), 
                                                  selected = "UFC Women's Bantamweight Title Bout"),
                                      
                                      
                                      # Choosing which Metric to plot
                                      selectInput(inputId = "select4", label = "Fight Metric", 
                                                  choices = Metrics, selected = Metrics[2]),
                                      
                                      
                                      # Determine range of years
                                      sliderInput(inputId = "years4", 
                                                  label = "Year Range:", 
                                                  min = 1994, max = 2021, 
                                                  value = c(1994,2021), sep = ""),
                                      
                                      hr(), #Horizontal Line for visual separation
                                      
                         ),
                         
                         # Output: Show scatterplot --------------------------------------
                         mainPanel(
                           headerPanel("UFC Fight Statistic Trends"),
                           plotlyOutput(outputId = "scatterplot_4")
                         )
                       )
              ),
              tabPanel("Data",  DT::dataTableOutput(outputId="datasheet"))
)
)


server <- function(input, output, session){
  
  dat1 <- reactive({
    ds1 <- clean_data[clean_data$Fight_type %in% input$wt.class1, ]
    return(ds1)
  })
  
  observeEvent(input$wt.class1, {
    updateSliderInput(session, "years1", label = "Year Range:", 
                      value = c(min(dat1()$years),max(dat1()$years))
    )
  })
  
  dat2 <- reactive({
    d2a <- dat1()[dat1()$Metrics %in% input$select1, ]
    return(d2a)
  })
  
  output$scatterplot_1 <- renderPlotly({
    ggplot(data = dat2(), aes_string(x = dat2()$years, y = dat2()$Average)) +
      geom_point(colour="Black") +
      theme_ridges() + scale_x_continuous(limits = input$years) +
      xlab("Years") + geom_line() + ylab(input$select1) + geom_line(colour="Red")
  }) 
  
  dat3 <- reactive({
    ds3 <- clean_data[clean_data$Fight_type %in% input$wt.class2, ]
    return(ds3)
  })
  
  observeEvent(input$wt.class2, {
    updateSliderInput(session, "years2", label = "Year Range:", 
                      value = c(min(dat3()$years),max(dat3()$years))
    )
  })
  
  dat4 <- reactive({
    d4a <- dat3()[dat3()$Metrics %in% input$select2, ]
    return(d4a)
  })
  
  output$scatterplot_2 <- renderPlotly({
    ggplot(data = dat4(), aes_string(x = dat4()$years, y = dat4()$Average)) +
      geom_point(colour="Black") +
      theme_ridges() + scale_x_continuous(limits = input$years) +
      xlab("Years") + geom_line() + ylab(input$select2) + geom_line(colour="Red")
  }) 
  
  dat5 <- reactive({
    ds5 <- clean_data[clean_data$Fight_type %in% input$wt.class3, ]
    return(ds5)
  })
  
  observeEvent(input$wt.class3, {
    updateSliderInput(session, "years3", label = "Year Range:", 
                      value = c(min(dat5()$years),max(dat5()$years))
    )
  })
  
  dat6 <- reactive({
    d6a <- dat5()[dat5()$Metrics %in% input$select3, ]
    return(d6a)
  })
  
  output$scatterplot_3 <- renderPlotly({
    ggplot(data = dat6(), aes_string(x = dat6()$years, y = dat6()$Average)) +
      geom_point(colour="Black") +
      theme_ridges() + scale_x_continuous(limits = input$years) +
      xlab("Years") + geom_line() + ylab(input$select3) + geom_line(colour="Red")
  }) 
  
  dat7 <- reactive({
    ds7 <- clean_data[clean_data$Fight_type %in% input$wt.class4, ]
    return(ds7)
  })
  
  observeEvent(input$wt.class4, {
    updateSliderInput(session, "years4", label = "Year Range:", 
                      value = c(min(dat7()$years),max(dat7()$years))
    )
  })
  
  dat8 <- reactive({
    d8a <- dat7()[dat7()$Metrics %in% input$select4, ]
    return(d8a)
  })
  
  output$scatterplot_4 <- renderPlotly({
    ggplot(data = dat8(), aes_string(x = dat8()$years, y = dat8()$Average)) +
      geom_point(colour="Black") +
      theme_ridges() + scale_x_continuous(limits = input$years) +
      xlab("Years") + geom_line() + ylab(input$select4) + geom_line(colour="Red")
  }) 
  
  
  output$datasheet<-DT::renderDataTable({
    DT::datatable(data=clean_data,
                  options=list(pageLength= 20),
                  rownames=FALSE)
  })
  
}
shinyApp(ui = ui, server = server)


###################################################################################

