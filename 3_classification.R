## 3 Classification with train/validation split
#
# Here we will split our training data into a training and validation sets and
# compute classification accuracy.
# 

# load the random forest package
library(randomForest)

# load data from csv file
flower_data <- read.csv('data/flower_dataset.csv')

# split the data into validation and test
# randomly choose take 50 datapoints for validation
validation_indices <- sample(1:nrow(flower_data), 50, replace=FALSE)
# use the rest for training
train_indices <- setdiff(seq(1, nrow(flower_data)), validation_indices)

# create the new dataframes
train_data <- flower_data[train_indices,]
validation_data <- flower_data[validation_indices,]
print(paste("Number of training samples: ", nrow(train_data)))
print(paste("Number of validation samples: ", nrow(validation_data)))

# train the classifier
rf <- randomForest(Species ~ ., train_data)

# make predictions for the validation set
species_predictions <- predict(rf, validation_data) 

# compute validation accuracy
correct_classifications <- validation_data$Species == species_predictions

# count the number of correct predictions
number_correct_predictions <- sum(correct_classifications)
number_incorrect_predictions <- length(correct_classifications) - sum(correct_classifications)
print(paste("Number of incorrect predictions: ", number_incorrect_predictions))

# extract the incorrect predictions so we can plot them
incorrect_predictions <- validation_data[correct_classifications==FALSE, ]

# plot full dataset
plot(flower_data$Petal_Length, flower_data$Petal_Width, col=flower_data$Species, pch=16, asp=1)

# draw circles around the training set
points(train_data$Petal_Length, train_data$Petal_Width, pch=1, cex=1.5)

# draw x's where we predict the wrong answer
points(incorrect_predictions$Petal_Length, incorrect_predictions$Petal_Width, pch=4, cex=2, lwd=2, col=4)

# insert legend
legend_text <- c(levels(flower_data$Species), 'train data', 'incorrect predictions')
legend(x='topleft', legend=legend_text, col=c(1, 2, 3, 1, 4), pch=c(16, 16, 16, 1, 4))
