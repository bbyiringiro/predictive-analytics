# R Code for Chapter 5 - Variable Selection: Stepwise Selection and Shrinkage Methods
#
# This code generates performs RIDGE REGRESSION and LASSO REGRESSION using Hitters salary data
#
# Dependent categorical variable y - Hitters annual salary (in thousands of dollars)
#
# Independent variables          X - 19 predictors (see class slides for details) 
#
# -------------------- RIDGE REGRESSION and LASSO REGRESSION -------------------

# Install packages
install.packages("ISLR")
install.packages("glmnet")

library(ISLR)
library(glmnet)

# ------------------------------------------------------------------------------
# STEP 1: SET WORKING DIRECTORY - location of your code and data

getwd()

# Go to Tab 'Session', and from the drop down list select 'Set Working Directory'

# ------------------------------------------------------------------------------

# STEP 2: Load Hitters data (Model player's salary as a function of 19 variables)

Hitters = na.omit(Hitters)      # remove any missing data 

p       = ncol(Hitters)-1       # number of predictor (20 columns - 1 label, 19 features)

Hitters[1:5,]                   # first five rows

dim(Hitters)                    # 263 rows and 20 cols

names(Hitters)                  # get variable names

summary(Hitters)                # Summary of the data

attach(Hitters)

# ------------------------------------------------------------------------------

# STEP 2: Split the data into a training (80%) and test sample (20%)

X          = model.matrix(Salary~.-1,data=Hitters)        # Features X
y          = Salary                                       # Label y
n          = nrow(X)                                      # Sample size n

set.seed(3)

RandomIndx = sample(n)                  # Shuffle indexes 
NoTrain    = round(0.8*n)               # No. of training obs.
TrainIndx  = RandomIndx[1:NoTrain]      # Select 80% obs. for training

XTrain     = X[TrainIndx,]              # Training Features X
XTest      = X[-TrainIndx,]             # Test Features X

yTrain     = y[TrainIndx]               # Training Label y 
yTest      = y[-TrainIndx]              # Test Label y

# ------------------------------------------------------------------------------
## ----------------------- PREDICT USING RIDGE REGRESSION ----------------------

# STEP 3: Use cross-validation to find the optimal value of the tuning parameter Lambda

set.seed(101)
RidgeCV.out = cv.glmnet(XTrain, yTrain, alpha = 0)  # Fit ridge regression model on training data
bestlam     = RidgeCV.out$lambda.min                # Select lambda that minimizes training MSE 
log(bestlam)

plot(RidgeCV.out)                                   # Plot of MSE on train data as a function of lambda
coef(RidgeCV.out,s=bestlam)                         # Model coefficients for the best lambda

# Fit a ridge regression model and generate predictions using the optimal value of Lambda
ridge_mod   = glmnet(XTrain, yTrain, alpha = 0)             # Fit ridge regression model using training data

ridge_pred  = predict(ridge_mod, s = bestlam, newx = XTest) # Use best lambda to predict test data

# Evaluate predictions using on the test data
sqrt(mean((ridge_pred - yTest)^2))                 # Calculate test RMSE
mean(abs(ridge_pred - yTest))                      # Calculate test MAE (units $)

n_Test      = nrow(XTest)                          # No. of test obs.

# Plot: Actual and Predicted Salaries using RIDGE REGRESSION
plot(1:n_Test,yTest,type="l",col="blue",xlab="Test Obs. Index",ylab="Salary",lwd=3,main="Ridge regression")
lines(1:n_Test,ridge_pred,col="green",lwd=2)

legend(36, 1500, legend=c("Actual", "Prediction"),
       col=c("blue", "green"),  lwd = 3:2)


# ------------------------------------------------------------------------------
## ----------------------- PREDICT USING LASSO REGRESSION ----------------------

# STEP 4: Use cross-validation to find the optimal value of the tuning parameter Lambda

set.seed(101)
LASSO_CV.out = cv.glmnet(XTrain, yTrain, alpha = 1)   # Fit Lasso regression model on training data
bestlam      = LASSO_CV.out$lambda.min                # Select lambda that minimizes training MSE + 1SE

plot(LASSO_CV.out)                                    # Plot of MSE on the training obs as a function of lambda

coef(LASSO_CV.out,s=bestlam)                          # LASSO Coefficients corresponding to the optimal lambda

# Fit a LASSO regression model and generate predictions using the optimal value of Lambda

Lasso_mod  = glmnet(XTrain, yTrain, alpha = 1)        # Fit Lasso regression model on training data
plot(Lasso_mod, xvar = "lambda", label = TRUE)        # Trace plot
legend("bottomright", lwd = 1, col = 1:6, legend = colnames(X), cex = .7)

Lasso_pred = predict(Lasso_mod, s = bestlam, newx = XTest) # Use best lambda to predict test data

sqrt(mean((Lasso_pred - yTest)^2))                    # Calculate test RMSE
mean(abs(Lasso_pred - yTest))                         # Calculate test MAE

# Plot: Actual and Predicted Salaries using RIDGE REGRESSION
plot(1:n_Test,yTest,type="l",col="blue",xlab="Test Obs. Index",ylab="Salary",lwd=3,main="LASSO")
lines(1:n_Test,Lasso_pred,col="black",lwd=2)

legend(36, 1500, legend=c("Actual", "Prediction"),
       col=c("blue", "black"),  lwd = 3:2)

# ------------------------------------------------------------------------------

