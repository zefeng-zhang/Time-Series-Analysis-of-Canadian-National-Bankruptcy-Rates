Time Series Analysis of Canadian National Bankruptcy Rates
==========================================================

by Zefeng Zhang, Arda Aysu, Erin Chinn, Philip Rotella

Background and Data
-------------------

The goal of this report is to forecast Canadian monthly bankruptcy rates for the years 2011 and 2012 using atime series model. The primary data for constructing this model consisted of historic Canadian monthlybankruptcy rates from January 1987 through December 2010. Secondary Canadian national data was availablefrom January 1987 through the end of the forecasting period (i.e., December 31, 2012) for three potentialcovariates: unemployment rate, population size, and housing price index (HPI). HPI is an economic indicatorthat measures average price changes in repeat sales or refinancings on the same single-family houses.

The optimal model we propose is a SARIMAX(3,1,3)x(2,0,0)[12] model on log-transformed bankruptcy data,with housing price index as an external variable. Although the details of this model are outside the scopeof this report, a brief description of this modeling approach along with other modeling options is includedbelow. The predictions for Canadian monthly bankruptcy rate for 2011 to 2012 made by our optimal modelare summarized and plotted at the end of this report.

Methods
-------

There are numerous modeling approaches available to forecast bankruptcy rates. This report will summarizesome of the most common approaches, highlight the one used for our final model, and discuss what made itthe optimal choice. Each model was fit by altering various parameters. These parameters change how themodel fits the data and in turn what predictions it makes. 

They account for the following: 
* Overall trend -does bankruptcy rate increase or decrease with time?
* Seasonal trend - does bankruptcy rate have similar fluctuations within each year?

**Exponential smoothing**: The smoothing method uses a set of equations to filter or smooth a model to thedata. Specifically this method calculates an average of the observed bankruptcy rates based on the currenttime in addition to a previous prediction of the rates at an earlier time.

**SARIMA**: Another modeling approach is the SARIMA model. SARIMA stands for seasonal autoregressiveintegrated moving average. In essence the model can be broken into two main parts. The first part of thismodel predicts bankruptcy rate using previous bankruptcy rates. The second part models deviations from the true bankruptcy rate using the deviations from previous bankruptcy rates.

**SARIMAX**: A similar modeling approach to SARIMA is the SARIMAX method. The difference here is thatSARIMAX allows us to consider external variables that could also affect the prediction variable, bankruptcyrate. In this project these external variables are: unemployment rate, population, and housing price index.

**VAR**: The last approach considers external variables as well. However unlike SARIMAX, it treats all variablessymmetrically. While SARIMAX only considers the effect the outside variables have on bankruptcy rate, theVAR approach considers all variables as possibly affecting each other. This method simultaneously accountsfor these interdependencies.

Model Construction
------------------

To select an appropriate modeling approach, we first visualized how bankruptcy data has changed over timefrom 1987 through 2010. As shown in **Figure 1**, the bankruptcy rates have generally increased since 1987,with marked within-year peaks and valleys and prolonged periods of both growth and decline. The trend over time indicates the need for a model that can handle “non-stationary” data, and cyclical trends indicatethat the model should account for seasonality.

![alt tag](https://github.com/zefeng-zhang/Time-Series-Analysis-of-Canadian-National-Bankruptcy-Rates/blob/master/images/figure1.png)

Next, we looked at the time trends of our external variables (unemployment, population, and HPI) to assesswhether a univariate or multivariate approach would be best. **Figure 2** plots each of these time series curvesalong with bankruptcy rates, all scaled to fit within the same axis. We judged HPI to be most relatedto bankruptcy so included it in our model, treating it as a one-directional, non-synergistic relationship.Therefore, we chose SARIMAX as our modeling approach.

![alt tag](https://github.com/zefeng-zhang/Time-Series-Analysis-of-Canadian-National-Bankruptcy-Rates/blob/master/images/figure2.png)

In order to tune the model inputs for optimal forecasting accuracy, we fit various models on a subset ofyears, 1987–2005, and validated each model’s performance in predicting bankruptcy rates for 2006–2010.Model fit was determined by calculating the average difference between the predicted bankruptcy rates forour validation time frame and the observed bankruptcy rates for the same period. A smaller difference meanta more accurate prediction and a better fitting model.

Once we found the model parameters that yielded the best fit for the data from January 2006 to December2010, we re-fit the model using all of our data from January 1987 to December 2010. While the model wasoptimized to give us the smallest difference, it was also subject to meeting certain modeling assumptionsThese constraints involved analysis of the residuals, or the difference between our model-estimated valuesand the actual values, from January 2006 to December 2010. They included the following: - Normality -does the distribution of residuals follow a bell curve? - Zero-mean - is the average value of the residualszero? - Constant variance - do the residuals vary with constant magnitude across all years and months? -Zero-correlation - are residuals prone to be similar to the residual from the previous year or month?

A check of these model assumptions revealed significant changes in variance over time, which would invalidateour predictions from that model. To correct for this, we log-transformed the bankruptcy rates and refit themodel. The resulting model passed all assumptions and was used to predict values for bankruptcy rate fromJanuary 2011 to December 2012.

Final Model
-----------

The final model we chose is a SARIMAX(3,1,3)x(2,0,0)[12] model on log-transformed bankruptcy rates,with housing price index as an external variable. It predicted values of bankruptcy rate close to the actualvalues for the validation time frame, January 2006 to December 2010, while satisfying all required modelingassumptions. Although this model uses outside variables for predicting bankruptcy rates, the model waskept conservative. Housing price index was the only external variable included. This model passes all fourof our modeling assumptions, with residuals demonstrating normality, zero mean, constant variance, and uncorrelatedness.

The bankruptcy rates predicted by the model can be seen in **Figure 3** below. Included in theplot are 95% prediction intervals. These intervals are the range of values between which we are confident thatthe true forecasted bankruptcy rate lies.

In order to forecast with a SARIMAX model, future values of the external variable, housing price index, areneeded. The prediction interval shown in the plot does not account for the uncertainty of predicting futurehousing price index values. Predictions of bankruptcy rate were calculated using the observed housing priceindex for 2011 and 2012.

![alt tag](https://github.com/zefeng-zhang/Time-Series-Analysis-of-Canadian-National-Bankruptcy-Rates/blob/master/images/figure3.png)























