# read files from disk
testingData <- read.table(".\\data\\test\\X_test.txt")
trainingData  <- read.table('.\\data\\train\\X_train.txt')

testingSubjects <- read.table(".\\data\\test\\subject_test.txt")
trainingSubjects <- read.table(".\\data\\train\\subject_train.txt")

testingActivity <- read.table(".\\data\\test\\y_test.txt")
trainingActivity <- read.table(".\\data\\train\\y_train.txt")

testingData <- cbind(testingSubjects, testingActivity, testingData)
trainingData <- cbind(trainingSubjects, trainingActivity, trainingData)


# label dataset with descriptive names
features <- read.table(".\\data\\features.txt", stringsAsFactors=F)
newColNames <- c("Subject", "Activity", features[,2])

# merge training and testing data sets
fullSet <- rbind(testingData, trainingData)
colnames(fullSet) <- newColNames

# extract only mean and std measurements
meanAndStdIndecies <- grep("mean|std",newColNames)
dataSubSet <- fullSet[, c(1,2,meanAndStdIndecies)]

# create final tidy data output with averages of each measurement for every subject and activity
tidy <- aggregate(dataSubSet, by=list(dataSubSet$Subject, dataSubSet$Activity), mean)
# aggregate adds extra colums to the front of the dataframe, which are removed with negative indicies below
tidy <- tidy[, c(-1,-2)]

# use descriptive labels for activities
activityLabels <- c('WALKING','WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS','SITTING','STANDING','LAYING')
tidy$Activity <- factor(tidy$Activity, labels=activityLabels)


# write output to file
write.table(tidy, file="output.txt")

# print output to console
print(tidy)
