#Load Model:

model <- readRDS("LinearReg_Model.RDS")

#Batch Prediction
nov_data <- data.frame(
  id = 1:3,
  hp = c(200, 150, 188),
  wt = c(2.5, 1.9, 3.2)
)

nov_prediction = predict(model, newdata = nov_data)

# create a new dataset with prediction
nov_data$pred <- nov_prediction
write.csv(nov_data, "resultNov.csv", row.names = FALSE)