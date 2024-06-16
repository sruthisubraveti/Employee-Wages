rm(list=ls())

# Read in data.

wages=rio::import("6304 Module 6 Data Sets.xlsx",
                  which="Wages Fixed Data")
colnames(wages)=tolower(make.names(colnames(wages)))
attach(wages)
str(wages)

# Copy the continuous variables to a new data object.

some.of.wages=subset(wages,select=c("wage","yearsed",
                                    "experience","age"))

# Correlation analysis of the continuous variables.

plot(some.of.wages,pch=19,
     main="Some of Everything with Some of Everything")
cor(some.of.wages)
round(cor(some.of.wages),3)

# Presenting correlation graphically.
# First put a correlation matrix into an object.

library(corrplot)
gilligan=cor(some.of.wages)
gilligan
corrplot(gilligan,method="circle")
corrplot(gilligan,method="pie")
corrplot(gilligan,method="ellipse")
corrplot(gilligan,method="color")
corrplot(gilligan,method="number")
corrplot(gilligan,method="square")
corrplot(gilligan,method="circle",type="upper")
corrplot(gilligan,method="circle",type="lower")

# Correlation matrix with p values.

maryann=Hmisc::rcorr(as.matrix(some.of.wages)) #hmisc is the package & rcorr is command
maryann #assumption that there's a hypothesis test.
#hypothesis will be in the population, the corr between wages & years. 

# Conducting a Regression -- Continuous Variables Only

wage1.out=lm(wage~.,data=some.of.wages)
summary(wage1.out)

# Assumptions of Regression
par(mfrow=c(2,2))
# Linearity
plot(some.of.wages$wage,wage1.out$fitted.values,
     pch=19,main="Actuals v. Fitteds, Wages")
abline(0,1,col="red",lwd=3)
# Normality
qqnorm(wage1.out$residuals,pch=19,
       main="Normality Plot, Wages")
qqline(wage1.out$residuals,lwd=3,col="red")
hist(wage1.out$residuals,col="red",
     main="Residuals, Wages",
     probability=TRUE)
curve(dnorm(x,mean(wage1.out$residuals),
            sd(wage1.out$residuals)),
      from=min(wage1.out$residuals),
      to=max(wage1.out$residuals),
      lwd=3,col="blue",add=TRUE)
# Equality of Variances
plot(wage1.out$fitted.values,rstandard(wage1.out),
     pch=19,main="Equality of Variances, Wages")
abline(0,0,lwd=3,col="red")
par(mfrow=c(1,1))

# Exploring binary variables.
# Using the Union variable -- two levels.

wage2.out=lm(wage~yearsed+experience+age+union,data=wages)
summary(wage2.out)

# Adding gender to the model.

wage3.out=lm(wage~yearsed+experience+age+union+gender,
             data=wages)
summary(wage3.out)

# Adding race to the model -- three levels.

wage4.out=lm(wage~yearsed+experience+age+union+gender+race,
             data=wages)
summary(wage4.out)

# OR
wages.relevel=wages
wages.relevel$race=as.factor(wages.relevel$race)
wages.relevel$race=relevel(wages.relevel$race,"White")
wage4a.out=lm(wage~yearsed+experience+age+union+
                gender+race,
              data=wages.relevel)
summary(wage4a.out)

# OR
wages$race=as.factor(wages$race)
wages4b.out=lm(wage~yearsed+experience+age+union+gender
               +relevel(race,"White"),data = wages)
summary(wages4b.out)

# Cleanup
rm(list = c("wage4a.out","wages4b.out",
            "wages.relevel"))

# All Variables -- the "kitchen sink" model.
# More properly called the "full regression model".

fullwage.out=lm(wage~.-id,data=wages)
summary(fullwage.out)

# Just for now, Back to only continuous variables.

summary(wage1.out)

# Variance Inflation Factors (VIF)
# Measure of Multicollinearity – 
# correlation of independents.
# How much the variance of a beta coefficient is 
# being inflated by multicollinearity.

# Evidence of Multicollinearity.
plot(some.of.wages,pch=19,
     main="Continuous Variables")
gilligan=cor(some.of.wages)
corrplot(gilligan,method="number")
corrplot(gilligan,method="ellipse")

library(car)
vif(wage1.out)

# Let's look at the kitchen sink model.

summary(fullwage.out)
vif(fullwage.out)

# Dump Experience, Keep Age.
# This is the "reduced regression model".

noexp.out=lm(wage~.-id-experience,data=wages)
summary(noexp.out)
vif(noexp.out)

#Dump Age, Keep Experience
noage.out=lm(wage~.-id-age,data=wages)
summary(noage.out)
vif(noage.out)

# Arbitrary choice.
# We're dropping age.
# Model with Experience and other 
# continuous variables, Union and Gender
summary(noage.out)

# Bringing in Occupation
wage5.out=lm(wage~yearsed+experience+union+
               gender+occupation,data=wages)
summary(wage5.out)
vif(wage5.out)

# Only two levels of Occupation 
# seem to have a contribution.
# Now we collapse Occupation to "Professional & Management" 
# and "Other"

wages$pm=NA
for(i in 1:length(wages$occupation)){
  if(wages$occupation[i]=="Management"|
     wages$occupation[i]=="Professional"){
    wages$pm[i]="ProfMgt"}
  else{
    wages$pm[i]="Other"
  }
}

# And conduct a regression with the new variable.
wage6.out=lm(wage~yearsed+experience+union+gender+pm,
             data=wages)
summary(wage6.out)
vif(wage6.out)


# Let's separate out Professional and Management.
for(i in 1:length(wages$occupation)){
  wages$pm[i]="Other"
  if(wages$occupation[i]=="Management"){
    wages$pm[i]="Management"}
  if (wages$occupation[i]=="Professional"){
    wages$pm[i]="Professional"
  }
}

# And re-run the regression.
wage7.out=lm(wage~yearsed+experience+union+gender+pm,
             data=wages)
summary(wage7.out)

# OOPS!  Let's relevel that pm variable.
wages$pm=as.factor(wages$pm)
wages$pm=relevel(wages$pm,ref="Other")
# And go again.
wage8.out=lm(wage~yearsed+experience+union+gender+pm,
             data=wages)
summary(wage8.out)

# And evaluate the assumptions of regression.
par(mfrow=c(2,2))
# Linearity
plot(wages$wage,wage8.out$fitted.values,
     pch=19,main="Actuals v. Fitteds, Wages")
abline(0,1,col="red",lwd=3)
# Normality
qqnorm(wage8.out$residuals,pch=19,
       main="Normality Plot, Wages")
qqline(wage8.out$residuals,lwd=3,col="red")
hist(wage8.out$residuals,col="red",
     main="Residuals, Wages",
     probability=TRUE)
curve(dnorm(x,mean(wage8.out$residuals),
            sd(wage8.out$residuals)),
      from=min(wage8.out$residuals),
      to=max(wage8.out$residuals),
      lwd=3,col="blue",add=TRUE)
# Equality of Variances
plot(wage8.out$fitted.values,rstandard(wage8.out),
     pch=19,main="Equality of Variances, Wages")
abline(0,0,lwd=3,col="red")
par(mfrow=c(1,1))

# We have an outlier.  Can we get rid of it?  
# We have to find it first.

boxplot(wages$wage,col="red",ylim=c(0,50),pch=19,
        main="Boxplot of Wages")
max(wages$wage)

# This statement finds the data frame row 
# that has the max value.
which(wages$wage==44.5)
wages[171,]

# Or combine the statements.
wages[which(wages$wage==44.5),]

# Or
wages[which.max(wages$wage),]

# Now we create a new data frame that's a copy 
# except we exclude the outlier.

# reduced.wages=wages[-171, ]

# Or...
# reduced.wages=wages[-which(wages$wage==44.5),]

# Or
reduced.wages=wages[-which.max(wages$wage),]

boxplot(reduced.wages$wage,col="red",ylim=c(0,50),pch=19)

# And rerun the regression
# using the reduced data set.
wage9.out=lm(wage~yearsed+experience+union+gender+pm,
             data=reduced.wages)
summary(wage9.out)

# And evaluate the assumptions of regression.
par(mfrow=c(2,2))
# Linearity
plot(reduced.wages$wage,wage9.out$fitted.values,
     pch=19,main="Actuals v. Fitteds, Reduced Wages")
abline(0,1,col="red",lwd=3)
# Normality
qqnorm(wage9.out$residuals,pch=19,
       main="Normality Plot, Reduced Wages")
qqline(wage9.out$residuals,lwd=3,col="red")
hist(wage9.out$residuals,col="red",
     main="Residuals, Reduced Wages",
     probability=TRUE)
curve(dnorm(x,mean(wage9.out$residuals),
            sd(wage9.out$residuals)),
      from=min(wage9.out$residuals),
      to=max(wage9.out$residuals),
      lwd=3,col="blue",add=TRUE)
# Equality of Variances
plot(wage9.out$fitted.values,rstandard(wage9.out),
     pch=19,main="Equality of Variances, Wages")
abline(0,0,lwd=3,col="red")
par(mfrow=c(1,1))

#Leverage of Points

leverages=hat(model.matrix(wage9.out))
plot(leverages,pch=19)
abline(3*mean(leverages),0,col="red",lwd=3)
reduced.wages[leverages>(3*mean(leverages)),]
reduced.wages[leverages>(3*mean(leverages)),1]

#So let's get rid of the high leverage data points.
no.leverage=reduced.wages
gilligan=reduced.wages[leverages>(3*mean(leverages)),1]
no.leverage=no.leverage[-gilligan,]

# OR

no.leverage=reduced.wages
no.leverage=
  no.leverage[-(reduced.wages[
    leverages>(3*mean(leverages)),1]),]

# And re-run the regression.
wage10.out=lm(wage~yearsed+experience+union+gender+pm,
              data=no.leverage)
summary(wage10.out)

#And look again at the assumptions
par(mfrow=c(2,2))
# Linearity
plot(no.leverage$wage,wage10.out$fitted.values,
     pch=19,main="Actuals v. Fitteds, No Leverage")
abline(0,1,col="red",lwd=3)
# Normality
qqnorm(wage10.out$residuals,pch=19,
       main="Normality Plot, No Leverage")
qqline(wage10.out$residuals,lwd=3,col="red")
hist(wage10.out$residuals,col="red",
     main="Residuals, No Leverage",
     probability=TRUE)
curve(dnorm(x,mean(wage10.out$residuals),
            sd(wage10.out$residuals)),
      from=min(wage10.out$residuals),
      to=max(wage10.out$residuals),
      lwd=3,col="blue",add=TRUE)
# Equality of Variances
plot(wage10.out$fitted.values,rstandard(wage10.out),
     pch=19,main="Equality of Variances, No Leverage")
abline(0,0,lwd=3,col="red")
par(mfrow=c(1,1))

# And the Leverages
leverages=hat(model.matrix(wage10.out))
plot(leverages,pch=19)
abline(3*mean(leverages),0,col="red",lwd=3)
reduced.wages[leverages>(3*mean(leverages)),1]
reduced.wages[leverages>(3*mean(leverages)),1]

