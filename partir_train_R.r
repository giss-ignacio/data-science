train <- read.csv("train.csv")
test <- read.csv("test.csv")

#script para dividir los datos
splitdf <- function(dataframe, seed=NULL) {
	if (!is.null(seed)) set.seed(seed)
	index <- 1:nrow(dataframe)
	trainindex <- sample(index, trunc(length(index)2/3))
	trainset <- dataframe[trainindex, ]
	testset <- dataframe[-trainindex, ]
	list(trainset=trainset,testset=testset)
}


splits <- splitdf(train, seed=808)

train2 <- splits$trainset
test2 <- splits$testset

# me guardo las respuestas
write.csv(test2, file = "test2.csv", row.names = TRUE)
# tiro los resultados
drops <- c("Category", "Descript", "Resolution")
test2 <- test2[,!(names(test2) %in% drops)]