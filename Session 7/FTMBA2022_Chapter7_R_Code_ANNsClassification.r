# R Code for Chapter 3 - Supervised Learning: Classification using ANNs
#
# This code builds a logistic regression model using the Bank Default data
#
# Dependent categorical variable y - Default (1: yes; 0: no)
#
# Independent variables          X - Student status (1: yes; 0: no); Balance; Income 
#
# --------------------  Classification with ANNs USING DEFAULT DATA -----------------

# Install packages
install.packages("tidyverse")    # data manipulation and visualization
install.packages("modelr")       # provides easy pipeline modeling functions
install.packages("broom")        # helps to tidy up model outputs
install.packages("neuralnet ")   # package for ANNs

# load library
library(tidyverse)  
library(modelr)     
library(broom)      
library(neuralnet)

## -----------------------------------------------------------------------------

# STEP 1: SET WORKING DIRECTORY AND LOAD DATA

getwd()

# LOAD DATA (use either .csv or .rds formats)
Default_data1 <- read.csv("DefaultDataset.csv")  # or Default_data = readRDS("DefaultDataset.rds")

attach(Default_data1)

Default_data = Default_data1

for (i in 1:4)
{Default_data[,i]=(Default_data[,i]-min(Default_data[,i]))/(max(Default_data[,i])-min(Default_data[,i]))}

names(Default_data)                  # check variable names - "default" "student" "balance" "income" 

summary(Default_data)                # Summary of the data

## -----------------------------------------------------------------------------
# STEP 2: Split the data into a training (80%) and test sample (20%)
n          = nrow(Default_data)                                      # Sample size n

set.seed(3)

RandomIndx = sample(n)                  # Shuffle indexes 
NoTrain    = round(0.8*n)               # No. of training obs.
TrainIndx  = RandomIndx[1:NoTrain]      # Select 80% obs. for training

Default_data_Train = Default_data[TrainIndx,];
Default_data_Test  = Default_data[-TrainIndx,];

## -----------------------------------------------------------------------------
# STEP 3: Fit ANN 

# Simplest ANN
set.seed(4)

NN1 = neuralnet(default ~ balance + income + student, Default_data_Train, hidden = 1, linear.output = T)

# Plot neural network
plot(NN1)

# 2 Hidden layer and 2 units
set.seed(4)

NN2 = neuralnet(default ~ balance + income + student, Default_data_Train, hidden = c(2,2), linear.output = T)

# plot neural network
plot(NN2,rep = "best")

# 2 Hidden layer and 3 units
NN3 = neuralnet(default ~ balance + income + student, Default_data_Train, hidden = c(3,3), act.fct = "logistic")

# plot neural network
plot(NN3)

# ------------------------------------------------------------------------------

# STEP 4: Make predictions
yTest                 = Default_data_Test[,1]
predict_testNN        = neuralnet::compute(NN2, Default_data_Test[,-1])
predict_testNNrescale = predict_testNN$net.result*(max(yTest) - min(yTest)) + min(yTest)

z = table(yTest,round(predict_testNNrescale))

sum(diag(z))/sum(z)   # ACCURACY 

# -----------------------------------------------------------------------------------------------------------



      