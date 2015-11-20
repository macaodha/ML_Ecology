## 5 Pixel classification
#
# In this example we will classify the pixels in an image as being either 'land'
# or 'other'. We will use the pixel values as features to our classifier.
# 
# Have a look at the image data/uk_ire_gray.png to see what we are working with.
#

# load random forest package for classification 
library(randomForest)

# load the grayscale image we wish to classify from the csv file
# 0 represents black and 255 represents white
im <-read.csv('data/uk_ire_gray.csv', header=FALSE)
print(paste("Height in pixels: ", ncol(im)))
print(paste("Width in pixels: ", nrow(im)))
 
# create training data as DataFrame
# here we have picked some pixel locations that we know to be land and not land
train_pixels <- c(im[110,47], im[186,173],im[13,192], im[148,119], im[92,173], im[15,30])
class_names <- c('land', 'land', 'other', 'other', 'other', 'other') 
train_data <- data.frame(pixel_values=train_pixels, class_names)

# train classifer
rf <- randomForest(class_names ~ ., train_data)

# create test data - need to convert our datframe to a vector
test_pixels <- aa <- as.vector(unlist(im))
test_data <- data.frame(pixel_values=test_pixels)

# perform classification on the whole image
# here we will get the random forest to return a probability 
im_prediction <- predict(rf, test_data, type='prob') 
print(head(im_prediction))

# extract the prediction for land - the porbability of the first class
prob_land <- im_prediction[,1]

# convert data to a matrix so we can display it
prob_land_matrix <- matrix(prob_land, nrow=nrow(im), ncol=ncol(im))

# plot the input image and result side by side
par(mfrow=c(1,2))
image(as.matrix(im), col=gray.colors(255))
title('input aerial image')

image(prob_land_matrix > 0.5, col=gray.colors(255))
title('land prediction')

# compute the percentage of pixels that are predicted as land
percent_land_cover <- sum(prob_land_matrix>0.5) / length(prob_land_matrix)
print(paste("Predicted percentage of land pixels: ", 100*percent_land_cover))
