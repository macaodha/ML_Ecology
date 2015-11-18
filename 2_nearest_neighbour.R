## 2 Nearest neighbour classifier

# load data from csv file
flower_data <- read.csv('flower_dataset.csv')

# plot dataset
plot(flower_data$Petal_Length, flower_data$Petal_Width, col = flower_data$Species, pch=16, asp=1)
legend(x='topleft', legend = levels(flower_data$Species), col = c(1:3), pch = 16)

# create new test point
#test_point <- c(3.1, 1.23)
#test_point <- c(6.4, 2.2)
#test_point <- c(4.96, 1.5)
#test_point <- c(2.0, 0.5)
#test_point <- c(6.4, 2.2)
#test_point <- c(4.3, 1.8)

# random point
test_point <- runif(2, 0,1)
test_point[1] <- min(flower_data[,1]) + test_point[1]*(max(flower_data[,1]) - min(flower_data[,1]))
test_point[2] <- min(flower_data[,2]) + test_point[2]*(max(flower_data[,2]) - min(flower_data[,2]))

# print test point values
print(paste("Test Petal_Length: ", test_point[1]))
print(paste("Test Petal_Width: ", test_point[2]))

# plot the test point as an X
points(test_point[1], test_point[2], pch=4, cex=2)

# compute the distance from the test point to every example in the dataset
distance <- apply(flower_data[,1:2],1,function(x)sqrt(sum((x-test_point)^2)))

# find the point in the dataset that is closest to the test point and record its distance
closest_point = which.min(distance)
distance_to_closest = min(distance)
print(paste("Distance to closest point: ", distance_to_closest))

# assume the test point is the same class as the datapoint it is closest too
predicted_species <- flower_data[closest_point, ]$Species
print(paste("Predicted species: ", predicted_species))

# plot a ring around the nearest datapoint
points(flower_data[closest_point, 1], flower_data[closest_point, 2], pch=1, cex=1.5)

