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
plot(Bankrupcy)
plot(Unemployment_Rate, type = "l", col = "blue")
plot(Population, type = "l", col = "red")
plot(House_Price_Index, type = "l", col = "green")

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


