# 19BCE1353, Sahil Sachin Donde
# CSE3505 Foundations of Data Analytics - Project (J-Component)
# Final (Review 3)
# Faculty: - Dr. TULASI PRASAD SARIKI
# F1 Slot

# Individual Project

# Title: -Statistical Data Analysis of the Stock Price using Data Visualization

# UI.R file

library(dplyr)
library(ggplot2)
library(dygraphs)
library(xts)
require(quantmod)
library(plotly)
library(dplyr)
library(prophet)
library(lubridate)
library(ggplot2)

# User Interface -----------------------------------------------------
intro_panel <- tabPanel(
  "R Shiny: - Interactive Dygraphs and Candle Stick Charts",
  hr(),
  h3("Line Chart: -"),br(),
  div(style="display:inline-block",selectInput(inputId = "sel_year",
                                               label = "Choose Year",
                                               list("2008","2007","2009","2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021"))),
  div(style="display:inline-block",selectInput(inputId = "sel_month",
                                               label = "Choose Month",
                                               list("Jan","Feb","Mar","Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))),br(),
  div(style="display:inline-block",checkboxInput('all', 'Ignore the above selected Year/Month and plot all prices from start to end', value = FALSE)),
  div(style="display:inline-block",selectInput(inputId = "sel_price",
                                               label = "Choose Price",
                                               list("Opening Price","Minimum Price","Maximum Price","Closing Price"))),br(),
  div(style="display:inline-block",checkboxInput('MA5', 'MA5', value = TRUE)),
  div(style="display:inline-block",checkboxInput('MA50', 'MA50', value = TRUE)),
  br(),plotOutput("plot"),
  #textOutput("selected_var"),
  #textOutput("checkbox"),
  br(),
  hr(),
  br(),
  
  h3("Candle Stick Chart: -"),br(),
  div(style="display:inline-block",selectInput(inputId = "sel_year1",
                                               label = "Choose Year",
                                               list("2008","2007","2009","2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021"))),
  div(style="display:inline-block",selectInput(inputId = "sel_month1",
                                               label = "Choose Month",
                                               list("Jan","Feb","Mar","Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))),br(),
  div(style="display:inline-block",checkboxInput('all1', 'Ignore the above selected Year/Month and plot all prices from start to end', value = FALSE)),
  br(),plotlyOutput("plot1"),
  #textOutput("selected_var1"),br(),
  hr(),
  br(),
  
  h3("Insteractive DyGraphs: -"),br(),
  div(style="display:inline-block",selectInput(inputId = "sel_year2",
                                               label = "Choose Year",
                                               list("2008","2007","2009","2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021"))),
  div(style="display:inline-block",selectInput(inputId = "sel_month2",
                                               label = "Choose Month",
                                               list("Jan","Feb","Mar","Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))),br(),
  div(style="display:inline-block",checkboxInput('all2', 'Ignore the above selected Year/Month and plot all prices from start to end', value = FALSE)),
  div(style="display:inline-block",selectInput(inputId = "sel_price2",
                                               label = "Choose Price",
                                               list("Opening Price","Minimum Price","Maximum Price","Closing Price"))),br(),
  div(style="display:inline-block",checkboxInput('RSI', 'RSI', value = TRUE)),
  div(style="display:inline-block",checkboxInput('pSAR', 'pSAR', value = FALSE)),
  br(),dygraphOutput("plot2"),br(),hr(),br()
  #textOutput("selected_var2"),br(),br()
)

prediction <- tabPanel(
 "RShiny - Prediction for Stock Prices",br(),
    h3("Prohpet Model for Predicting Stock Prices for Tata Motors"),br(),
 div(style="display:inline-block",selectInput(inputId = "sel_year4",
                                              label = "Choose Year",
                                              list("2008","2007","2009","2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021"))),
 div(style="display:inline-block",selectInput(inputId = "sel_month4",
                                              label = "Choose Month",
                                              list("Jan","Feb","Mar","Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))),br(),
 div(style="display:inline-block",checkboxInput('all4', 'Ignore the above selected Year/Month and plot all prices from start to end', value = TRUE)),
 div(style="display:inline-block",selectInput(inputId = "sel_price4",
                                              label = "Choose Price",
                                              list("Opening Price","Minimum Price","Maximum Price","Closing Price"))),
 dygraphOutput("plot3"),
 br(),br()
   
)

ui <- navbarPage(
  "Tata Motors - Stock Price Analysis based on Parameters",
  intro_panel,
  prediction
)