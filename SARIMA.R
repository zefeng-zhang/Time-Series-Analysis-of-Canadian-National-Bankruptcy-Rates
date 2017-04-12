source("data.R")

############
## SARIMA ##
############

# The raw time series is clearly not stationary. Try differencing log(exp) once:
train_bank1 <- diff(train_bank)
plot(train_bank1, ylab = "train_bank1")
par(mfrow=c(1,1))
acf(train_bank1, lag.max = 48)
adf.test(train_bank1)
pacf(train_bank1, lag.max = 48)

# There still seems to be monthly seasonality (period = 12). Let's try differencing for that.
train_bank1.12 <- diff(train_bank1, lag = 12)
par(mfrow=c(1,1))
plot(train_bank1.12, ylab = "train_bank1.12")
par(mfrow=c(1,1))
acf(train_bank1.12, lag.max = 48)
adf.test(train_bank1.12)
pacf(train_bank1.12, lag.max = 48)

ndiffs(train_bank)
nsdiffs(train_bank)
auto.arima(train_bank)

if(T){  
  # Tune parameters
  RMSE_value <- c()
  p_value <- c()
  q_value <- c()
  P_value <- c()
  Q_value <- c()
  D_value <- c()
  for (p in seq(0, 5, 1) ){
    for (q in seq(0, 5 ,1) ){
      for (P in seq(0, 1, 1) ){
        for (Q in seq(0, 1, 1) ){
          for (D in seq(0, 1, 1)){
            m <- arima(log(train_bank), order = c(p,1,q), seasonal = list(order = c(P,D,Q), period = 12), method = "CSS")
            m_pred <- forecast(m, h = 60, level=c(95))
            RMSE <- sqrt(mean(( m_pred[[4]] - valid_bank )^2 ))
            RMSE_value <- c(RMSE_value, RMSE)
            p_value <- c(p_value, p)
            q_value <- c(q_value, q)
            P_value <- c(P_value, P)
            Q_value <- c(Q_value, Q)
            D_value <- c(D_value, D)
          }
        }
      }
    }
  }
  data.frame(p_value, q_value, P_value, D_value, Q_value, RMSE_value)
  index <- which(RMSE_value == min(RMSE_value))
  cat (p_value[index], q_value[index], P_value[index], D_value[index], Q_value[index])
}

if(T){
  m <- arima(train_bank, order = c(3,1,5), seasonal = list(order = c(1,0,1), period = 12), method = "CSS")
  f <- forecast(m, h = 60, level=c(95))
  cat ("RMSE =", sqrt(mean(( f$mean - valid_bank )^2 )), "\n" )
  
  # pred, h, l, fitted
  l<-ts(f$lower, start = c(2006, 1), frequency = 12)  #95% PI LL
  h<-ts(f$upper, start = c(2006, 1), frequency = 12) #95% PI UL
  pred<-f$mean #predictions
  fitted <- f$fitted
  
  # Graphical format
  par(mfrow=c(1,1))
  plot(Bankrupcy, xlim=c(1987,2011), ylim=c(0.01, 0.05), main = "Monthly Bankruptcy Rate", ylab = "Bankruptcy Rate", xlab = "Month")
  abline(v = 2006, lwd = 2, col = "black")
  points(pred, type = "l", col = "blue")
  points(l, type = "l", col = "red")
  points(h, type = "l", col = "red")
  points(fitted, type="l", col = "green")
  legend("topleft", legend = c("Observed", "Fitted", "Predicted", "95% PI"), lty = 1, col = c("black", "green", "blue", "red"), cex = 0.5)
  
  # residuals
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
}
