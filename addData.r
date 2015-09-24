write.csv(train2, file = "train2.csv", row.names = TRUE)

# se queda solo con fecha sin la hora
train3$Dates <- strptime(train3$Dates,"%Y-%m-%d")


# pasa a formato dia fecha hora de R
#train$Time <- strptime(train$Dates,"%Y-%m-%d %H:%M:%S")


#train$Time <- format(train$Time,"%H:%M:%S")

# en resumen
train$Time <- strptime(train$Dates,"%Y-%m-%d %H:%M:%S")
train$Date <- format(train$Time,"%Y-%m-%d")
train$Time <- format(train$Time,"%H")

#------------------------------------
install.packages("lubridate")
require(lubridate)
train$Dates<-ymd_hms(train$Dates);test$Dates<-ymd_hms(test$Dates)

train$hour<-hour(train$Dates); test$hour<-hour(test$Dates)
train$year<-year(train$Dates); test$year<-year(test$Dates)
train$month<-month(train$Dates); test$month<-month(test$Dates)
#---------------------------------------------

write.csv(train3, file = "train2.csv", row.names = FALSE, quote=FALSE)
train3 <- na.omit(train2)

#-----------------------------
# merge facil
weather$Rain[weather$Precipitation == "0.00"] <- 0
weather$Rain[weather$Precipitation != "0.00"] <- 1
test <- read.csv("test.csv")
test$Fecha <- strptime(test$Dates,"%Y-%m-%d")
test2 <- merge(x = test, y = weather, by = "Fecha", all = TRUE)
test2 <- na.omit(test2)
test2$Fecha <- NULL

