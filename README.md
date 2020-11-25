# datascienceprojects
Credit card fraud detection: to predict fraudulent credit card transactions with the help of machine learning models. 
•	Checked for the distribution of the data, columns were skewed, applied power transformer to make distribution more gaussian.
•	Built ML models such as Logistic regression, decision tree, random forest and XGboost with imbalanced class and balanced class.
•	The date set was highly imbalanced with only 0.172% of positive class, have used random oversampling, SMOTE and ADASYN to overcome the imbalanced class problem.
•	Applied cross validation and performed hyperparameter tuning to obtain the best performing model.

Telecom churn: analyse customer level data of a leading telecom firm, build predictive models to identify customers at high risk of churn and identify the main indicators of churn.
•	Performed data cleaning and treated missing values using iterative imputer
•	Derived new features and filtered high value customers based on recharge amount more than 70th percentile of the average recharge amount in the first two months.
•	Tagged churners based on the incoming, outgoing calls and data usage.
•	Applied PCA to reduce dimension to 70 variables which explained 95% of the variance in the data.
•	Built multiple ML models to identify the customers who are likely to churn and able to achieve accuracy of more than 85% on the test data with random forest classifier.
•	Built another random forest classifier model without PCA to identify the important feature leading to churn.

GDP: Performed Exploratory Data Analysis techniques to find out areas of development for states based on various factors such as GDP, population, literacy rate etc. The overall goal of this project is to help the CMs focus on areas that will foster economic development for their respective states based on GDP.

Credit EDA: Performed Exploratory Data Analysis on a bank data set to analyse and understand the driving factors (or driver variables) behind loan default, i.e. the variables which are strong indicators of default.

Geely Auto: Built a linear regression model to understand the various factors affecting the pricing of cars in the American market which variables are significant in predicting the price of a car. How well those variables describe the price of a car.

 
•	
Help International: Performed K-means and hierarchical clustering after performing the EDA and applying the PCA concepts on the data to cluster the list of countries so that the NGO(Help International) can provide help for the countries that are in dire need of monetary help.

Lead Score: Built a logistic regression model to assign a lead score between 0 to 100 to each of the leads which can be used by the company to target potential leads.
