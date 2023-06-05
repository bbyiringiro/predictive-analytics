# R Code for Spark Grid Case
#
# --------------------  LINEAR REGRESSION --------------------

# Load library
library(readxl)      # Press control+Enter
library(corrplot)

# ------------------------------------------------------------------------------
# STEP 1: SET WORKING DIRECTORY - location of your code and data

getwd()

# Go to Tab 'Session', and from the dropdown list select 'Set Working Directory'

getwd()


# ------------------------------------------------------------------------------

# STEP 2: LOAD DATA (ELECTRICITY CONSUMPTION)

ElecConsumeData <- read_excel("GBElectricityAndWeatherData.xlsx")

# or
# ElecConsumeData <-  readRDS("GBElectricityAndWeatherData.rds")

head(ElecConsumeData)                            # view first five rows

ElecConsumeData = ElecConsumeData[,2:23];        # ignore months

View(ElecConsumeData)                            # view whole data

dim(ElecConsumeData)                             # 103 rows/obs. and 6 cols.

names(ElecConsumeData)                           # variable names
 
summary(ElecConsumeData)                         # Summary of the data


# ------------------------------------------------------------------------------

# STEP 3: ANALYSIS (SCATTER PLOTS AND CORRELATION)
# FOR INSIGHTS INTO RELATIONSHIPS BETWEEN VARIABLES

pairs(ElecConsumeData[,1:8], pch = 19, lower.panel = NULL)   # Scatter plot (only lower panel)

Corr = cor(ElecConsumeData[,1:8])                            # Correlation table

Corr                                                   # Correlation table

corrplot(Corr,type = "lower")                          # Correlation plot (only lower panel)


# ------------------------------------------------------------------------------

# STEP 4: REGRESSION MODEL 1: LINEAR REGRESSION USING ALL VARIABLES
# IMPLEMENTING SPARK GRID MODEL WITH ALL VARIABLES

attach(as.data.frame(ElecConsumeData))

RegModel1 = lm(Demand ~. - Sun-DemandLag1-DemandLag2-DemandLag3-DemandLag4-DemandLag5
               -DemandLag6-DemandLag7,data = ElecConsumeData)    # REGRESSION MODEL 1 - ELEC VS C76

RegModel1                                                  # REGRESSION MODEL 1 - DETAILS

summary(RegModel1)                                         # REGRESSION MODEL 1 - SUMMARY

PredRegModel1 = predict(RegModel1, ElecConsumeData)  # Predict Demand

n = 1096;
plot(1:n,Demand,type="l",col="blue",xlab="Test Obs. Index",ylab="Salary",lwd=3)
lines(1:n,PredRegModel1,col="green",lwd=2)

legend(800, 50000, legend=c("Actual", "Prediction"),
       col=c("blue", "Green"),  lwd = 3:2)

summary(RegModel1)$r.squared                               # Goodness of fit


# ------------------------------------------------------------------------------

# STEP 5: REGRESSION MODEL 2: INCLUDE DEMAND LAGS 

RegModel2 = lm(Demand ~. - Sun, ElecConsumeData)           # REGRESSION MODEL 1 - ELEC VS C76

RegModel2                                                  # REGRESSION MODEL 1 - DETAILS

summary(RegModel2)                                         # REGRESSION MODEL 1 - SUMMARY

PredRegModel2 = predict(RegModel2, ElecConsumeData)        # Predict Demand

n = 1096;
plot(1:n,Demand,type="l",col="blue",xlab="Time (days)",ylab="Demand",lwd=3)
lines(1:n,PredRegModel2,col="green",lwd=2)

legend(800, 50000, legend=c("Actual", "Prediction"),
       col=c("blue", "Green"),  lwd = 3:2)

summary(RegModel2)$r.squared          

# ------------------------------------------------------------------------------

# STEP 6: REGRESSION MODEL 3: IGNORE NON-SIGNIFICANT VARIABLES

RegModel3 = lm(Demand ~. - Sat - Sun -  DemandLag7- DemandLag5 , ElecConsumeData)           # REGRESSION MODEL 1 - ELEC VS C76

RegModel3                                                  

summary(RegModel3)  

summary(RegModel3)$r.squared

# ------------------------------------------------------------------------------

# STEP 7: REGRESSION MODEL 4: TRY TRANSFORMATIONS

RegModel4 = lm(Demand ~. - Sat - Sun -  DemandLag7- DemandLag5 + I(Temperature^2) , ElecConsumeData)           # REGRESSION MODEL 1 - ELEC VS C76

RegModel4                                                  

summary(RegModel4)  

# ------------------------------------------------------------------------------


