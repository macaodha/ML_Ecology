## 1 Plotting
#
# Here we will load in some data and plot it
#

# load data from csv file
butterflies <- read.csv('data/butterflies.csv')

# column names
print(names(butterflies))

# number of rows
print(paste("Number of datapoints: ", nrow(butterflies)))

# first few examples
print(head(butterflies))

# plot the first two dimensions (ie columns)
plot(butterflies$Width, butterflies$Height)

# plot the Species type in color
# pch is the format of the plotted points - here filled circles
# asp is used to make sure that the axis are in the same units
# col sets the colours based on the Species type
plot(butterflies$Width, butterflies$Height, col=butterflies$Species, pch=16, asp=1)

# add legend 
legend(x='topleft', legend=levels(butterflies$Species), col=c(1, 2, 3), pch=16)
