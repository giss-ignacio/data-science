#directorio donde están los set de datos. Lo mismo que ir a Session->Set Working Directory -> Choose Directory
setwd("C:/Dev/Datos/TP/Data")

# lee el csv train y lo asigna a la variable train
train <- read.csv("train.csv")

# lee el csv test y lo asigna a la variable test
test <- read.csv("test.csv")

# ------------------------------
# obtener información con R. 
# Finger #1 
# de lo que subieron al fb
# --------------------------------

# 1)	¿Cuales son los 10 (diez) delitos más comunes en la ciudad de San Francisco?
# Mira la columna Category ($Category)
# sumariza o extrae y suma todas las apariciones de cada "categoría de delito" (Category)
# orden decreciente
# selecciona las primeras 10, "[1:10]"

sort(summary(train$Category),decreasing = TRUE)[1:10]

# 2)	En qué día de la semana hay más casos de “Driving under the influence”
# a la variable duti le asigna un subconjunto de todas las entradas que SOLO tienen la Category: "DRIVING UNDER THE INFLUENCE"
# van a ser muchas menos filas
# después suma todas las veces que aparece cada día, "summary(duti$Day)"
# en la misma línea ordena decrecientemente y pide el primer valor , "[1]"

duti <- subset(train,train$Category == "DRIVING UNDER THE INFLUENCE")
sort(summary(duti$Day),decreasing= TRUE)[1]

# 3)	¿Cuáles son los tres distritos con mayor cantidad de crímenes
# suma todas las veces que aparece cada distrito, "PdDistrict", ordena, saca los 3 primeros

sort(summary(train$PdDistrict),decreasing= TRUE)[1:3]

# 4)	¿Cuáles son los crímenes que tienen mayor porcentaje de resolución “Not Prosecuted” 
# forma del fb, a la variable npro le asigna un subconjunto de todas las entradas que SOLO tienen Resolution: "NOT PROSECUTED"
# van a ser menos filas
# lo sumariza, lo ordena y lo asigna a la variable nproSum
npro <- subset(train,train$Resolution=="NOT PROSECUTED")
nproSum <- sort(summary(npro$Category),decreasing= TRUE)
#subset(nproSum,nproSum>0) esto estaba, muestra solo los delitos que tienen al menos 1 proceso judicial 
# iria algo así
prop.table(nproSum)

# forma copada (?)
table(train$Category, train$Resolution =="NOT PROSECUTED" )
notpros <- notpros[,c(0,2)]
prop.table(sort(notpros, decreasing= TRUE))


# 5)	Crear un histograma (o gráfico de barras) que muestre la cantidad de delitos por día de la semana.
barplot(sort(table(train$Day)))

