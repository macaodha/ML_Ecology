## 4 Nonlinear regression
#
# Here we will compare a linear and nonlinear regressor (random forest) on a
# one dimensional regression task.
# 

# load the random forest package
library(randomForest)

# create a dataset
# here y_ideal is a nonlinear function of x 
x <- seq(0, 100, 2.0)
y_ideal <- sin(x/10) + (x/50)^2

# add some noise to our target variable y_ideal
y <- y_ideal + rnorm(length(y_ideal))*0.1

# fit linear model
lin <- lm(y ~ x)
lin_train_fit <- predict(lin, data.frame(x))

# fit random forest
rf <- randomForest(y ~ x, ntree=20)
rf_train_fit <- predict(rf, data.frame(x))

# plot the fitted linear model and random forest
plot(x, y, col=1)
lines(x, lin_train_fit, type='l', col='red')
lines(x, rf_train_fit, type='l', col='blue')

# add legend
legend_text <- c('training data', 'linear regression', 'random forest')
legend(x='topleft', legend=legend_text, col=c('black', 'red', 'blue'), pch=1)

# generate a random test point (sample between the min and max of x)
rand_point <- runif(1, min(x), max(x))
x_test <- data.frame(x=rand_point)

# linear model
# y = slope*x + intercept
# lm_prediction <- lin$coefficients[[2]]*test_point+lin$coefficients[[1]]
lm_predicted <- predict(lin, x_test) 

# random forest
rf_predicted <- predict(rf, x_test) 

# plot single predictions
points(x_test[[1]], lm_predicted[[1]], pch=16, col='red', cex=2)
points(x_test[[1]], rf_predicted[[1]], pch=16, col='blue', cex=2)
