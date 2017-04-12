source("data.R")

##################
## Holt-Winters ##
##################

if(T){
  # Have both normal and seasonal differencing
  RMSE_value <- c()
  alpha_value <- c()
  beta_value <- c()
  gamma_value <- c()
  for (alpha in seq(0.1, 0.9, 0.1) ){
    for (beta in seq(0.1, 0.9 ,0.1) ){
      for (gamma in seq(0.1, 0.9, 0.1) ){
        m <- HoltWinters(x = train_bank, alpha = alpha, beta = beta, gamma = gamma, seasonal = "add")
        f <- forecast(m, h = 60, level=c(95) )
        RMSE <- sqrt( mean( (f$mean - valid_bank)^2 ) )
        RMSE_value <- c(RMSE_value, RMSE)
        alpha_value <- c(alpha_value, alpha)
        beta_value <- c(beta_value, beta)
        gamma_value <- c(gamma_value, gamma)
      }
    }
  }
  data.frame(alpha_value, beta_value, gamma_value, RMSE_value)
  index <- which(RMSE_value == min(RMSE_value))
  cat (alpha_value[index], beta_value[index], gamma_value[index])
}
# "add": 0.1, 0.8, 0.6 RMSE = 0.003725052
# "mul": 0.4, 0.3, 0.5 RMSE = 0.003712317

if(T){
  # To find the "optimal" Holt-Winters model, try different smoothing methods
  par(mfrow = c(1,1))
  m <- HoltWinters(x = train_bank, alpha = 0.1, beta = 0.8, gamma = 0.6, seasonal = "add")
  f <- forecast(m , h = 60, level=c(95))
  cat ("RMSE =", sqrt(mean(( f$mean - valid_bank )^2 )), "\n" )
  
  # pred, h, l, fitted
  l <- ts(f$lower, start = c(2006, 1), frequency = 12)  #95% PI LL
  h <- ts(f$upper, start = c(2006, 1), frequency = 12) #95% PI UL
  pred <- f$mean #predictions
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
  e <- ts(e, start=c(1987,1), frequency = 12)
  par(mfrow=c(1,1))
  plot(e, main="Residuals vs t", ylab="")
}
