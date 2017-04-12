source("data.R")

#########
## VAR ##
#########

if(T){
  RMSE_value <- c()
  p_value <- c()
  for (p in seq(1, 10, 1)){
    m <- VAR(y = data.frame(train_bank, train_unemp), p = p, season = 12)
    f <- predict(m, n.ahead = 60, ci = 0.95)
    RMSE <- sqrt( mean( (f$fcst$train_bank[,1] - valid_bank)^2 ) )
    RMSE_value <- c(RMSE_value, RMSE)
    p_value <- c(p_value, p)
  }
  data.frame(p_value, RMSE_value)
  index <- which(RMSE_value == min(RMSE_value))
  cat (p_value[index], RMSE_value[index])
  # train_hpi, train_pop, train_unemp; p = 6; RMSE = 0.003655931
  # train_hpi, train_pop; p = 6; RMSE = 0.003562435
  # train_hpi, train_unemp; p = 10; RMSE = 0.00360208
  # train_pop, train_unemp; p = 8; RMSE = 0.004012921
  # train_pop; p = 10; RMSE = 0.003984176
  # train_hpi; p = 3; RMSE = 0.00363303
  # train_unemp; p = 9; RMSE = 0.004965254
}

if(T){
  # Let's fit a few models
  m <- VAR(y = data.frame(train_bank, train_hpi, train_pop), p = 6, season = 12)
  f <- predict(m, n.ahead = 60, ci = 0.95)
  cat ("RMSE =", sqrt(mean(( f$fcst$train_bank[,1] - valid_bank )^2 )), "\n" )
  
  # pred, h, l, fitted
  l <- ts(f$fcst$train_bank[,2], start = c(2006, 1), frequency = 12)  #95% PI LL
  h <- ts(f$fcst$train_bank[,3], start = c(2006, 1), frequency = 12) #95% PI UL
  pred <- ts(f$fcst$train_bank[,1], start = c(2006, 1), frequency = 12) #predictions
  fitted <- ts(m$varresult$train_bank$fitted.values, start = c(1987, 7), frequency = 12)
  
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
  e.1 <- train_bank - fitted
  par(mfrow=c(1,1))
  plot(e.1, main="exp Residuals vs t", ylab="")
}
