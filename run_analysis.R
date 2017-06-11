# Set working directory
setwd("C:/Users/william.kemp/Desktop/Data Science - John Hopkins/3. Getting & Cleaning Data/Peer Review Exercise/UCI HAR Dataset")

# Load feature names and convert to a character vector
labelsdata <- read.table("features.txt")
labels <- c(as.character(labelsdata[,2]),"Activity")

# Load Activity labels and convert to a character vector
activity <- read.table("activity_labels.txt")
activity$V2 <- as.character(activity$V2)

# Load training data and combine using cbind 
setwd("C:/Users/william.kemp/Desktop/Data Science - John Hopkins/3. Getting & Cleaning Data/Peer Review Exercise/UCI HAR Dataset/train")
Xtrain <- read.table("X_train.txt")
Ytrain<- read.table("Y_train.txt")
TrainData <- cbind(Xtrain,Ytrain)

# Load test data and combine usin cbind
setwd("C:/Users/william.kemp/Desktop/Data Science - John Hopkins/3. Getting & Cleaning Data/Peer Review Exercise/UCI HAR Dataset/test")
Xtest <- read.table("X_test.txt")
Ytest <- read.table("Y_test.txt")
TestData <- cbind(Xtest,Ytest)

# Merger the training and test datasets using rbind
merged <- rbind(TrainData,TestData)
merged$V561
names(merged) <- labels


# Rename Activity labels to text
for (i in 1:nrow(activity)){
  merged$Activity[merged$Activity == activity$V1[i]] <- activity$V2[i]
}

# Filter for the columns containing the mean and standard deviation
output <- merged[,grepl("mean",colnames(merged))]
finaldata <- cbind(output[,!grepl("Freq",colnames(output))],merged[,grepl("std",colnames(merged))],merged[,562])
names(finaldata)[67]<- "Activity"

#save merged data
write.csv(finaldata,"Cleaned Dataset.csv")

# Create new data set that is mean of each variable
# Rename Activity column of data
newdata <- aggregate(finaldata[,1:66],by= list(finaldata$Activity),FUN = mean)

names(newdata) <- paste("Mean of",names(newdata))
names(newdata)[1] <- "Activity"

#save new dataset
write.csv(newdata,"Dataset Aggregated by Mean.csv")

rm(list=ls())
