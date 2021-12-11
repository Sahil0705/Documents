# 19BCE1353, Sahil Sachin Donde
# CSE3505 Foundations of Data Analytics - Project (J-Component)
# Final (Review 3)
# Faculty: - Dr. TULASI PRASAD SARIKI
# F1 Slot

# Individual Project

# Title: -Statistical Data Analysis of the Stock Price using Data Visualization

# App.R file

#install.packages("shiny")

# Load data and libraries -------------------------------------------
library("shiny")
source("ui.R")
source("server.R")

# Create shiny application ------------------------------------------
shinyApp(ui = ui, server = server)
