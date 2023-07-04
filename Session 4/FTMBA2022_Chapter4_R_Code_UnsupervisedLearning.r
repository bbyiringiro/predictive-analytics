# R Code for Chapter 4 - Unsupervised Learning: k-means and Hierarchical Clustering 
#
# This code performs clustering using: k-Means and Hierarchical Clustering
#
# Dataset - Supermarket mall
#
# Data Attributes - CustomerID, Gender, Age, Annual Income(k$), Spending Score(1-100)
#
# --------------------  CLUSTERING USING SUPERMARKET MALL DATA -----------------

# Install packages
install.packages("readxl")    # data manipulation and visualization
install.packages("FNN")       # provides easy pipeline modeling functions
install.packages("broom")     # helps to tidy up model outputs

library("readxl")
library("FNN")
library("broom") 

## -----------------------------------------------------------------------------

# STEP 1: SET WORKING DIRECTORY AND LOAD SUPERMARKET DATA 

getwd()                    

# Go to Tab 'Session', and from the drop down list select 'Set Working Directory'

# Load the data file and look at the data summary 

CustomerData <- read_excel("MallCustomerData.xlsx")   # Load data

summary(CustomerData)                                 # Summary of the data

head(CustomerData)                                    # first few rows

names(CustomerData)                                   # get variable names 

attach(CustomerData)

# Alternate way to load data (using rds file): 
# CustomerData = readRDS("MallCustomerData.rds")

# Data attributes: (1) CustomerID, (2) Gender, (3) Age, (4) Annual Income(k$), (5) Spending Score(1-100)

## -----------------------------------------------------------------------------

# STEP 2: Cluster customers based on 2 attributes - INCOME AND SPENDING

CustomerIncomeSpending      = CustomerData[,4:5];
km1.out                     = kmeans(CustomerIncomeSpending, 5, nstart = 15) # say k = 5 clusters

print(km1.out)

plot(CustomerIncomeSpending, col = km1.out$cluster, pch=19)                  # plot clusters

## -----------------------------------------------------------------------------

# STEP 3: Cluster customers based on 2 attributes - AGE AND SPENDING
CustomerAgeSpending      = CustomerData[,c(3,5)];
km2.out                  = kmeans(CustomerAgeSpending, 5, nstart=15)         # say k = 5 clusters

print(km2.out)

plot(CustomerAgeSpending,col=km2.out$cluster, pch=19)                        # plot clusters

## -----------------------------------------------------------------------------

# STEP 4: Cluster customers based on ALL Attributes
km3.out                  = kmeans(CustomerData, 5, nstart=15)                # say k = 5 clusters

print(km3.out, data = CustomerData) 

plot(CustomerIncomeSpending,col=km3.out$cluster, pch=19)                     # plot clusters

## -----------------------------------------------------------------------------

# STEP 5: Perform Hierarchical Clustering using ALL Attributes

# Create a dendrogram using complete linkage 
hc.complete = hclust(dist(CustomerData),method="complete")
plot(hc.complete)

# Create a dendrogram using single linkage 
hc.single = hclust(dist(CustomerData),method="single")
plot(hc.single)

# Create a dendrogram using average linkage 
hc.average = hclust(dist(CustomerData),method="average")
plot(hc.average)

## -----------------------------------------------------------------------------


