#directorio donde están los set de datos. Lo mismo que ir a Session->Set Working Directory -> Choose Directory
setwd("C:/Dev/Datos/TP/Data")

# lee el csv train y lo asigna a la variable train
train <- read.csv("train2.csv")

# lee el csv test y lo asigna a la variable test
test <- read.csv("test2.csv")

splitdf <- function(dataframe, seed=NULL) {
	if (!is.null(seed)) set.seed(seed)
	index <- 1:nrow(dataframe)
	trainindex <- sample(index, trunc(length(index)/100))
	trainset <- dataframe[trainindex, ]
	testset <- dataframe[-trainindex, ]
	list(trainset=trainset,testset=testset)
}

splits <- splitdf(train, seed=808)

train2 <- splits$trainset

library(randomForest)

train2 <- droplevels(train2)
my_forest <- randomForest(Category ~ PdDistrict + DayOfWeek + Dates + X + Y + Rain  + Tmin + Tmax + Tavrg, data=train2, importance=TRUE, ntree=1000)

my_prediction <- predict(my_forest, test)

# Create a data frame with two columns: PassengerId & Survived. Survived contains your predictions
my_solution <- data.frame(PassengerId = test$PassengerId, Survived = my_prediction)

# Write your solution away to a csv file with the name my_solution.csv
write.csv(my_solution, file = "my_solution.csv", row.names = FALSE)
