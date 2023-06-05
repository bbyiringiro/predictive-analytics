# R Code for Chapter 3 - Supervised Learning: Classification using Logistic Regression
#
# This code builds a logistic regression model using the Bank Default data
#
# Dependent categorical variable y - Default (1: yes; 0: no)
#
# Independent variables          X - Student status (1: yes; 0: no); Balance; Income 
#
# --------------------  LOGISTIC REGRESSION USING DEFAULT DATA -----------------

# Install packages
install.packages("tidyverse")    # data manipulation and visualization
install.packages("modelr")       # provides easy pipeline modeling functions
install.packages("broom")        # helps to tidy up model outputs

library(tidyverse)  
library(modelr)     
library(broom)      

## -----------------------------------------------------------------------------

# STEP 1: SET WORKING DIRECTORY AND LOAD DATA

getwd()

# Go to 'Session' tab -> 'Set Working Directory' -> 'To Source File Location'

# LOAD DATA (use either .csv or .rds formats)
Default_data <- read.csv("DefaultDataset.csv")  # or Default_data = readRDS("DefaultDataset.rds")

# Data characteristics
Default_data[1:5,]                   # first five rows

head(Default_data)                   # first five row - alternatively use function head()

dim(Default_data)                    # 1000 rows and 4 cols

names(Default_data)                  # check variable names - "default" "student" "balance" "income" 

summary(Default_data)                # Summary of the data

# ------------------------------------------------------------------------------

# STEP 2: BOXPLOTS/VISUALIZATION

attach(Default_data)

boxplot(balance ~ student, data=Default_data)  # Balance and Default
 
boxplot(income ~ default, data=Default_data)   # Income and Default

# ------------------------------------------------------------------------------

# STEP 3: Fit a NULL Logistic Regression model (only the intercept)

fitNULL <- glm(default ~ NULL, data=Default_data, family=binomial)

summary(fitNULL)

# ------------------------------------------------------------------------------

# STEP 4: Fit a Logistic Regression model with Balance as an input variable

fitBalance <- glm(default ~ balance, data=Default_data, family=binomial)

summary(fitBalance)

# Define the logistic function
logit <- function(x, a, b) {
  1/(1+exp(-(a+b*x)))
}

# Probability of default vs Balance
curve(logit(x, -9.8789851, 0.0070863), xlim=c(min(balance),max(balance)), xlab="Credit card balance", ylab="Prob. of default",las=1)

# ------------------------------------------------------------------------------

# STEP 5: Fit a Logistic Regression model with Student status as an input variable

fitStudent <- glm(default ~ student, data=Default_data, family=binomial)

summary(fitStudent)

# ------------------------------------------------------------------------------

# STEP 6: Fit a Logistic Regression model with ALL input variables

fitALL <- glm(default ~ balance + income + student, data=Default_data, family=binomial)

summary(fitALL)

# ------------------------------------------------------------------------------

# STEP 7: Fit a Logistic Regression model with only the most significant variables

fitFINAL <- glm(default ~. -income, data=Default_data, family=binomial)

summary(fitFINAL)

# ------------------------------------------------------------------------------

# STEP 8: Quantify classification accuracy

install.packages('e1071', dependencies=TRUE)
library(caret)

PredictDefault <- predict(fitFINAL, newdata = as.data.frame(balance + student), type = "response")

BinaryPredictDefault = as.numeric(PredictDefault>=0.5)   # Classify as 'default/no default' for 0.5 threshold

z = table(default, BinaryPredictDefault)                 # Get confusion matrix
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

Accuracy_LR    = (TP+TN)/(TP+TN+FP+FN)
Accuracy_LR

Sensitivity_LR = (TP)/(TP+FN) # IDENTIFY CUSTOMERS WHO DEFAULT
Sensitivity_LR

Specificity_RF = (TN)/(TN+FP) # IDENTIFY CUSTOMERS WHO DO NOT DEFAULT
Specificity_RF

confusionMatrix(as.factor(BinaryPredictDefault),as.factor(default),positive='1')

# -----------------------------------------------------------------------------------------------------------



      