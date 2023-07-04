# R Code for Chapter 6: Tree-based Learning
#
# This code performs 'Regression' using a Single Regression Tree and Random Forests
#
# Using Hitters Salary data
#
# ------------------------------------------------------------------------------

# Load packages
install.packages("ISLR")
install.packages("glmnet")
install.packages("rpart")
install.packages("rpart.plot")
install.packages("randomForest")

library(ISLR)
library(glmnet)
library(rpart)
library(rpart.plot)
library(randomForest)

## -----------------------------------------------------------------------------
## ----------- LOAD HITTERS DATA/PREPROCESS/SPLIT INTO TRAIN AND TEST ----------

# STEP 1: Load Hitters data (Model player's salary as a function of 19 variables)

Hitters = na.omit(Hitters)      # remove any missing data 

p       = ncol(Hitters)-1       # number of predictor (20 columns - 1 response, 19 predictors)

Hitters[1:5,]                   # first five row

dim(Hitters)                    # 263 rows and 20 cols

names(Hitters)                  # look at variable names

summary(Hitters)                # Summary of the data

attach(Hitters)

## -----------------------------------------------------------------------------
# STEP 2: Split the data into a training (80%) and test sample (20%)

X          = model.matrix(Salary~.-1,data=Hitters)        # Features X
y          = Salary                                       # Label y
n          = nrow(X)                                      # Sample size n

set.seed(3)

RandomIndx = sample(n)                  # Shuffle indexes 
NoTrain    = round(0.8*n)               # No. of training obs.
TrainIndx  = RandomIndx[1:NoTrain]      # Select 80% obs. for training

X          = as.data.frame(X)
XTrain     = X[TrainIndx,]              # Training Features X
XTest      = X[-TrainIndx,]             # Test Features X

yTrain     = y[TrainIndx]               # Training Label y 
yTest      = y[-TrainIndx]              # Test Label y

n_Test    = nrow(XTest)                 # No. of test obs.

## -----------------------------------------------------------------------------
## ------------------------------ REGRESSION TREE ------------------------------

# STEP 3: Train a Regression Tree (using say only Years and Hits to forecast salary)

RegTree         = rpart(yTrain ~ Years+Hits, data = XTrain)    # Train a regression tree 

prp(RegTree)                                                   # Option 1: Visualize data using Tree
title("Regression Tree: Hitters Salary")

rpart.plot(RegTree)                                            # Option 2: Visualize data using Tree

## -----------------------------------------------------------------------------

# STEP 4: Train a Regression Tree (using ALL variables)

RegTreeAll         = rpart(yTrain ~ ., data = XTrain)          # Train a regression tree using all vars.

prp(RegTreeAll)                                                # Option 1: Visualize data using Tree
title("Regression Tree: Hitters Salary")

## -----------------------------------------------------------------------------

# STEP 5: Generate forecasts using a Regression Tree and evaluate the model
PredictSalaryRT = predict(RegTreeAll, newdata = XTest)         # Make predictions using test data

RMSE_tree = sqrt(mean((PredictSalaryRT - yTest)^2))            # Calculate test RMSE (units $)
MAE_tree  = mean(abs(PredictSalaryRT - yTest))                 # Calculate test MAE (units $)

RMSE_tree
MAE_tree

## -----------------------------------------------------------------------------

# STEP 6: Plot Actual and Predicted Salaries

plot(1:n_Test,yTest,type="l",col="blue",xlab="Test Obs. Index",ylab="Salary",lwd=3)
lines(1:n_Test,PredictSalaryRT,col="green",lwd=2)

legend(32, 1500, legend=c("Actual", "Prediction"),
       col=c("blue", "green"),  lwd = 3:2)

## -----------------------------------------------------------------------------
## ---------------------- RANDOM FORESTS FOR REGRESSION  -----------------------

# STEP 7: Train a Random forests (using say only Years and Hits to forecast salary)

set.seed(3)
RFreg = randomForest(yTrain ~ ., data = XTrain, ntree = 500, nodesize=10, importance=TRUE)

importance(RFreg)                                              # Table - variable importance
varImpPlot(RFreg)                                              # Plot  - variable importance

## -----------------------------------------------------------------------------

# STEP 8: Generate forecasts using Random forests and evaluate the model

PredictSalaryRF = predict(RFreg, newdata = XTest)              # Make predictions on the test data using RF

RMSE_forest = sqrt(mean((PredictSalaryRF - yTest)^2))            # Calculate test RMSE (units $)
MAE_forest  = mean(abs(PredictSalaryRF - yTest))                 # Calculate test MAE (units $)

RMSE_tree 
RMSE_forest

MAE_tree  
MAE_forest

## -----------------------------------------------------------------------------

# STEP 9: Plot Actual and Predicted Salaries

plot(1:n_Test,yTest,type="l",col="blue",xlab="Test Obs. Index",ylab="Salary",lwd=3)
lines(1:n_Test,PredictSalaryRF,col="black",lwd=2)

legend(30, 1500, legend=c("Actual", "Prediction"),
       col=c("blue", "black"),  lwd = 3:2)

# -----------------------------------------------------------------------------------------------------------



