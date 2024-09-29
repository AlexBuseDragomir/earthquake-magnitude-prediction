#########################################################################
#                            LOAD LIBRARIES
#########################################################################
library(mlbench)
library(e1071)
library(lattice)
library(corrplot)
library(caret)
library(klaR)

#########################################################################
#                             LOAD DATASET                             
#########################################################################

# save the location of the dataset file
filename <- "D:\\Facultate\\MachineLearning\\earthquakes.csv"

# save the dataset under an alias
dataset <- read.csv(filename, stringsAsFactors = FALSE, encoding = "UTF-8", sep = ",", header = T)

# print first 20 records from the dataset
head(dataset, n = 20)

# shuffle the dataset once for randomness 
dataset <- dataset[sample(nrow(dataset)),]

#########################################################################
#                         DATASET INFORMATIONS
#########################################################################

# print first 20 records from the actual form
head(dataset, n = 20)

# get the number of rows and columns of the dataset
dim(dataset)

# get the types of the attributes of the data
sapply(dataset, class)

# get the summary for data in the dataset
summary(dataset)

# get the frequency for the magnitudes
x <- dataset[,'Magnitude']
cbind(freq = table(x), percentage = prop.table(table(x))*100)

# get the frequency for the magnitudes (with precision of 1)
x <- dataset[,'Magnitude']
x <- floor(x)
cbind(freq = table(x), percentage = prop.table(table(x))*100)

# get the frequency for the depths (with precision of 10 units)
x <- dataset[,'Depth']
x <- (x %/% 10) * 10
x <- floor(x)
cbind(freq = table(floor(x)), percentage = prop.table(table(x))*100)

# get the standard deviation
sapply(dataset[,1:7], sd)

# calculate skewness for each variable
# 1 apply for rows
# 2 apply for columns
# c(1, 2) for rows & columns
skew <- apply(dataset[,1:7], 2, skewness)
print(skew)

#calculate the correlations between columns
correlations <- cor(dataset[,1:7])
# display the correlation matrix
print(correlations)

##########################################################################
#                         DATA VISUALIZATION
##########################################################################

# histogram of data
# useful in order to get an indication of the 
# distribution of an attribute
hist(dataset[,1], main = names(dataset)[1])
hist(dataset[,2], main = names(dataset)[2])
hist(dataset[,3], main = names(dataset)[3])
hist(dataset[,4], main = names(dataset)[4])
hist(dataset[,5], main = names(dataset)[5])
hist(dataset[,6], main = names(dataset)[6])
hist(dataset[,7], main = names(dataset)[7])

# using a densisty plot 
# a more abstract depiction of the distribution
plot(density(dataset[,1]), main=names(dataset)[1])
plot(density(dataset[,2]), main=names(dataset)[2])
plot(density(dataset[,3]), main=names(dataset)[3])
plot(density(dataset[,4]), main=names(dataset)[4])
plot(density(dataset[,5]), main=names(dataset)[5])
plot(density(dataset[,6]), main=names(dataset)[6])
plot(density(dataset[,7]), main=names(dataset)[7])

# calculate correlations between the attributes
# get an idea regarding the attributes that change together
correlations <- cor(dataset[,1:7])
# create correlation plot
corrplot(correlations, method="circle")

# scatter plot matrix
# for all pairs of attributes
pairs(dataset)

# density plot by class 
# for latitude, longitude and depth
x <- dataset[,1:6]
# for the predicted attribute, magnitude
y <- dataset[,7]
# create the density plot
scales <- list(x = list(relation="free"), y = list(relation="free"))
featurePlot(x=x, y=y, plot="pairs", scales=scales)

##########################################################################
#                        LINEAR ALGORITHMS
##########################################################################

# linerar regression
# train with cross validation
trainControl <- trainControl(method="cv", number=5)
fit.lm <- train(Magnitude~., data=dataset, method="lm", metric="RMSE",trControl=trainControl)
# summarize fit
print(fit.lm)

# linerar regression
# repeated k-fold cross-validation
trainControl <- trainControl(method="repeatedcv", number=10, repeats=5)
fit.lm <- train(Magnitude~., data=dataset, method="lm", metric="RMSE",trControl=trainControl)
# summarize fit
print(fit.lm)

###########################################################################

# regularized regression
# train with cross validation
trainControl <- trainControl(method="cv", number=5)
fit.glmnet <- train(Magnitude~., data=dataset, method="glmnet", metric="RMSE",trControl=trainControl)
# summarize fit
print(fit.glmnet)

# regularized regression
# train with cross validation
trainControl <- trainControl(method="LOOCV", number=5)
fit.glmnet <- train(Magnitude~., data=dataset, method="glmnet", metric="RMSE",trControl=trainControl)
# summarize fit
print(fit.glmnet)

# regularized regression
# train with bootstrap with 100 resamples
trainControl <- trainControl(method="boot", number=100)
fit.glmnet <- train(Magnitude~., data=dataset, method="glmnet", metric="RMSE",trControl=trainControl)
# summarize fit
print(fit.glmnet)

# regularized regression
# train with cross validation
# center and scale the data before applying algorithm
# so with data normalization
trainControl <- trainControl(method="cv", number=5)
fit.glmnet <- train(Magnitude~., data=dataset, method="glmnet", metric="RMSE", preProcess=c("center", "scale"), trControl=trainControl)
# summarize fit
print(fit.glmnet)

#########################################################################
#                      NON - LINEAR ALGORITHMS
#########################################################################


# k-nearest neighbors algorithm
# train with cross validation
set.seed(7)
trainControl <- trainControl(method="cv", number=10)
fit.knn <- train(Magnitude~., data=dataset, method="knn", metric="RMSE", trControl=trainControl)
# summarize fit
print(fit.knn)

# k-nearest neighbors algorithm
# train with repeated cross validation
set.seed(7)
trainControl <- trainControl(method="cv", number=10)
fit.knn <- train(Magnitude~., data=dataset, method="knn", metric="RMSE", trControl=trainControl)
# summarize fit
print(fit.knn)

# k-nearest neighbors algorithm
# with preprocess: center and scale
# so with data normalization
repeated k-fold cross-validation
set.seed(7)
trainControl <- trainControl(method="repeatedcv", number=5, repeats=10)
fit.knn <- train(Magnitude~., data=dataset, method="knn", metric="RMSE",
preProcess=c("center", "scale"), trControl=trainControl)
# summarize fit
print(fit.knn)

#########################################################################

# support vector machine
# repeated cross validation
# liniar
set.seed(7)
trainControl <- trainControl(method="repeatedcv", number=5, repeats=10)
fit.svmLinear <- train(Magnitude~., data=dataset, method="svmLinear", metric="RMSE", trControl=trainControl)
# summarize fit
print(fit.svmLinear)

# support vector machine
# repeated cross validation
# polynomial
set.seed(7)
trainControl <- trainControl(method="repeatedcv", number=5, repeats=10)
fit.svmPoly <- train(Magnitude~., data=dataset, method="svmPoly", metric="RMSE", trControl=trainControl)
# summarize fit
print(fit.svmPoly)

# support vector machine
# repeated cross validation
# radial
set.seed(7)
trainControl <- trainControl(method="repeatedcv", number=5, repeats=10)
fit.svmRadial <- train(Magnitude~., data=dataset, method="svmRadial", metric="RMSE", trControl=trainControl)
# summarize fit
print(fit.svmRadial)

# support vector machine
# leave one out cross validation
# radial
set.seed(7)
trainControl <- trainControl(method="LOOCV")
fit.svmRadial <- train(Magnitude~., data=dataset, method="svmRadial", metric="RMSE", trControl=trainControl)
# summarize fit
print(fit.svmRadial)

##########################################################################

# regression tree
# cross validation with 5 sets 
set.seed(7)
trainControl <- trainControl(method="cv", number=5)
fit.rpart <- train(Magnitude~., data=dataset, method="rpart", metric="RMSE",
trControl=trainControl)
# summarize fit
print(fit.rpart)

# regression tree
# bootstrap with 1000 values 
set.seed(7)
trainControl <- trainControl(method="boot", number=1000)
fit.rpart <- train(Magnitude~., data=dataset, method="rpart", metric="RMSE",
trControl=trainControl)
# summarize fit
print(fit.rpart)

# regression tree
# cross validation with 10 sets
set.seed(7)
trainControl <- trainControl(method="cv", number=10)
fit.rpart <- train(Magnitude~., data=dataset, method="rpart", metric="RMSE",
trControl=trainControl)
# summarize fit
print(fit.rpart)

# regression tree
# repeated cross validation with 5 sets and 10 repeats
set.seed(7)
trainControl <- trainControl(method="repeatedcv", number=5, repeats=10)
fit.rpart <- train(Magnitude~., data=dataset, method="rpart", metric="RMSE",
trControl=trainControl)
# summarize fit
print(fit.rpart)

# regression tree
# repeated cross validation with 5 sets and 10 repeats
# preprocess with center and scale -> normalization
set.seed(7)
trainControl <- trainControl(method="repeatedcv", number=5, repeats=10)
fit.rpart <- train(Magnitude~., data=dataset, method="rpart", metric="RMSE",
preProcess=c("center", "scale"), trControl=trainControl)
# summarize fit
print(fit.rpart)

###########################################################################
#                          COMPARE ALGORITHMS
###########################################################################

# support vector machine
# repeated cross validation
# radial
set.seed(7)
trainControl <- trainControl(method="repeatedcv", number=5, repeats=10)
fit.svmRadial <- train(Magnitude~., data=dataset, method="svmRadial", metric="RMSE", trControl=trainControl)

# regression tree
# repeated cross validation with 5 sets and 10 repeats
set.seed(7)
trainControl <- trainControl(method="repeatedcv", number=5, repeats=10)
fit.rpart <- train(Magnitude~., data=dataset, method="rpart", metric="RMSE",
trControl=trainControl)

# save the results of the two algorithms
results <- resamples(list(SVM_RADIAL=fit.svmRadial, REG_TREE=fit.rpart))

# get the summary for the results
summary(results)

# density plots for comparation
scales <- list(x=list(relation="free"), y=list(relation="free"))
densityplot(results, scales=scales, pch = "|")

# dot plots for comparation
scales <- list(x=list(relation="free"), y=list(relation="free"))
dotplot(results, scales=scales)

# box and whisker plots to compare models
scales <- list(x=list(relation="free"), y=list(relation="free"))
bwplot(results, scales=scales)

############################ SAVE THE MODELS ###############################

# train the model
# and give it a name
# in this case, we have the support vector machine (radial)
set.seed(7)
trainControl <- trainControl(method="repeatedcv", number=5, repeats=10)
finalModelSvm <- train(Magnitude~., data=dataset, method="svmRadial", metric="RMSE", trControl=trainControl)

# save the model to disk
saveRDS(finalModelSvm, "finalModelSvm.rds")

# train the model
# and give it a name
# in this case, we have the regression tree
set.seed(7)
trainControl <- trainControl(method="repeatedcv", number=5, repeats=10)
finalModelRTree <- train(Magnitude~., data=dataset, method="rpart", metric="RMSE", trControl=trainControl)

# save the model to disk
saveRDS(finalModelRTree, "finalModelRTree.rds")