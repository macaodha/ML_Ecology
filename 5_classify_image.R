## 5 Image classification
#
# In this example we will classify the pixels in an image as being 
# either 'land' or 'other'. We will use the pixel intensite values
# features to our classifier. 
# 

# load random forest package for classification 
library(randomForest)

# load image and convert it to a matrix
# here the image is stored in black and white in a csv file 
# 0 represents black and 255 represents white
im <-read.csv('data/uk_ire_gray.csv', header=FALSE)

# convert to matrix and plot size
im_matrix <- as.matrix(im)
print(paste("Height in pixels: ", ncol(im_matrix)))
print(paste("Width in pixels: ", nrow(im_matrix)))
 
# create training data as DataFrame
pixel_values <- c(41, 60, 80, 0, 20, 40, 81, 100, 200)
class_names <- c( 'land', 'land', 'land', 'other', 'other', 'other', 'other', 'other', 'other') 
train_data <- data.frame(pixel_values, class_names)

# train classifer
rf <- randomForest(class_names ~ ., train_data)

# create test data
pixel_values <- as.vector(im_matrix)
test_data <- data.frame(pixel_values)

# perform classification on the whole image
# here we will get the random forest to return a probability 
im_prediction <- predict(rf, test_data, type = 'prob') 
print(head(im_prediction))

# extract the prediction for land - the first class
probability_of_land <- im_prediction[,1]

# convert back to matrix
probability_of_land_matrix <- matrix(probability_of_land, nrow = nrow(im_matrix), ncol = ncol(im_matrix))

# compute the percentage of pixels that are predicted as land
percentage_of_land_cover <- sum(probability_of_land_matrix>0.5) / length(probability_of_land_matrix)
print(paste("Predicted percentage of land pixels: ", 100*percentage_of_land_cover))

# plot the input image
image(im_matrix, col=gray.colors(255))
title('input aerial image')

dev.new()
#image(probability_of_land_matrix, col=gray.colors(255))
image(probability_of_land_matrix > 0.5, col=gray.colors(255))
title('land prediction')



