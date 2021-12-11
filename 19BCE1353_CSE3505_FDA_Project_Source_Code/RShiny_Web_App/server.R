# 19BCE1353, Sahil Sachin Donde
# CSE3505 Foundations of Data Analytics - Project (J-Component)
# Final (Review 3)
# Faculty: - Dr. TULASI PRASAD SARIKI
# F1 Slot

# Individual Project

# Title: -Statistical Data Analysis of the Stock Price using Data Visualization

# Server.R file

library(shiny)
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

server <- function(input, output, session) {
  
  TM = read.csv('C:/Users/sahil/Documents/Sahil/VIT Chennai/3rd Year/5th Semester/Projects/CSE3505 FDA/Review 2/TM.csv', header=TRUE)
  TM <- TM[!TM$RSI=="#N/A",]
  
  strDates <- TM$Date
  TM$Date <- as.Date(strDates, "%d-%m-%Y")
  TM$D_str <- as.character(TM$Date)
  typeof(TM$D_str)
  #print(TM$Date)
  TM <- na.omit(TM) 
  dim(TM)
  #Plot
  TM$MA5 <- TTR::SMA( TM$Close, n = 5)
  
  # Calculate 10 days moving average
  TM$MA50 <- TTR::SMA( TM$Close, n = 50)
  
  
  
  #Summarize Data and then Plot
  data <- reactive({
    req(input$sel_year,input$sel_month)
    #TM_subset = subset(TM,year == input$sel_year & month == input$sel_month)
    print(input$all)
    if(input$all==TRUE)
    {
      #print(TRUE)
      #print(input$sel_year)
      #print(input$sel_month)
      TM_subset = subset(TM)
    }
    else
    {  
      #print(FALSE)
      #print(input$sel_year)
      #print(input$sel_month)
      TM_subset = subset(TM,year == input$sel_year & month == input$sel_month)
    }
    
  })
  
  #Plot 
  output$plot <- renderPlot({
    pl <- ggplot(data() , aes(x = Date))
    if(input$sel_price=='Opening Price')
      pl <- pl + geom_line(aes(y = Open, color = "Open"), group = 1,lwd=1,cex.lab=5)
    if(input$sel_price=='Maximum Price')
      pl <- pl + geom_line(aes(y = High, color = "High"), group = 1,lwd=1,cex.lab=5)
    if(input$sel_price=='Minimum Price')
      pl <- pl + geom_line(aes(y = Low, color = "Low"), group = 1,lwd=1,cex.lab=5)
    if(input$sel_price=='Closing Price')
      pl <- pl + geom_line(aes(y = Close, color = "Close"), group = 1,lwd=1,cex.lab=5)
    
    if(input$MA5==TRUE)
      pl <- pl + geom_line(aes(y = MA5, color = "MA5"),group = 1,lwd=1)
    if(input$MA50==TRUE)
      pl <- pl + geom_line(aes(y = MA50, color = "MA50"), group = 1,lwd=1)
    pl <- pl +  theme_minimal()
    
    s = paste("Line Chart for",input$sel_price)
    if(input$MA5 == TRUE)
      s = paste(s,"MA5")
    if(input$MA50 == TRUE)
      s = paste(s,"MA50")
    #pl <- pl + theme(legend.title = "Moving Ave." )
    pl <- pl + theme(legend.position = "top")
    pl <- pl + labs(title =s)
    pl <- pl + labs(color="Prices")
    pl <- pl + theme(text = element_text(size = 20))
    pl
    
  })
  
 
  
  
  #Summarize Data and then Plot
  data1 <- reactive({
    req(input$sel_year1,input$sel_month1)
    
    getSymbols("TM",src='yahoo')
    #print(TM$TM.Open)
    
    #typeof(TM)
    
    df <- data.frame(Date=index(TM),coredata(TM))
    #df$Date
    #dim(df)
    
    df$year = 1
    df$month = 1
    #df$Date
    for(i in 1:nrow(df))
    {
      df$year[i] = substr(as.character(df$Date[i]), start = 1, stop = 4)
      df$month[i] = substr(as.character(df$Date[i]), start = 6, stop = 7)
    }
    #dim(df)
    if(input$sel_month1=='Jan')
      a = '01'
    if(input$sel_month1=='Feb')
      a = '02'
    if(input$sel_month1=='Mar')
      a = '03'
    if(input$sel_month1=='Apr')
      a = '04'
    if(input$sel_month1=='May')
      a = '05'
    if(input$sel_month1=='Jun')
      a = '06'
    if(input$sel_month1=='Jul')
      a = '07'
    if(input$sel_month1=='Aug')
      a = '08'
    if(input$sel_month1=='Sep')
      a = '09'
    if(input$sel_month1=='Oct')
      a = '10'
    if(input$sel_month1=='Nov')
      a = '11'
    if(input$sel_month1=='Dec')
      a = '12'
    
    if(input$all1==FALSE)
      df <- subset(df,year == input$sel_year1 & month == a)
    else
      df<-subset(df)
    #print(df)
    
  })
  
  output$plot1 <- renderPlotly({
    
    
    
    fig <- data1() %>% plot_ly(x = ~Date, type="candlestick",
                               open = ~TM.Open, close = ~TM.Close,
                               high = ~TM.High, low = ~TM.Low) 
    fig <- fig %>% layout(title = "Candlestick Chart for Tata Motor Stock Prices")
    
    fig
    
  })
  
  
  
  #Summarize Data and then Plot
  data2 <- reactive({
    req(input$sel_year2,input$sel_month2)
    
    TM = read.csv('C:/Users/sahil/Documents/Sahil/VIT Chennai/3rd Year/5th Semester/Projects/CSE3505 FDA/Review 2/TM.csv', header=TRUE)
    TM <- TM[!TM$RSI=="#N/A",]
    strDates <- TM$Date
    TM$Date <- as.Date(strDates, "%d-%m-%Y")
    TM$D_str <- as.character(TM$Date)
    #typeof(TM$D_str)
    #print(TM$Date)
    TM <- na.omit(TM) 
    #dim(TM)
    #Plot
    TM$MA5 <- TTR::SMA( TM$Close, n = 5)
    
    # Calculate 10 days moving average
    TM$MA50 <- TTR::SMA( TM$Close, n = 50)
    
    if(input$all2==FALSE)
      TM_subset = subset(TM,year == input$sel_year2 & month == input$sel_month2)
    else
      TM_subset = subset(TM)
    
  })
  
  output$plot2 <- renderDygraph({
    
    
    TM_subset <- data2()
    
    RSI <- xts(x = TM_subset$RSI, order.by = as.POSIXct(TM_subset$Date))
    pSAR <- xts(x = TM_subset$MA50, order.by = as.POSIXct(TM_subset$Date))
    
    s = paste("Dygraph Chart for Tata Motors: -",input$sel_price2)
    if(input$RSI == TRUE)
      s = paste(s,"RSI")
    if(input$pSAR == TRUE)
      s = paste(s,"pSAR")
    
    if(input$sel_price2=="Opening Price") 
    {
      f = "Open"
      Open <- xts(x = TM_subset$Open, order.by = as.POSIXct(TM_subset$Date))
      if(input$RSI==TRUE & input$pSAR==FALSE)
      {
        st <- cbind(Open,RSI)
        # Make the chart
        p <- dygraph(st,ylab=f, 
                     main=s) %>%
          dySeries(f,label=f) %>%
          dySeries("RSI",label="RSI") %>%
          dyOptions(colors = c("green","blue","brown")) %>%
          dyRangeSelector()
        p
      }
      else if(input$RSI==TRUE & input$pSAR==TRUE)
      {
        st <- cbind(Open,RSI,pSAR)
        # Make the chart
        p <- dygraph(st,ylab=f, 
                     main=s) %>%
          dySeries(f,label=f) %>%
          dySeries("RSI",label="RSI") %>%
          dySeries("pSAR",label="pSAR") %>%
          dyOptions(colors = c("green","blue","brown")) %>%
          dyRangeSelector()
        p
      }
      else if(input$RSI==FALSE & input$pSAR==TRUE)
      { 
        st <- cbind(Open,pSAR)
        # Make the chart
        p <- dygraph(st,ylab=f, 
                     main=s) %>%
          dySeries(f,label=f) %>%
          dySeries("pSAR",label="pSAR") %>%
          dyOptions(colors = c("green","blue","brown")) %>%
          dyRangeSelector()
        p
      }
      else if(input$RSI==FALSE & input$pSAR==FALSE)
      {
        
        # Make the chart
        p <- dygraph(Open,ylab=f, 
                     main=s) %>%
          dySeries("V1",label=f) %>%
          dyOptions(colors = c("green")) %>%
          dyRangeSelector()
        p
      }
    }
    else if(input$sel_price2=="Maximum Price")
    {
      f = "High"
      High <- xts(x = TM_subset$High, order.by = as.POSIXct(TM_subset$Date))
      if(input$RSI==TRUE & input$pSAR==FALSE)
      {
        st <- cbind(High,RSI)
        # Make the chart
        p <- dygraph(st,ylab=f, 
                     main=s) %>%
          dySeries(f,label=f) %>%
          dySeries("RSI",label="RSI") %>%
          dyOptions(colors = c("green","blue","brown")) %>%
          dyRangeSelector()
        p
      }
      else if(input$RSI==TRUE & input$pSAR==TRUE)
      {
        st <- cbind(High,RSI,pSAR)
        # Make the chart
        p <- dygraph(st,ylab=f, 
                     main=s) %>%
          dySeries(f,label=f) %>%
          dySeries("RSI",label="RSI") %>%
          dySeries("pSAR",label="pSAR") %>%
          dyOptions(colors = c("green","blue","brown")) %>%
          dyRangeSelector()
        p
      }
      else if(input$RSI==FALSE & input$pSAR==TRUE)
      { 
        st <- cbind(High,pSAR)
        # Make the chart
        p <- dygraph(st,ylab=f, 
                     main=s) %>%
          dySeries(f,label=f) %>%
          dySeries("pSAR",label="pSAR") %>%
          dyOptions(colors = c("green","blue","brown")) %>%
          dyRangeSelector()
        p
      }
      else
      {
        
        # Make the chart
        p <- dygraph(High,ylab=f, 
                     main=s) %>%
          dySeries("V1",label=f) %>%
          dyOptions(colors = c("green","blue","brown")) %>%
          dyRangeSelector()
        p
      }
    }
    else if(input$sel_price2=="Minimum Price")
    {
      f = "Low"
      Low <- xts(x = TM_subset$Low, order.by = as.POSIXct(TM_subset$Date))
      if(input$RSI==TRUE & input$pSAR==FALSE)
      {
        st <- cbind(Low,RSI)
        # Make the chart
        p <- dygraph(st,ylab=f, 
                     main=s) %>%
          dySeries(f,label=f) %>%
          dySeries("RSI",label="RSI") %>%
          dyOptions(colors = c("green","blue","brown")) %>%
          dyRangeSelector()
        p
      }
      else if(input$RSI==TRUE & input$pSAR==TRUE)
      {
        st <- cbind(Low,RSI,pSAR)
        # Make the chart
        p <- dygraph(st,ylab=f, 
                     main=s) %>%
          dySeries(f,label=f) %>%
          dySeries("RSI",label="RSI") %>%
          dySeries("pSAR",label="pSAR") %>%
          dyOptions(colors = c("green","blue","brown")) %>%
          dyRangeSelector()
        p
      }
      else if(input$RSI==FALSE & input$pSAR==TRUE)
      { 
        st <- cbind(Low,pSAR)
        # Make the chart
        p <- dygraph(st,ylab=f, 
                     main=s) %>%
          dySeries(f,label=f) %>%
          dySeries("pSAR",label="pSAR") %>%
          dyOptions(colors = c("green","blue","brown")) %>%
          dyRangeSelector()
        p
      }
      else
      {
        
        # Make the chart
        p <- dygraph(Low,ylab=f, 
                     main=s) %>%
          dySeries("V1",label=f) %>%
          dyOptions(colors = c("green","blue","brown")) %>%
          dyRangeSelector()
        p
      }
    }
    else
    {
      f = "Close"
      Close <- xts(x = TM_subset$Close, order.by = as.POSIXct(TM_subset$Date))
      if(input$RSI==TRUE & input$pSAR==FALSE)
      {
        st <- cbind(Close,RSI)
        # Make the chart
        p <- dygraph(st,ylab=f, 
                     main=s) %>%
          dySeries(f,label=f) %>%
          dySeries("RSI",label="RSI") %>%
          dyOptions(colors = c("green","blue","brown")) %>%
          dyRangeSelector()
        p
      }
      else if(input$RSI==TRUE & input$pSAR==TRUE)
      {
        st <- cbind(Close,RSI,pSAR)
        # Make the chart
        p <- dygraph(st,ylab=f, 
                     main=s) %>%
          dySeries(f,label=f) %>%
          dySeries("RSI",label="RSI") %>%
          dySeries("pSAR",label="pSAR") %>%
          dyOptions(colors = c("green","blue","brown")) %>%
          dyRangeSelector()
        p
      }
      else if(input$RSI==FALSE & input$pSAR==TRUE)
      { 
        st <- cbind(Close,pSAR)
        # Make the chart
        p <- dygraph(st,ylab=f, 
                     main=s) %>%
          dySeries(f,label=f) %>%
          dySeries("pSAR",label="pSAR") %>%
          dyOptions(colors = c("green","blue","brown")) %>%
          dyRangeSelector()
        p
      }
      else
      {
        
        # Make the chart
        p <- dygraph(Close,ylab=f, 
                     main=s) %>%
          dySeries("V1",label=f) %>%
          dyOptions(colors = c("green","blue","brown")) %>%
          dyRangeSelector()
        p
      }
    }
  })
  
  
  
  
  data3 <- reactive({
    req(input$sel_year4,input$sel_month4)
    if(input$all4==TRUE)
    {
      #print(TRUE)
      #print(input$sel_year)
      #print(input$sel_month)
      TM_subset = subset(TM)
    }
    else
    {  
      #print(FALSE)
      #print(input$sel_year)
      #print(input$sel_month)
      TM_subset = subset(TM,year == input$sel_year4 & month == input$sel_month4)
    }
    
  })
  output$plot3 <- renderDygraph({
    
    ds <- data3()$Date
    
    if(input$sel_price4=="Opening Price")
      y <- data3()$Open
    else if(input$sel_price4=="Minimum Price")
      y <- data3()$Low
    else if(input$sel_price4=="Maximum Price")
      y <- data3()$High
    else if(input$sel_price4=="Closing Price")
      y <- data3()$Close
    
    df <- data.frame(ds, y)
    dim(df)
        
    # Forecasting
    m <- prophet(df)
    # Using prophet function and make future data frame, I created a data frame of the future dates where the period is 30 days i.e. 30 days after March 21 that is the whole April 21 month
    
    if(input$all4==TRUE)
      d = 210
    else
      d = 30
    # Prediction
    future <- make_future_dataframe(m, periods = d)
    forecast <- predict(m, future)
    # Then using forecast library, I have predicted the daily admitted cases in the April 2021
    
    # Plot forecast
    dyplot.prophet(m, forecast)
  })
}