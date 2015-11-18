## 4 Train/validation split

# load the random forest package
library(randomForest)

# load data from csv file
flower_data <- read.csv('flower_dataset.csv')

train_data <- flower_data[seq(1, nrow(flower_data), 2),]
test_data <- flower_data[seq(2, nrow(flower_data), 2),]

print(paste("Number of training samples: ", nrow(train_data)))
print(paste("Number of testing samples: ", nrow(test_data)))

# train the classifier
rf <- randomForest(Species ~ ., train_data)

# make predictions for all the test data
species_predictions <- predict(rf, test_data) 

# print test accuracy

# make a plot with X's where we get it wrong
