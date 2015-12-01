## 3 Classification with train/validation split
#
# Here we will split our training data into a training and validation sets and
# compute classification accuracy.
#

# load the random forest package
library(randomForest)

# load data from csv file
butterflies <- read.csv('data/butterflies.csv')

# plot the dataset
plot(butterflies$Width, butterflies$Height, col=butterflies$Species, pch=16, asp=1)

# split the data into validation and test
# randomly choose take 50 datapoints for validation
validation_indices <- sample(1:nrow(butterflies), 50, replace=FALSE)
# use the rest for training
train_indices <- setdiff(seq(1, nrow(butterflies)), validation_indices)

# create the new dataframes
train_data <- butterflies[train_indices,]
validation_data <- butterflies[validation_indices,]
print(paste("Number of training samples: ", nrow(train_data)))
print(paste("Number of validation samples: ", nrow(validation_data)))

# draw circles around the training set
points(train_data$Width, train_data$Height, pch=1, cex=1.5)

# train the classifier
rf <- randomForest(Species ~ ., train_data, ntree=20)

# make predictions for the validation set
species_predictions <- predict(rf, validation_data)

# count the number of correct predictions on the validation set
correct_classifications <- validation_data$Species == species_predictions
number_correct_predictions <- sum(correct_classifications)
number_incorrect_predictions <- length(correct_classifications) - sum(correct_classifications)
print(paste("Number of incorrect predictions: ", number_incorrect_predictions))

# extract the incorrect predictions so we can plot them
incorrect_predictions <- validation_data[correct_classifications==FALSE, ]

# draw an 'x' where we predict the wrong answer
points(incorrect_predictions$Width, incorrect_predictions$Height, pch=4, cex=2, lwd=2, col=4)

# insert legend
legend_text <- c(levels(butterflies$Species), 'train data', 'incorrect predictions')
legend(x='topleft', legend=legend_text, col=c(1, 2, 3, 1, 4), pch=c(16, 16, 16, 1, 4))
