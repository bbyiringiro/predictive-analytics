# R Code for Chapter 6: Tree-based Learning
#
# This code performs 'Classification' using a Single Classification Tree and Random Forests
#
# Using USA SUPREME COURT DATA
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
## ------- LOAD US SUPREME COURT DATA/PREPROCESS/SPLIT INTO TRAIN AND TEST -----

# STEP 1: Load US SUPREME COURT DATA data 

# Dependent variable  - Did justice Stevens reverse the lower court decision (0 - affirm; 1 - reverse)

# Read the data (make sure the you set the right working directory)

getwd()

# Go to Tab 'Session', and from the drop down list select 'Set Working Directory'

SupremeCourtData = read.csv("SCOTUS_data.csv")

p = ncol(SupremeCourtData)-1             # number of cols (566 rows, 9 columns)

SupremeCourtData[1:5,]                   # first five row

dim(SupremeCourtData)                    # 263 rows and 20 cols

names(SupremeCourtData)                  # look at variable names

summary(SupremeCourtData)                # Summary of the data

attach(SupremeCourtData)

## -----------------------------------------------------------------------------
# STEP 2: Split the data into a training (80%) and test sample (20%)

X          = SupremeCourtData[,3:8]     # Features X
y          = SupremeCourtData[,9]       # Label y
n          = nrow(X)                    # Sample size n

set.seed(3)

RandomIndx = sample(n)                  # Shuffle indexes 
NoTrain    = round(0.8*n)               # No. of training obs.
TrainIndx  = RandomIndx[1:NoTrain]      # Select 80% obs. for training

X          = as.data.frame(X)
XTrain     = X[TrainIndx,]              # Training Features X
XTest      = X[-TrainIndx,]             # Test Features X

y          = as.factor(y)
yTrain     = y[TrainIndx]               # Training Label y 
yTest      = y[-TrainIndx]              # Test Label y

n_Test    = nrow(XTest)                 # No. of test obs.


## -----------------------------------------------------------------------------
## ---------------------------- CLASSIFICATION TREE ----------------------------

# STEP 3: Train a Classification Tree (using say only Circuit and Lower court)

ClassTree     = rpart(yTrain ~ Circuit+LowerCourt, data = XTrain, method="class")  # Train a Classification tree 

prp(ClassTree)                                                    # Option 1: Visualize data using Tree
title("Classification Tree: SCOTUS") 

## -----------------------------------------------------------------------------

# STEP 4: Train a Classification Tree (using ALL variables)

ClassTreeAll  = rpart(yTrain ~ ., data = XTrain, method="class")  # Train a classification tree using all vars.

prp(ClassTreeAll)                                                 # Option 1: Visualize data using Tree
title("Classification Tree: SCOTUS")

## -----------------------------------------------------------------------------

# STEP 5: Generate forecasts using a Classification Tree and evaluate the model

PredictClassTree  = predict(ClassTreeAll, newdata = XTest, type = "class") # Make predictions

zClassTree = table(yTest, PredictClassTree)                                # Confusion matrix

zClassTree

sum(diag(zClassTree))/sum(zClassTree)


## -----------------------------------------------------------------------------
## --------------------- RANDOM FORESTS FOR CLASSIFICATION ---------------------

# STEP 6: Train a Random forest model for classification

set.seed(31)
SupremeCourtForest = randomForest(yTrain ~ ., data = XTrain, ntree=500, nodesize=10, importance=TRUE)

print(SupremeCourtForest)

importance(SupremeCourtForest)    # Table - variable importance
varImpPlot(SupremeCourtForest)    # Plot - variable importance

## -----------------------------------------------------------------------------

# STEP 7: Generate forecasts using Random forests and evaluate the model

PredictForest = predict(SupremeCourtForest, newdata = XTest) # Make predictions on the test data using RF

z = table(yTest, PredictForest)
z

sum(diag(z))/sum(z)   # ACCURACY 

TP = z[2,2]           # TRUE POSITIVES    
TP

TN = z[1,1]           # TRUE NEGATIVES
TN

FP = z[1,2]           # FALSE POSITIVES
FP

FN = z[2,1]           # False NEGATIVES
FN

Accuracy_RF    = (TP+TN)/(TP+TN+FP+FN)
Accuracy_RF

Sensitivity_RF = (TP)/(TP+FN) 
Sensitivity_RF

Specificity_RF = (TN)/(TN+FP) 
Specificity_RF

# -----------------------------------------------------------------------------------------------------------

