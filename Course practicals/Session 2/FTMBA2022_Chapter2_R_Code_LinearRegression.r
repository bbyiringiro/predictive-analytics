# R Code for Class 2 - Introduction to Predictive Analytics
#
# This code builds a linear regression model using the Electricity data
#
# --------------------  LINEAR REGRESSION --------------------

# Text written after hash is ignored by R (seen as a comment)

# Load library

install.packages("readxl")     # Press control+Enter
install.packages("corrplot")

library(readxl)      
library(corrplot)

# ------------------------------------------------------------------------------
# STEP 1: SET WORKING DIRECTORY - location of your code and data

getwd()

# OPTION 1: Go to Tab 'Session', and from the drop down list select 'Set Working Directory'

getwd()  # Check if this gives you the exact same path as your data and code folder

# OPTION 2: For Windows - CHANGE PATH in LINE 27 FOR YOUR Windows LAPTOP
setwd("E:/Predictive Analytics - 2023/Chapter 2 - Introduction to R/UseInClass May 23")

# OPTION 2: For MAC - CHANGE PATH in LINE 30 FOR YOUR MAC
# setwd("~sarora/Predictive Analytics") 


# ------------------------------------------------------------------------------

# STEP 2: LOAD DATA (ELECTRICITY CONSUMPTION)

ElecConsumeData <- read_excel("ElectricityConsumptionForR.xlsx")

head(ElecConsumeData)                           # view first five rows

ElecConsumeData = ElecConsumeData[,2:7]         # ignore months

View(ElecConsumeData)                           # view whole data

dim(ElecConsumeData)                            # 103 rows/obs. and 6 cols.

names(ElecConsumeData)                          # variable names


# ------------------------------------------------------------------------------

# STEP 3: ANALYSIS (SCATTER PLOTS, CORRELATION AND SUMMARY STATS)

pairs(ElecConsumeData)                                 # Scatter plot

pairs(ElecConsumeData, pch = 19, lower.panel = NULL)   # Scatter plot (only lower panel)

Corr = cor(ElecConsumeData)                            # Correlation table

Corr                                                   # Correlation table

corrplot(Corr,type = "lower")                          # Correlation plot (only lower panel)

summary(ElecConsumeData)                               # Summary of the data

# ------------------------------------------------------------------------------

# STEP 4: ESTIMATE MODEL PARAMETERS (SIMPLE LINEAR REGRESSION)

RegModel1 = lm(ElecConsumeData$ELEC ~ ElecConsumeData$C76) # REGRESSION MODEL 1 - ELEC VS C76

attach(as.data.frame(ElecConsumeData))

RegModel1 = lm(ELEC ~ C76) # REGRESSION MODEL 1 - ELEC VS C76

RegModel1                                                  # REGRESSION MODEL 1 - DETAILS

summary(RegModel1)                                         # REGRESSION MODEL 1 - SUMMARY

plot(C76, ELEC)                                            # Scatter plot - C76 vs Elec (Actual data)

plot(C76,ELEC,xlab="C76", ylab="Elec")                     # Scatterplot - C76 vs Elec (Actual data)

plot(C76,ELEC,xlab="C76", ylab="Elec", pch=19)             # Scatterplot - C76 vs Elec (Actual data)

plot(C76,ELEC,xlab="C76", ylab="Elec", pch=19, col="blue") # Scatterplot - C76 vs Elec (Actual data)

abline(RegModel1)                                          # Line of best fit

abline(RegModel1,lwd=3)                                    # Line of best fit

summary(RegModel1)$r.squared                               # Goodness of fit

help(plot)                                                 # Help for plot function

help(pch)                                                  # Help for plot characters

# ------------------------------------------------------------------------------

# STEP 5: RESIDUAL ANALYSIS

par(mfrow=c(2,2))

plot(residuals(RegModel1),ylab="Residuals",xlab="Months")    # RESIDUALS

plot(C76, residuals(RegModel1),xlab="C76", ylab="Residuals") # RESIDUALS VS C76

hist(residuals(RegModel1),main=NULL)                         # RESIDUAL HISTOGRAM

# ------------------------------------------------------------------------------

# STEP 6: PREDICTION

RegModel1 = lm(ELEC ~ C76)                                 # REGRESSION MODEL 1 - ELEC VS C76

summary(RegModel1)

predict(RegModel1, data.frame(C76 = c(1000)))              # Predict Elec for C76 = 1000 (point est.)

predict(RegModel1, data.frame(C76 = c(900, 1000, 1100)))   # Predict Elec for C76 = 900, 1000, 1100 (point est.)

predict(RegModel1, data.frame(C76 = c(900, 1000, 1100)),interval="prediction")   # Predict Elec for C76 = 900, 1000, 1100 (interval)


PredRegModel1 = predict(RegModel1, ElecConsumeData)        # Predict ELEC

n = 103;
plot(1:n,ELEC,type="l",col="blue",xlab="Month indx",ylab="Elec",lwd=3)
lines(1:n,PredRegModel1,col="green",lwd=2)

legend(80, 1500, legend=c("Actual", "Prediction"),
       col=c("blue", "green"),  lwd = 3:2)

summary(RegModel1)$r.squared                               # Goodness of fit


# -------------------- MULTIPLE LINEAR REGRESSION --------------------

# STEP 7: ESTIMATE MODEL PARAMETERS (MULTIPLE LINEAR REGRESSION)

# REGRESSION MODEL 2 - ELEC VS C66, C76, H55, DINC, AIRC

RegModel2 = lm(ELEC ~ C66 + C76 + H55 + DINC + AIRC) 

# or 
# RegModel2 = lm(ELEC ~., data = ElecConsumeData) 

RegModel2                                                      # REGRESSION MODEL 2 - DETAILS

summary(RegModel2)                                             # REGRESSION MODEL 2 - SUMMARY

# REGRESSION MODEL 3 - ELEC VS C66, C76, H55, DINC (REMOVE AIRC)

RegModel3 = lm(ELEC ~ C66 + C76 + H55 + DINC) 

# or 
# RegModel3 = lm(ELEC ~. -AIRC, data = ElecConsumeData)                                              # REGRESSION MODEL 3 - DETAILS

summary(RegModel3)                                             # REGRESSION MODEL 3 - SUMMARY

par(mfrow=c(2,3))                                              # Plot with 6 panels - 2 rows and 3 cols

plot(residuals(RegModel3),ylab="Residuals",xlab="Months")      # RESIDUALS for REGRESSION MODEL 3
hist(residuals(RegModel3),main=NULL)                           # RESIDUAL HISTOGRAM

plot(C66, residuals(RegModel3),xlab="C66", ylab="Residuals")   # RESIDUALS VS C66
plot(C76, residuals(RegModel3),xlab="C76", ylab="Residuals")   # RESIDUALS VS C76
plot(H55, residuals(RegModel3),xlab="H55", ylab="Residuals")   # RESIDUALS VS C66
plot(DINC, residuals(RegModel3),xlab="DINC", ylab="Residuals") # RESIDUALS VS C76

# Predict using RegModel3: ELEC ~ C66 + C76 + H55 + DINC
PredRegModel3 = predict(RegModel3, ElecConsumeData)        # Predict ELEC

n = 103;
plot(1:n,ELEC,type="l",col="blue",xlab="Month indx",ylab="Elec",lwd=3)
lines(1:n,PredRegModel3,col="green",lwd=2)

legend(80, 1500, legend=c("Actual", "Prediction"),
       col=c("blue", "green"),  lwd = 3:2)

summary(RegModel3)$r.squared  

# REGRESSION MODEL 4 - ELEC VS C66, C76, H55, DINC (TRYING NONLINEAR TRANSFORMATION)

RegModel4 = lm(ELEC ~ C66 + C76 + I(C76^2) + H55 + DINC) 

RegModel4                                                      # REGRESSION MODEL 4 - DETAILS

summary(RegModel4)                                             # REGRESSION MODEL 4 - SUMMARY

# ------------------------------------------------------------------------------


