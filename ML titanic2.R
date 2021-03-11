train <- read.csv("train.csv")

library(ggplot2)
library(dplyr)
library(caTools)

#Imputing the Age variable
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

#Changing factor variables into factor
train$Survived <- as.factor(train$Survived)
train$Pclass <- as.factor(train$Pclass)
train$Parch <- as.factor(train$Parch)
train$SibSp <- as.factor(train$SibSp)
train$Sex <- as.factor(train$Sex)
train$Embarked <- as.factor(train$Embarked)

#Splitting the data
set.seed(101)
sample <- sample.split(train$Survived, SplitRatio = 0.7)
test <- filter(train, !sample)
train <- filter(train, sample)

#Creating a logistic model to predict Survived
model <- glm(Survived ~ ., family = binomial(link = "logit"), data = train)
summary(model)

test$Parch[test$Parch == 6] <- 5
prediction <- 1 / (1 + exp(-1 * predict(model, test)))

#Changing the values of prediction into 0s and 1s
prediction.binary <- c()
for (i in 1:268) {
  if (prediction[i] < 0.5) {
    prediction.binary <- append(prediction.binary,0)
  }
  if (prediction[i] > 0.5){
    prediction.binary <- append(prediction.binary,1)
  }
}
rm(i)

#Result
result <- select(test, Survived)
result$Prediction <- prediction.binary

tp = sum(result$Survived == 1 & result$Prediction == 1)
fp = sum(result$Survived == 0 & result$Prediction == 1)
tn = sum(result$Survived == 0 & result$Prediction == 0)
fn = sum(result$Survived == 1 & result$Prediction == 0)

#Creating a confusion matrix
confusion.matrix <- matrix(nrow = 2, ncol = 2)
colnames(confusion.matrix) <- c("Predicted Die", "Predicted Survive")
rownames(confusion.matrix) <- c("Actual Die", "Actual Survive")

confusion.matrix[1,1] <- tn
confusion.matrix[1,2] <- fp
confusion.matrix[2,1] <- fn
confusion.matrix[2,2] <- tp

correct <- tp +tn
false <- fp + fn

correct/sum(tn, tp, fp, fn)
false/sum(tn, tp, fp, fn)

"Our model is right 80% of the time. It's quiet good i think."