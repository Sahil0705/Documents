# 19BCE1353, Sahil Sachin Donde
# CSE3505 Foundations of Data Analytics - Project (J-Component)
# Final (Review 3)
# Faculty: - Dr. TULASI PRASAD SARIKI
# F1 Slot

# Individual Project

# Title: -Statistical Data Analysis of the Stock Price using Data Visualization

#start

# Time Series Plotting
library(ggplot2)
library(xts)
library(dygraphs)

require("quantmod")

stock_list <- c("TM")

start_date <- Sys.Date()-5397
end_date <- Sys.Date()
start_date
master_df <- NULL
for (idx in seq(length(stock_list))){
  stock_index = stock_list[idx]
  getSymbols(stock_index, verbose = TRUE, src = "yahoo", 
             from=start_date,to=end_date)
  temp_df = as.data.frame(get(stock_index))
  temp_df$Date = row.names(temp_df)
  temp_df$Index = stock_index
  row.names(temp_df) = NULL
  colnames(temp_df) = c("Open", "High", "Low", "Close", 
                        "Volume", "Adjusted", "Date", "Index")
  temp_df = temp_df[c("Date", "Index", "Open", "High", 
                      "Low", "Close", "Volume", "Adjusted")]
  master_df = rbind(master_df, temp_df)
}
dim(master_df)
head(master_df,20)
summary(master_df)

boxplot(master_df$Close,main="Box plot for detecting outliers in Closing Price",xlab="Closing Price",border="brown",
        col="gold", horizontal=TRUE)
boxplot(master_df$High,main="Box plot for detecting outliers in Highest Price",xlab="Highest Price",border="purple",
        col="pink", horizontal=TRUE)
boxplot(master_df$Low,main="Box plot for detecting outliers in Lowest Price",xlab="Lowest Price",border="black",
        col="orange", horizontal=TRUE)
boxplot(master_df$Open,main="Box plot for detecting outliers in Opening Price",xlab="Opening Price",border="brown",
        col="cyan", horizontal=TRUE)

Close_xts <- xts(x = master_df$Close, order.by = as.POSIXct(master_df$Date))

# Make the chart
p <- dygraph(Close_xts,ylab="Close", 
             main="Tata Motors Closing Stock Prices") %>%
  dySeries("V1",label="Closing Price") %>%
  dyOptions(colors = c("blue")) %>%
  dyRangeSelector()
p


getSymbols("TM",src='yahoo')
#print(TM$TM.Open)
df <- data.frame(Date=index(TM),coredata(TM))
df <- tail(df,30)
library(plotly)
fig <- df %>% plot_ly(x = ~Date, type="candlestick",
                      open = ~TM.Open, close = ~TM.Close,
                      high = ~TM.High, low = ~TM.Low) 
fig <- fig %>% layout(title = "Basic Candlestick Chart")

fig

#end

# start


TM = read.csv('C:/Users/sahil/Documents/Sahil/VIT Chennai/3rd Year/5th Semester/Projects/CSE3505 FDA/Review 2/TM.csv', header=TRUE)
dim(TM)
TM <- TM[!TM$RSI=="#N/A",]

print(master_df$Date[1])
strDates <- TM$Date
#print(TM$Date)
typeof(strDates)
TM$Date <- as.Date(strDates, "%d-%m-%Y")
#print(TM$Date)
TM <- na.omit(TM) 
dim(TM)

Close <- xts(x = TM$Close, order.by = as.POSIXct(TM$Date))
RSI <- xts(x = TM$RSI, order.by = as.POSIXct(TM$Date))
Vol <- xts(x = TM$Volume/100000, order.by = as.POSIXct(TM$Date))

st <- cbind(Close,RSI,Vol)

# Make the chart
p <- dygraph(st,ylab="Close", 
             main="Tata Motors Closing Stock Prices") %>%
  dySeries("Close",label="Close") %>%
  dySeries("RSI",label="RSI") %>%
  dySeries("Vol",label="Vol") %>%
  dyOptions(colors = c("green","blue","brown")) %>%
  dyRangeSelector()
p

# Calculate 5 day moving average
TM$MA5 <- TTR::SMA( TM$Close, n = 5)

# Calculate 10 days moving average
TM$MA50 <- TTR::SMA( TM$Close, n = 50)

head(TM,20)

# Now we plot the values in ggplot
pl <- ggplot(TM , aes(x = Date))
pl <- pl + geom_line(aes(y = Close, color = "Close"), group = 1)
pl <- pl + geom_line(aes(y = MA5, color = "MA5"),group = 1)
pl <- pl + geom_line(aes(y = MA50, color = "MA10"), group = 1)
pl <- pl +  theme_minimal()
#pl <- pl + theme(legend.title = "Moving Ave." )
pl <- pl + theme(legend.position = "top")
pl <- pl + labs(title ="Moving averages")
pl <- pl + labs(color="Prices")
pl

Close <- xts(x = TM$Close, order.by = as.POSIXct(TM$Date))
MA5 <- xts(x = TM$MA5, order.by = as.POSIXct(TM$Date))
MA50 <- xts(x = TM$MA50, order.by = as.POSIXct(TM$Date))

st <- cbind(Close,MA5,MA50)

# Make the chart
p <- dygraph(st,ylab="Close", 
             main="Tata Motors Closing Stock Prices") %>%
  dySeries("Close",label="Close") %>%
  dySeries("MA5",label="MA5") %>%
  dySeries("MA50",label="MA50") %>%
  dyOptions(colors = c("green","blue","brown")) %>%
  dyRangeSelector()
p
#end

# Review - 2 end

# Review -3 Start

Close <- xts(x = TM$Close, order.by = as.POSIXct(TM$Date))
RSI <- xts(x = TM$RSI, order.by = as.POSIXct(TM$Date))
pSAR <- xts(x = TM$MA50, order.by = as.POSIXct(TM$Date))

st <- cbind(Close,RSI,pSAR)

# Make the chart
p <- dygraph(st,ylab="Close", 
             main="Tata Motors Closing Stock Prices") %>%
  dySeries("Close",label="Close") %>%
  dySeries("RSI",label="RSI") %>%
  dySeries("pSAR",label="pSAR") %>%
  dyOptions(colors = c("green","blue","brown")) %>%
  dyRangeSelector()
p

TM$pSAR = TM$MA50

library(dplyr)
library(prophet)
library(lubridate)
library(ggplot2)

qplot(Sr, Close, data = TM)

ds <- TM$Date
y <- TM$Close
df <- data.frame(ds, y)

# Forecasting
m <- prophet(df)

# Prediction
future <- make_future_dataframe(m, periods = 210)
forecast <- predict(m, future)

# Plot forecast
plot(m, forecast)

dyplot.prophet(m, forecast)
# Then using plot function I plotted the graph using dyplot, it is an interactive graph which can help you to see more minute details

prophet_plot_components(m, forecast)

# Model performance
pred <- forecast$yhat[1:210]
pred
length(pred)
actual <- m$history$y[1:210]
length(actual)
actual
plot(actual, pred)
# Then I checked the model performance by plotting a graph between actual and predicted values
# From the graph we can see that the actual and the predicted values are much more closer to each other so we can say our model is accurate

diff <- abs(actual-pred)
correct = 0
for(i in diff)
{
  if(i<4.5)
  {
    correct = correct + 1
  }
}
correct/length(diff)*100

# Project - End
