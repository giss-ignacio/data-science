library(rpart)
# separa fecha
train$Date <- as.Date(train$Dates)

# pasa a formato dia fecha hora de R
train$Time <- strptime(train$Dates,"%Y-%m-%d %H:%M:%S")
# se queda con la hora
train$Time <- format(train$Time,"%H")

fit <- rpart(Category ~ PdDistrict + DayOfWeek+ Time, data=train, method="class", control=rpart.control(minsplit=2, cp=0))

Prediction <- predict(fit, test, type = "class")
submit <- data.frame(Id = test$Id,Category= Prediction)
my_table <- table(submit)
write.csv(my_table,file = "mytree.csv", row.names = FALSE)

#-----------------------------------------------------------

library(rpart)
require(dplyr);require(lubridate);require(reshape2);require(readr)

# add date info
train$Dates<-ymd_hms(train$Dates);test$Dates<-ymd_hms(test$Dates)
train$hour<-hour(train$Dates); test$hour<-hour(test$Dates)
train$year<-year(train$Dates); test$year<-year(test$Dates)
train$month<-month(train$Dates); test$month<-month(test$Dates)

fit <- rpart(Category ~ PdDistrict + DayOfWeek, data=train, method="anova", control=rpart.control(minsplit=40, cp=0))

Prediction <- predict(fit, test,type="class")
submit <- data.frame(Id = test$Id,Category= Prediction)
my_table <- table(submit)
write.csv(my_table,file = "mytree.csv", row.names = FALSE)

#------------------------------------------------------------------



library(rpart)
require(dplyr);require(lubridate);require(reshape2);require(readr)
mycontrol=rpart.control(cp = 0.001,minsplit=100)
fittree <- rpart(Category ~ PdDistrict + DayOfWeek+hour+month+X+Y, data=train, 

method="class", control=mycontrol)
Prediccion= predict(fittree,test,type="prob")
submit <- data.frame(Id = test$Id,Prediccion)
write.csv(submit,file = "unotree.csv", row.names = FALSE)