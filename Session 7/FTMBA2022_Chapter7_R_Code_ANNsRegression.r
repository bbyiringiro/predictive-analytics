# R Code for Chapter 7: Artificial Neural Networks (ANNs)
#
# This code performs 'Regression' using ANNs
#
# Using Elecricity Demand data
#
# ------------------------------------------------------------------------------

# Load packages
install.packages("ISLR")
install.packages("glmnet")
install.packages("neuralnet")   # package for ANNs

library(readxl)                  # Press control+Enter
library(corrplot)
library(ISLR)
library(glmnet)
library(neuralnet)

## -----------------------------------------------------------------------------
## ----------- LOAD DATA AND SCALE (ELECTRICITY CONSUMPTION) ----------

# STEP 1: Load Electricity data (Model Demand)

ElecConsumeData1 <- read_excel("GBElectricityAndWeatherData.xlsx")

ElecConsumeData = ElecConsumeData1

# Scale data such that every variable lies between 0 and 1
for (i in 2:23)
{ElecConsumeData[,i]=(ElecConsumeData[,i]-min(ElecConsumeData[,i]))/(max(ElecConsumeData[,i])-min(ElecConsumeData[,i]))}

min(ElecConsumeData$Demand)  # min is now 0
max(ElecConsumeData$Demand)  # max is now 1

head(ElecConsumeData)                            # view first five rows

ElecConsumeData = ElecConsumeData[,2:23];        # ignore months

View(ElecConsumeData)                            # view whole data

dim(ElecConsumeData)                             # 103 rows/obs. and 6 cols.

names(ElecConsumeData)                           # variable names

summary(ElecConsumeData)                         # Summary of the data

# ------------------------------------------------------------------------------

# STEP 2: ANALYSIS (SCATTER PLOTS AND CORRELATION)
# FOR INSIGHTS INTO RELATIONSHIPS BETWEEN VARIABLES

pairs(ElecConsumeData[,1:8], pch = 19, lower.panel = NULL)   # Scatter plot (only lower panel)

Corr = cor(ElecConsumeData[,1:8])                            # Correlation table

Corr                                                   # Correlation table

corrplot(Corr,type = "lower")                          # Correlation plot (only lower panel)


## -----------------------------------------------------------------------------
# STEP 3: Split the data into a training (80%) and test sample (20%)

n          = nrow(ElecConsumeData)                                      # Sample size n

set.seed(3)

NoTrain    = round(0.8*n)               # No. of training obs.
TrainIndx  = 1:NoTrain      # Select 80% obs. for training

ElecConsumeData_Train = ElecConsumeData[TrainIndx,];
ElecConsumeData_Test  = ElecConsumeData[-TrainIndx,];

## -----------------------------------------------------------------------------
# STEP 4: Split the data into a training (80%) and test sample (20%)

# Fit Simplest ANN using all Features 
set.seed(4)

NN1 = neuralnet(Demand ~ ., ElecConsumeData_Train, hidden = 1, linear.output = T)

# Plot neural network
plot(NN1,rep = "best")

# Fit  ANN with 2 Hidden layers each having 2 units. Use all Features 
set.seed(4)

NN2 = neuralnet(Demand ~ ., ElecConsumeData_Train, hidden = c(2,2), linear.output = T)

# plot neural network
plot(NN2,rep = "best")

# Fit  ANN with 2 Hidden layers each having 3 units. Use all Features 
NN3 = neuralnet(Demand ~ ., ElecConsumeData_Train, hidden = c(3,3), act.fct = "logistic")

# plot neural network
plot(NN3,rep = "best")

# ------------------------------------------------------------------------------
# STEP 5: Generate forecasts using a ANNs and evaluate the model

yTest                 = ElecConsumeData1$Demand[-TrainIndx]
predict_testNN        = neuralnet::compute(NN3, ElecConsumeData_Test[,-1])
predict_testNNrescale = predict_testNN$net.result*(max(yTest) - min(yTest)) + min(yTest)

RMSE_ANNs = sqrt(mean((predict_testNNrescale - yTest)^2))  # Calculate test RMSE (units $)
MAE_ANNs  = mean(abs(predict_testNNrescale - yTest))       # Calculate test MAE (units $)

RMSE_ANNs
MAE_ANNs

## -----------------------------------------------------------------------------

# STEP 9: Plot Actual and Predicted Electricity Demand

n = length(yTest);

plot(1:n,yTest,type="l",col="blue",xlab="Test Obs. Index",ylab="Electricity Demand",lwd=3)
lines(1:n,predict_testNNrescale,col="green",lwd=4)

legend(0, 45000, legend=c("Actual", "Prediction"),
       col=c("blue", "green"),  lwd = 3:4)

# -----------------------------------------------------------------------------------------------------------

