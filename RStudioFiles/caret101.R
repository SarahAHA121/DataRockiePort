library(caret)

#Statistic lm()
model01 <- lm(mpg ~ hp + wt, data = mtcars)
model01


#caret train()
model02 <- train(mpg ~ hp + wt,
      data = mtcars,
      method = "lm") # ML algorithm

model02$finalModel

# ML basic pipeline

# 1. prepare / split data

set.seed(42)
# n <- nrow(mtcars)
# id <- sample(1:n, size= n*0.8)
# train_data <- mtcars[id, ]
# test_data <- mtcars[-id, ]
split_data <- train_test_split(mtcars)
train_data <- split_data[[1]]
test_data <- split_data[[2]]

# 2. train model
# cv = K-Fold Cross Validation
set.seed(42)
ctrl <- trainControl(method = "repeatedcv",
                     number = 5,
                     repeats = 5,
                     verboseIter = TRUE)

(model <- train(mpg ~ hp+wt
               ,data = train_data
               ,method = "lm"
               ,trControl = ctrl))

# 3. score model / prediction
p_mpg <- predict(model, newdata = test_data)


# 4. evaluate model
error <- p_mpg - test_data$mpg
(test_rmse <- sqrt(mean(error**2)))

# 5. save model (batch prediction)
saveRDS(model, "LinearReg_Model.RDS")

nov_data <- data.frame(
  id = 1:3,
  hp = c(200, 150, 188),
  wt = c(2.5, 1.9, 3.2)
)
(nov_prediction = predict(model, newdata = nov_data))
