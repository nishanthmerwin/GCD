## Loads the col names into R
features <- read.table("C:/Users/Nishanth/Documents/Coursera/ass2/features.txt")
feature <- features[,2]

## Training variables
train <- read.table("C:/Users/Nishanth/Documents/Coursera/ass2/train/X_train.txt",col.names=(feature),colClasses="numeric")
train_index <- read.table("C:/Users/Nishanth/Documents/Coursera/ass2/train/subject_train.txt",colClasses="numeric")
train_lab <- read.table("C:/Users/Nishanth/Documents/Coursera/ass2/train/y_train.txt",colClasses="numeric")
## Adds the index
train$index <- as.numeric(unlist(train_index))
train$label <- as.numeric(unlist(train_lab))

## Test variables
test <- read.table("C:/Users/Nishanth/Documents/Coursera/ass2/test/X_test.txt",col.names=(feature),colClasses="numeric")
test_index <- read.table("C:/Users/Nishanth/Documents/Coursera/ass2/test/subject_test.txt",colClasses="numeric")
test_lab <- read.table("C:/Users/Nishanth/Documents/Coursera/ass2/test/y_test.txt",colClasses="numeric")
## Adds the index
test$index <- as.numeric(unlist(test_index))
test$label <- as.numeric(unlist(test_lab))

## Merges the data sets
row.names(test) <- as.integer(seq(1,2947,by=1))
row.names(train) <- as.integer(seq(2948,10299,by=1))
data <- rbind(train,test)

## Using the pattern matching, I created a vector where only the mean and std of each variable was recorded.
logic <- (grepl("mean()",feature,fixed=T)) | (grepl("std",feature,fixed=T))
logic[562:563] <- c(T,T)
data_s <- data[,logic]

## Renaming the labels with the actual names of the activity
labels <- as.character((read.table("C:/Users/Nishanth/Documents/Coursera/ass2/activity_labels.txt"))[,2])
data_s$label <- factor(data_s$label,labels=labels)


## Creating the new data set
library(dplyr)
data_tidy <- data_s %>%
    tbl_df %>%
        select(index,label,1:68)

write.table(data_tidy, file = "tidy.txt",row.names=F)