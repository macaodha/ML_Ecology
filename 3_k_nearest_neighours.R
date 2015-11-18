## 3 K Nearest Neighbours
#
# Instead of comparing to the nearest neighbour, we instead compare the
# test point to several nearest neighbours.
# 



# #### TODO check this works properly



# load data from csv file
flower_data <- read.csv('flower_dataset.csv')

# plot dataset
plot(flower_data$Petal_Length, flower_data$Petal_Width, col = flower_data$Species, pch=16, asp=1)
legend(x='topleft', legend = levels(flower_data$Species), col = c(1:3), pch = 16)

# create a test point
test_point <- c(3.1, 1.23)

# random point
test_point <- runif(2, 0,1)
test_point[1] <- min(flower_data[,1]) + test_point[1]*(max(flower_data[,1]) - min(flower_data[,1]))
test_point[2] <- min(flower_data[,2]) + test_point[2]*(max(flower_data[,2]) - min(flower_data[,2]))

# plot the test point as an X
points(test_point[1], test_point[2], pch=4, cex=2)

# the number of nearest neighbours to look at i.e. K
num_nearest_neighbours = 3

# compute the distance from the test point to every example in the dataset
distance <- apply(flower_data[,1:2],1,function(x)sqrt(sum((x-test_point)^2)))

# find the K nearest neighours
closest_points <- which(distance %in% sort(distance)[1:num_nearest_neighbours])
closest_species <- flower_data[closest_points,3]

# find which species is voted for the most
predicted_species_index <- which.max(table(closest_species))
predicted_species <- names(table(closest_species))[predicted_species_index]

print(paste("Predicted species: ", predicted_species))

