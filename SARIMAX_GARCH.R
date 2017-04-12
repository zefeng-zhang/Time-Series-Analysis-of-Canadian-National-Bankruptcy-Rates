source("data.R")

#####################
## SARIMAX + GARCH ##
#####################

# To choose the orders k and l, we need to look at the ACF and PACF plots of |r| or r^2
e <- m$residuals
par(mfrow=c(1,1))
# ACF plots of residuals
acf(e, main = "ACF of SARIMAX Residuals")
acf(abs(e), main = "ACF of Absolute SARIMAX Residuals")
pacf(abs(e), main = "PACF of Absolute SARIMAX Residuals")

# There is clearly decay on the ACF plot suggesting that l >= 1. As a simple place to begin 
# modeling, try k = 0 and l = 1. To actually fit an ARMA + GARCH model, we can use either:
# -- the garchFit function in the 'fGARCH' library, or
# -- the ugarchfit function in the 'rugarch' library

library(fGarch)
m <- garchFit(formula = ~arma(3,5) + garch(1,1), data = diff(train_bank), include.mean = F)
plot(m)
