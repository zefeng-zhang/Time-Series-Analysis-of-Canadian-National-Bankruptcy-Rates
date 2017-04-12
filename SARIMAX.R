source("data.R")

#############
## SARIMAX ##
#############

m <- arima(log(train_bank), order = c(3,1,3), seasonal = list(order = c(1,0,1), period = 12), xreg = data.frame(log(train_hpi)), method = 'ML')
f <- forecast(m, h = 60, level=c(0.95), xreg = data.frame(log(valid_hpi)) )
cat ("RMSE =", sqrt(mean(( exp(f$mean) - valid_bank )^2 )), "\n" )

# pred, h, l, fitted
l<-ts(f$lower, start = c(2006, 1), frequency = 12)  #95% PI LL
h<-ts(f$upper, start = c(2006, 1), frequency = 12) #95% PI UL
pred<-f$mean #predictions
fitted <- f$fitted

l <- exp(l)
h <- exp(h)
pred <- exp(pred)
fitted <- exp(fitted)

# Graphical format
par(mfrow=c(1,1))
plot(Bankrupcy, xlim=c(1987,2011), ylim=c(0.01, 0.05), main = "Monthly Bankruptcy Rate", ylab = "Bankruptcy Rate", xlab = "Month")
abline(v = 2006, lwd = 2, col = "black")
points(pred, type = "l", col = "blue")
points(l, type = "l", col = "red")
points(h, type = "l", col = "red")
points(fitted, type="l", col = "green")
legend("topleft", legend = c("Observed", "Fitted", "Predicted", "95% PI"), lty = 1, col = c("black", "green", "blue", "red"), cex = 0.5)

# Residuals Diagnostics
e <- f$residuals
e <- ts(e, start=c(1984,1), frequency = 12)
par(mfrow=c(1,1))
plot(e, main="Residuals vs t", ylab="")

# test whether residuals have zero mean
t.test(e)

# test for heteroscedasticity
group <- c(rep(1,57), rep(2,57), rep(3,57), rep(4,57))
levene.test(e,group) #Levene
bartlett.test(e,group) #Bartlett   

# test for uncorrelatedness / randomness
tsdiag(m) #ACF and Ljung-Box test all in one!

# test for normality
par(mfrow=c(1,1))
qqnorm(e, main="QQ-plot of Residuals")
qqline(e, col = "red")
shapiro.test(e) #SW test

############################################
# Forecast bankruptcy between 2011 and 2012
test <- read.csv("test.csv", header = T)
test_pop <- ts(test$Population, start = c(2011, 1), end = c(2012, 12), frequency = 12)
test_unemp <- ts(test$Unemployment_Rate, start = c(2011, 1), end = c(2012, 12), frequency = 12)
test_hpi <- ts(test$House_Price_Index, start = c(2011, 1), end = c(2012, 12), frequency = 12)

m <- arima(log(Bankrupcy), order = c(3,1,3), seasonal = list(order = c(1,0,1), period = 12), xreg = data.frame(House_Price_Index), method = 'ML')
f <- forecast(m, h = 24, level=c(0.95), xreg = data.frame(test_hpi) )

# pred, h, l, fitted
l<-exp(ts(f$lower, start = c(2011, 1), frequency = 12))  #95% PI LL
h<-exp(ts(f$upper, start = c(2011, 1), frequency = 12)) #95% PI UL
pred<-exp(f$mean) #predictions
fitted <- exp(f$fitted)

# Tabular format
table <- data.frame(mean=pred, lower=l, upper=h)
table <- ts(table, start=c(2011,1), end=c(2012,12), frequency = 12)
colnames(table) <- c("forecasts", "lower interval", "upper interval")
print (table)

# Graphical format
par(mfrow=c(1,1))
plot(Bankrupcy, xlim=c(1987,2012), ylim=c(0, 0.055), main = "Monthly Bankruptcy Rate", ylab = "Bankruptcy Rate", xlab = "Month")
abline(v = 2011, lwd = 2, col = "black")
points(pred, type = "l", col = "blue")
points(l, type = "l", col = "red")
points(h, type = "l", col = "red")
points(fitted, type="l", col = "green")
legend("topleft", legend = c("Observed", "Fitted", "Predicted", "95% PI"), lty = 1, col = c("black", "green", "blue", "red"), cex = 0.5)

# residuals
e <- f$residuals 
par(mfrow=c(1,1))
plot(e, main="Residuals vs t", ylab="")

# test whether residuals have zero mean
t.test(e)

# test for heteroscedasticity
group <- c(rep(1,72), rep(2,72), rep(3,72), rep(4,72))
levene.test(e,group) #Levene
bartlett.test(e,group) #Bartlett   

# test for uncorrelatedness / randomness
tsdiag(m) #ACF and Ljung-Box test all in one!

# test for normality
par(mfrow=c(1,1))
qqnorm(e, main="QQ-plot of Residuals")
qqline(e, col = "red")
shapiro.test(e) #SW test
