## About the Course

The Predictive Analytics elective course is an extension of the Analytics MBA core course, designed to provide a deeper understanding of commonly used methodologies in the realm of forecasting. This course encompasses various topics:

1. Linear Regression
2. Logistic Regression
3. Clustering Approaches
4. Variable/Feature Selection (using subset selection and shrinkage methods)
5. Tree-Based Learning
6. Artificial Neural Networks
7. Time Series Forecasting

Project: House Price Prediction for Nomad Housing Consultancy and BAM Ltd.

1. Describe the dataset and provide insights into relationships between the variables
provided using descriptive statistics, correlations, and scatter plots. 

2. Build a linear regression model to forecast the median house prices using all the features
provided, as proposed by Nonas (please see next page for a description of the label and
features). Use 80% of the observations for training and the remaining 20% of the
observations for testing. Report the model performance using the test dataset.

3. Using the linear regression model built using all features from the previous step, forecast
the median house prices being either ‘high’ or ‘low’. Report the model performance using
the test dataset. 

4. Propose model/s for: (a) forecasting median house prices, and (b) classifying median
house prices as being either ‘high’ or ‘low’. Provide a comparison of your model/s with
the linear regression model built using all features. Describe your modelling approach.

Data: This data (use ModifiedBostonHousingData.csv or ModifiedBostonHousingData.rds)
contains median house prices for 1000 different neighbourhoods in Boston (in $1000’s).
Specifically, for a given neighbourhood, the house prices are reported as median value of all
owner-occupied houses in that neighbourhood, along with several attributes of the
neighbourhood that could potentially be related with the house prices. The dataset has 1001
rows and 16 columns (first column – observation index, second column – dependent
variable/label, columns 3 to 16 – independent variables/features). First row contains variable
names.
Modified Boston Housing Data (variable names and brief description)


1. CMEDV: median value (in $1000’s) of owner-occupied housing in the neighbourhood
2. CRIM: per capita crime in the neighbourhood
3. ZN: percentage of residential land zoned for lots over 25000 square feet
4. INDUS: percentage of non-retail business acres
5. CHAS: 1 if the neighbourhood borders the Charles River; 0 otherwise
6. NOX: nitric oxides concentration (parts per million), a measure of air quality
7. RM: average numbers of rooms per house in the neighbourhood
8. AGE: percentage of owner-occupied units built before 1940
9. DIS: weighted distances from the neighbourhood to five Boston employment centres
10. RAD: index of accessibility to radial highways
11. TAX: full-value property-tax rate per $10,000
12. PTRATIO: pupil-teacher ratio in local schools
13. PARK: 1 if the neighbourhood has a park; 0 otherwise
14. POOL: 1 if the neighbourhood has a public swimming pool; 0 otherwise
15. CINEMA: 1 if the neighbourhood has a cinema; 0 otherwise



5. Identify the most relevant features (independent variables) in your modelling. Explain
your variable selection strategy. Based on your model, what insights would you provide
to Nomad Housing Consultants and BAM Ltd.? (10 marks)
6. Saria and Nanuel have decided to buy a house together in a neighbourhood that has – per
capita crime of 0.25, no residential land zoned for lots over 25000 square feet, 19.2% of
non-retail business acres, borders with rivers Charles, nitric oxide concentration of 3 parts
per million, an average of 5.9 rooms per house in the area, 18.5% of owner-occupied
units built before 1940, a weighted distance of 3.3 miles to the five Boston employment
centres, an accessibility index of 4 to radial highways, a full-value property-tax rate of
357 per $10,000, a pupil-teacher ratio of 21.0, a park, no public swimming pool, and a
cinema.
Based on your model, advise Saria and Nanuel how much should they expect to pay for
this property? BAM Ltd. have been eyeing this area for making some investments, advise
BAM if the median house price in this neighbourhood is either high or low. 

This is a multidisciplinary course with wide-ranging applications in fields such as marketing, healthcare, operations management, and finance. We aim to equip you with the skills and tools necessary to apply statistical forecasting methodologies, thus enabling you to make informed decisions in the presence of uncertainty.

The course structure includes lectures and practical computer-based sessions. We'll introduce you to the R programming language and utilize it for applying the methodologies introduced during the course.

## Course Outcomes

By the end of this course, you should be able to:

1. Use statistical forecasting methodologies to make informed decisions.
2. Understand commonly used terminologies in predictive analytics.
3. Apply linear and nonlinear statistical methodologies to generate forecasts.
4. Validate the generalizability of forecasting models.
5. Identify key predictors in a model using automated variable selection techniques.
6. Find similar groupings of observations/participants in data.
7. Employ simple visualization techniques and statistics to summarise the data.
8. Quantify the uncertainty in forecasts.
9. Gain an understanding of different approaches used for time series forecasting.
10. Communicate/engage more effectively with data scientists.
