library(ggplot2)
library(caret)
library(e1071)
#enable parallel computing
library(doParallel)
registerDoParallel(cores=2)
#load training set
setwd("~/Documents/Coursera/Machine Learning")
dataT<-read.csv("pml-training.csv")
# remove unnecessary data
dataT<-dataT[,-grep("avg",names(dataT))]
dataT<-dataT[,-grep("var",names(dataT))]
dataT<-dataT[,-grep("stddev",names(dataT))]
dataT<-dataT[,-grep("amplitude",names(dataT))]
dataT<-dataT[,-grep("min",names(dataT))]
dataT<-dataT[,-grep("max",names(dataT))]
dataT<-dataT[,-grep("kurtosis",names(dataT))]
dataT<-dataT[,-grep("skewness",names(dataT))]
dataT<-dataT[,-grep("times",names(dataT))]
dataT<-dataT[,-grep("window",names(dataT))]
dataT<-dataT[,-grep("user_name",names(dataT))]
dataT<-dataT[,-grep("X",names(dataT))]

set.seed(666)

inTrain<-createDataPartition(y=dataT$classe,p=0.6,list=FALSE)
training<-dataT[inTrain,]
testing<-dataT[-inTrain,]
modFit<-train(classe~.,data=training,method="parRF",ntree=25,prox=TRUE)
#crossvalidate  test on testing set
Crossvalidate <- predict(modFit, testing)
confusionMatrix(testing$classe, Crossvalidate)$overall
#out of sample error estimation = 1-Accuracy     
# predict on test data set
dataS<-read.csv("pml-testing.csv")
dataS<-dataS[,-grep("avg",names(dataS))]
dataS<-dataS[,-grep("var",names(dataS))]
dataS<-dataS[,-grep("stddev",names(dataS))]
dataS<-dataS[,-grep("amplitude",names(dataS))]
dataS<-dataS[,-grep("min",names(dataS))]
dataS<-dataS[,-grep("max",names(dataS))]
dataS<-dataS[,-grep("kurtosis",names(dataS))]
dataS<-dataS[,-grep("skewness",names(dataS))]
dataS<-dataS[,-grep("times",names(dataS))]
dataS<-dataS[,-grep("window",names(dataS))]
dataS<-dataS[,-grep("user_name",names(dataS))]
dataS<-dataS[,-grep("X",names(dataS))]

Result<- predict(modFit, dataS)
Result
