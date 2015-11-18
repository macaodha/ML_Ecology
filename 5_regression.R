## 5 Nonlinear regression with random forest

# load the random forest package
library(randomForest)

# create a dataset
# here y is some nonlinear function of x 
x <- seq(0, 100, 2.0)
y <- sin(x/10) + (x/50)^2 + rnorm(length(x))*0.1
train_data <- data.frame(x, y)

# fit linear model
lin <- lm(y~., data=train_data)

# fit random forest
rf <- randomForest(y ~ ., train_data)
rf_train_fit <- predict(rf, train_data)

# plot
plot(x, y, col=1)
lines(x, rf_train_fit, type='l', col=2)
abline(lin, col=3)
legend(x=0, y=3.5, legend=c('data', 'RF', 'linear'), col=c(1, 2, 3), pch=1)

# make a prediction
x_test <- data.frame(x=50)

# linear model
# y = slope x + intercept
# lm_prediction <- lin$coefficients[[2]]*test_point+lin$coefficients[[1]]
lm_predicted <- predict(lin, x_test) 

# random forest
rf_predicted <- predict(rf, x_test) 

# plot single predictions
points(x_test[[1]], rf_predicted[[1]], pch=16, col=2, cex=2)
points(x_test[[1]], lm_predicted[[1]], pch=16, col=3, cex=2)


