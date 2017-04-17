library("tseries")
library(portes)
library(lawstat) # levene.test needs this
library(forecast)
library(vars)
library(knitr)

# Read training data
train <- read.csv("train.csv", header = T)
Bankrupcy <- ts(train$Bankruptcy_Rate, start = c(1987, 1), frequency = 12)
Unemployment_Rate <- ts(train$Unemployment_Rate, start = c(1987, 1), frequency = 12)
Population <- ts(train$Population, start = c(1987, 1), frequency = 12)
House_Price_Index <- ts(train$House_Price_Index, start = c(1987, 1), frequency = 12)

# Correlation Analysis
t <- seq(1987, 2011, length=289)[1:288]
cor_data <- data.frame(t, Bankrupcy, Unemployment_Rate, Population, House_Price_Index)
cor(cor_data)

par(mfrow=c(1,1))
plot(Bankrupcy, main = 'Figure 1. Monthly Canadian Bankruptcy Rates, 1987-2010',
     xlab = 'Time', ylab = 'Bankruptcy Rate')
plot(Unemployment_Rate, type = "l", col = "blue")
plot(Population, type = "l", col = "red")
plot(House_Price_Index, type = "l", col = "green")

# scale
plot(ts(scale(Bankrupcy), start = c(1987,1), frequency = 12), type = 'l', col = 'black',
     main = 'Figure 2. Scaled Plot of Bankruptcy and Potential Covariates, 1987-2010',
     ylab = 'Scaled Value')
points(ts(scale(Unemployment_Rate), start = c(1987,1), frequency = 12), type = 'l', col = 'orange')
points(ts(scale(Population), start = c(1987,1), frequency = 12), type = 'l', col = 'grey')
points(ts(scale(House_Price_Index), start = c(1987,1), frequency = 12), type = 'l', col = 'blue')
legend(x = 1995, y = 3.3, 
       legend = c('Bankruptcy', 'Unemployment', 'Population', 'HPI'), 
       col = c('black', 'orange', 'grey', 'blue'), 
       lty = c(1, 1, 1,1),
       lwd = c(2.5, 2.5, 2.5,2.5),
       bty = 'n')

# Split into training and validation sets
trainb <- train[1:228, ]
validb <- train[229:288, ]
train_bank <- ts(trainb$Bankruptcy_Rate, start = c(1987, 1), end = c(2005, 12), frequency = 12)
train_pop <- ts(trainb$Population, start = c(1987, 1), end = c(2005, 12), frequency = 12)
train_unemp <- ts(trainb$Unemployment_Rate, start = c(1987, 1), end = c(2005, 12), frequency = 12)
train_hpi <- ts(trainb$House_Price_Index, start = c(1987, 1), end = c(2005, 12), frequency = 12)

valid_bank <- ts(validb$Bankruptcy_Rate, start = c(2006, 1), end = c(2010, 12), frequency = 12)
valid_pop <- ts(validb$Population, start = c(2006, 1), end = c(2010, 12), frequency = 12)
valid_unemp <- ts(validb$Unemployment_Rate, start = c(2006, 1), end = c(2010, 12), frequency = 12)
valid_hpi <- ts(validb$House_Price_Index, start = c(2006, 1), end = c(2010, 12), frequency = 12)


