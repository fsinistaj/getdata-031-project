run_analysis <- function () {
        #Read in files containing dataset lables
        activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
        features <- read.table("./UCI HAR Dataset/features.txt")
        
        # Read in test data set files
        subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
        x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
        y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
        
        # Read in training data set files
        subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
        x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
        y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
        
        # Creating a vector of measurement label names
        features <- features[,2]
        
        # Add column names to activity and subject datasets 
        names(subject_test) <- "subject.id"
        names(y_test) <- "activity.id"
        names(activities) <- c("activity.id", "activity.name")
        names(subject_train) <- "subject.id"
        names(y_train) <- "activity.id"
        
        # Create single dataframe for test dataset combining subjects, measurements, and variable names
        testdf <- x_test
        names(testdf) <- features
        testdf <- cbind(subject_test, y_test, testdf)
        
        # Create single dataframe for training dataset combining subjects, measurements, and variable names
        traindf <- x_train
        names(traindf) <- features
        traindf <- cbind(subject_train, y_train, traindf)
        
        # Bind both test and training data into single dataframe
        df.full <- rbind(testdf, traindf)
        
        # Extracting columns that contain the mean and standard deviation values of all measurements
        df.full <- df.full[!duplicated(names(df.full))]
        df.extract <- select(df.full, subject.id, activity.id, matches("(mean|std)\\(\\)"))
        
        ## Tidy up final data frame
        
        # Merge activity names to data set and remove activity id 
        df.extract <- merge(activities, df.extract)
        df.extract <- select(df.extract, -activity.id)
        
        # Reorder dataframe columns so subject.id and activity.name are the leftmost columns
        df.extract <- select(df.extract, 2, 1, 3:68)
        
        # Tidy up variable names
        cleanNames <- names(df.extract)
        cleanNames <- sub("f", "Frequency", cleanNames)
        cleanNames <- sub("Mag", "Magnitude", cleanNames)
        cleanNames <- sub("Acc", "Acceleration", cleanNames)
        cleanNames <- sub("tB", "TimeB", cleanNames)
        cleanNames <- sub("tG", "TimeG", cleanNames)
        cleanNames <- sub("mean\\(\\)", "Mean", cleanNames)
        cleanNames <- sub("std\\(\\)", "StandardDeviation", cleanNames)
        cleanNames <- sub("X", "X.Axis", cleanNames)
        cleanNames <- sub("Y", "Y.Axis", cleanNames)
        cleanNames <- sub("Z", "Z.Axis", cleanNames)
        cleanNames <- sub("BodyBody", "Body", cleanNames)
        
        # Apply tidy variable names back to dataframe
        names(df.extract) <- cleanNames
        
        df.extract

}
