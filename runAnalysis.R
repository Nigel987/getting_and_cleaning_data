library(dplyr)

# 1. Merges the training and the test sets to create one data set.

data_test <- read.table('data/UCI HAR Dataset/test/X_test.txt')

data_train <- read.table('data/UCI HAR Dataset/train/X_train.txt')

data <- rbind(data_test, data_train)

remove(data_test,data_train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

header <- read.table('data/UCI HAR Dataset/features.txt') 

stds <- data[,grepl('-std()',header[,2], fixed = TRUE),2]

means <- data[,grepl('-mean()',header[,2], fixed = TRUE),2]

data_reduced <- cbind(stds,means)

remove(stds,means,header)

# 3. Uses descriptive activity names to name the activities in the data set

activity_description <- read.table('data/UCI HAR Dataset/activity_labels.txt') 

test_activities <- read.table('data/UCI HAR Dataset/test/y_test.txt') 

train_activities <- read.table('data/UCI HAR Dataset/train/y_train.txt') 

activities <- rbind(test_activities,train_activities)

activities[activities == 1] <- as.character(activity_description[1,2])
activities[activities == 2] <- as.character(activity_description[2,2])
activities[activities == 3] <- as.character(activity_description[3,2])
activities[activities == 4] <- as.character(activity_description[4,2])
activities[activities == 5] <- as.character(activity_description[5,2])
activities[activities == 6] <- as.character(activity_description[6,2])

data_with_activities <- cbind(activities,data_reduced)

remove(activities, train_activities, test_activities, activity_description)

# 4 .Appropriately labels the data set with descriptive variable names. 

header <- read.table('data/UCI HAR Dataset/features.txt') 

stds <- grep('-std()',header[,2], fixed = TRUE)

means <- grep('-mean()',header[,2], fixed = TRUE)

places <- sort(as.vector(rbind(stds,means)))

labels <- c('Activities',as.character(header[places,2]))

names(data_with_activities) <- labels

remove(stds,means,labels,places,header)

# 5.From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

test_subjects <- read.table('data/UCI HAR Dataset/test/subject_test.txt') 

train_subjects <- read.table('data/UCI HAR Dataset/train/subject_train.txt') 

subjects <- rbind(test_subjects,train_subjects)

names(subjects) <- 'Subjects'

data_with_subjects <- cbind(subjects,data_with_activities)

final_data <- data_with_subjects %>% 
                group_by(Subjects,Activities) %>% 
                  summarise_each(funs(mean))

remove(subjects,train_subjects,test_subjects)

# Prepare final data set
write.table(final_data, file = 'final_data.txt', row.names=FALSE)