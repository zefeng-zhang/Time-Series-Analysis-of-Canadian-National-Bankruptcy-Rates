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



