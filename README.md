Determinants of Employee Wages

The main business problem being addressed in this code involves understanding the determinants of employee wages and how various factors (such as years of education, work experience, age, union membership, gender, race, and occupation) influence wage levels. This information can be critical for companies, HR departments, and policymakers to make informed decisions about salary structures, diversity and inclusion policies, and workforce planning.

Key Objectives:

Analyze Correlations: Assess the relationships between continuous variables like wage, years of education, experience, and age to identify any significant correlations that might influence wage levels.

Regression Analysis: Build and evaluate multiple linear regression models to determine the impact of various factors on wages.

Multicollinearity Check: Ensure the independence of predictor variables by calculating Variance Inflation Factors (VIF) to detect multicollinearity issues.

Model Refinement: Iterate on different regression models by including or excluding variables (e.g., dropping experience or age) to improve model performance and interpretability.

Categorical Variables: Incorporate and analyze the effect of categorical variables like union membership, gender, race, and occupation on wages.

Outlier Detection and Handling: Identify and exclude outliers that might distort the regression results to create a more robust model.

Model Assumptions Validation: Validate key regression assumptions such as linearity, normality, and homoscedasticity (equal variance of residuals) to ensure the reliability of the regression models.



Detailed Steps in the Code:

Data Preparation: Import and clean the data, ensuring that all variable names are in a consistent format.

Correlation Analysis: Use correlation plots and matrices to visualize and quantify the relationships between continuous variables.

Initial Regression Model: Build an initial regression model with continuous variables and validate its assumptions using diagnostic plots.

Extended Models: Extend the regression model by including binary (union membership) and categorical (gender, race, occupation) variables.

Multicollinearity Check: Calculate VIFs to detect and address multicollinearity among predictor variables.

Outlier Handling: Identify and remove outliers and high leverage points that can unduly influence the regression results.

Final Model Evaluation: Rebuild the regression model after removing outliers and high leverage points and evaluate its performance and assumptions.

Conclusion:
The business problem revolves around understanding and modeling the determinants of wages using statistical analysis. The goal is to derive actionable insights that can help in setting fair and equitable wage policies, identifying areas for improvement in pay equity, and informing strategic HR decisions. The extensive use of regression analysis and diagnostic checks ensures that the models built are robust, reliable, and provide meaningful insights into the factors affecting wages.

![image](https://github.com/sruthisubraveti/Employee-Wages/assets/172334062/9a75ec0a-8273-4292-813c-bf1e06cfd1a8)
![image](https://github.com/sruthisubraveti/Employee-Wages/assets/172334062/ae5e54b4-4dde-4551-a134-d0a2c5c7f390)
![image](https://github.com/sruthisubraveti/Employee-Wages/assets/172334062/b37721df-322a-43ff-8490-48f65dada17f)




 
 
 


