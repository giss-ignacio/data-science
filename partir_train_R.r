setwd("C:/Dev/Datos/TP/Data")
train <- read.csv("train.csv")
test <- read.csv("test.csv")

#script para dividir los datos
splitdf <- function(dataframe, seed=NULL) {
	if (!is.null(seed)) set.seed(seed)
	index <- 1:nrow(dataframe)
	trainindex <- sample(index, trunc(length(index)*2/3))
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

# otra forma
# random
set.seed(9850)
gp <- runif(nrow(train))
train <- train[order(gp),]

# seleccion
test <- train[1:20000,]

#normalizar datos, para pasar las coordenadas con knn
normalize <- function(x) {
	return ( (x - min(x)) / (max(x) - min(x)) )
}

train_n <- as.data.frame( lapply( train[, c("X", "Y")], normalize ) )

train_n$Category <- train$Category

splits <- splitdf(train_n, seed=808)
train2 <- splits$trainset
test2 <- splits$testset

require(class)

# seleccion del k, una forma. 938, andara?
sqrt(nrow(train))

train2_target <- train2[,c("Category")]
test2_target <- test2[,c("Category")]

m1 <- knn(train=train2, test=test2, cl=train2_target, k = 938)

# me quedo con X Y y category
drops <- c("Descript", "Resolution", "Dates", "DayOfWeek", "PdDistrict", "Address")
test2 <- test2[,!(names(test2) %in% drops)]

# supuestamente sacar las lineas con NA
train2 <- train2[complete.cases(train2),]
test2 <- test2[complete.cases(test2),]

newtrain2 <- na.omit(train2)
newtest2 <- na.omit(test2)

# saber si hay NA's
testna = is.na(train$Category)
summary(testna)
