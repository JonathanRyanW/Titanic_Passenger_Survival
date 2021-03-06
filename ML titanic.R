train <- read.csv("train.csv")
test <- read.csv("test.csv")

library(ggplot2)
library(dplyr)

#Checking for NAs
sapply(train, function(x){any(is.na(x))}) #Only the Age var has NA
sum(is.na(train$Age)) #177 data dari 891 (19.8%)

#Changing all the NAs to the mean age of the corresponding class
mean(filter(train, Pclass == 1)$Age, na.rm = TRUE) #38.23344
mean(filter(train, Pclass == 2)$Age, na.rm = TRUE) #29.87763
mean(filter(train, Pclass == 3)$Age, na.rm = TRUE) #25.14062

Age <- c()
for (i in 1:891) {
  if (is.na(train$Age[i])) {
    if (train$Pclass[i] == 1) {
      Age <- c(Age, 38.23344)
    }else if (train$Pclass[i] == 2) {
      Age <- c(Age, 29.87763)
    }else {
      Age <- c(Age, 25.14062)
    }
  }else {
    Age <- c(Age, train$Age[i])
  }
}

train$Age <- Age
rm(Age, i)

#Selecting the variables that we can actually use
train <- select(train, -c("PassengerId", "Name", "Ticket", "Cabin"))

#Building a linear model
model <- lm(Survived ~ . , train)
summary(model)

"Even after using all the variables we only get Adjusted R-squared: 0.3939.
It seems that linear model is definitely not the choice here."

#Changing factor variables into factor
train$Survived <- as.factor(train$Survived)
train$Pclass <- as.factor(train$Pclass)
train$Parch <- as.factor(train$Parch)
train$SibSp <- as.factor(train$SibSp)
train$Sex <- as.factor(train$Sex)
train$Embarked <- as.factor(train$Embarked)

#Creating a logistic model to predict Survived
model <- glm(Survived ~ ., family = binomial(link = "logit"), data = train)
summary(model)

"Based on the summary, we can see that age, class, and sex does affects the
probability of survival. Other variables that also affects Survived is SibSp.
It seems that if you have 3 or 4 siblings then you are less likely to survive."

#Changing the variable types in test data
test$Pclass <- as.factor(test$Pclass)
test$Parch <- as.factor(test$Parch)
test$SibSp <- as.factor(test$SibSp)
test$Sex <- as.factor(test$Sex)
test$Embarked <- as.factor(test$Embarked)

"The test data has more factors in the Parch variable than the train data.
We are simply gonna change it into the nearest factor that we know in the
train data."
test$Parch[test$Parch == 9] <- 6

prediction <- predict(model, test)

"We can use the test data to make predictions. However we can't use it to
evaluate our model because the test data does not have the Survived column.
We are gonna do the process all over again, this time we will split the train
data into train and test data."

