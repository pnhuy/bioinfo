#Bieu do
emp = read.csv("emp_attrition.csv", header = T)
attach(emp)
dim(emp)
names(emp)

# plot
plot(age, type = "b", col = "pink", xlab = "X", ylab ="Y",main = "Plot")

plot(MonthlyIncome ~ Age, pch = 16, col = "Brown")
abline(lm(MonthlyIncome ~ Age), lwd = 3)
#install.packages("car")
library(car)
scatterplot(MonthlyIncome ~ Age|Gender, pch = c(16,18), col = c("Red", "Green"))
          

# histogram
hist(MonthlyIncome)
hist(MonthlyIncome, breaks = 20, col = "Pink", border = "Black")
hist(MonthlyIncome, breaks = 20, col = "Pink", border = "Black",
     ylim = c(0,400), xlab = "Monthly Income", ylab = "Percentage")

     
# barplot
tab = table(Gender)
barplot(tab,col = c("Blue","Red"))

# boxplot
boxplot(MonthlyIncome, col = "Red", notch = T,
        xlab = "Monthly Income", ylab = "Vnd", main = "Boxplot", horizontal =  T)
boxplot(MonthlyIncome ~ Gender, col = c("Red","Blue"), notch = T,
        xlab = "Monthly Income", ylab = "Vnd", main = "Boxplot", horizontal = T)




# Package Dplyr

#install.packages("dplyr")
library(dplyr)
#chicago = readRDS("chicago.rds")
#write.csv(chicago,"/Users/phungduchuy/RStudio /Data/Chicago.csv" )

chicago = read.csv("Chicago.csv", header = T)
attach(chicago)
dim(chicago)
str(chicago)
names(chicago)

# Select()
names(chicago)[1:3]
subset = select(chicago,city:date)
select(chicago, city, pm25tmean2, date)
head(subset)

subset1 = select(chicago, ends_with("mean2"))
str(subset1)
head(subset1)

subset2 = select(chicago, starts_with("d"))
str(subset2)
head(subset2)


# Filter ()
chic.f = filter(chicago, pm25tmean2 > 30)
head(chic.f)

chic.f.demo = filter(chicago, !is.na(pm25tmean2))
summary(chic.f$pm25tmean2)
dim(chic.f)


chic.f1 = filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(chic.f1)

select(chic.f1, date, tmpd , pm25tmean2)


# Arrange()
chicago = arrange(chicago, date)
head(select(chicago, date, pm25tmean2), 6)
tail(select(chicago, date , pm25tmean2), 6)

chicago = arrange(chicago, desc(date))
head(select(chicago, date , pm25tmean2), 6)
tail(select(chicago, date , pm25tmean2), 6)



# Rename()
head(chicago[,1:5],3)
chicago = rename(chicago, dewpoint = dptp, pm25 = pm25tmean2)
head(chicago[,1:5],3)



# Mutate()
chicago = mutate(chicago, pm25detrend = (pm25) - mean(pm25, na.rm = TRUE))
head(chicago)

chic.trans = transmute(chicago,
                       pm10detrend = pm10tmean2 - mean(pm10tmean2, na.rm = TRUE),
                       o3detrend = o3tmean2 - mean(o3tmean2, na.rm = TRUE))
head(chic.trans)


# Group_by()
chicago = mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years = group_by(chicago, year)
summarize(chicago, pm25 = mean(pm25, na.rm = TRUE),
          o3 = max(o3tmean2, na.rm = TRUE),
          no2 = median(no2tmean2, na.rm = TRUE))
summarize(years, pm25 = mean(pm25, na.rm = TRUE),
          o3 = max(o3tmean2, na.rm = TRUE),
          no2 = median(no2tmean2, na.rm = TRUE))


qq = quantile(chicago$pm25, seq(0, 1, 0.2), na.rm = TRUE)
chicago = mutate(chicago, pm25.quint = cut(pm25, qq))
quint = group_by(chicago,pm25.quint)
summarize(quint,
          o3 = mean(o3tmean2, na.rm = TRUE),
          no2 = mean(no2tmean2, na.rm = TRUE))


# %>% Xau chuoi
mutate(chicago, pm25.quint = cut(pm25, qq)) %>%
  group_by(pm25.quint) %>%
  summarize(o3 = mean(o3tmean2, na.rm = TRUE),
            no2 = mean(no2tmean2, na.rm = TRUE))

mutate(chicago, month = as.POSIXlt(date)$mon ) %>%
  group_by(month) %>%
  summarize(pm25 = mean(pm25, na.rm = TRUE),
            o3 = mean(o3tmean2, na.rm = TRUE),
            no2 = mean(no2tmean2, na.rm = TRUE))



# Loopfunction


# lapply
x = list(a = 1:5, b = 5:20 , d = c(4,5,6))
lapply(x, mean)
lapply(x, median)

x = list(a = 1 :4, b= rnorm(10), c= rnorm(20,1))
lapply(x, summary )

x= 1:4
lapply(x, runif)

x = list(A = matrix(1:4,2,2, byrow = T), B = matrix(1:6,3,2, byrow = T))
x
f = function(mat) {
  mat[,1]
}
lapply(x, f)

lapply(x,"[", ,2)


# sapply
x = list(a = 1 :4, b= rnorm(10), c= rnorm(20,1))
sapply(x, mean)
lapply(x, mean)

x = list(a = 1 :4, b= rnorm(10), c= rnorm(20,1))
sapply(x, length)

# split
x = c(rnorm(10),runif(10))
y = c(rnorm(20))
f = gl(2,10)
split(x,f)
lapply(split(x,f),mean)

x = c(rep(9,3), rep(7, 5), rep(5,2))
g = as.factor(c(rep("A",3), rep("B", 5), rep("C",2)))
split(x,g)
sapply(split(x,g), sum)

# Spliting a Data Frame
library(datasets)
head(airquality)
View(airquality)
s = split(airquality, airquality$Month)
str(s)
lapply(s, function(x){colMeans(x[,c("Ozone","Solar.R","Wind")],na.rm = TRUE)})
sapply(s, function(x){colSums(x[,c("Ozone","Solar.R","Wind")], na.rm = TRUE)})


# tapply
x = c(rnorm(10), runif(10), 1:10)
f = gl(3,10)
tapply(x,f,mean)
tapply(x,f,range)

dat = read.csv("emp_attrition.csv", header = T)
attach(dat)
dim(dat)
names(dat)
head(dat)
tapply(MonthlyIncome, JobRole, mean)


# apply
X = matrix(rnorm(200), 20, 10)
apply(X,2, mean)
rowSums = apply(X, 1, sum)


# mapply
a = c(1,2,3,4,5)
b = c(2,3,4,5,6)
d = c(3,4,5,6,7)
mapply(sum,a,b,d)

list0 = list(c(3,4,5,6,7,8,9),  c(1,2,3,4,5,6,7,8,9,10))
list1 = list(c(5,6,7,8,9,10,11), c(11:20))
mapply(sum,list0,list1)


Q1 = matrix(c(rep(1,4), rep(2,4), rep(3,4), rep(4,4)), 4 , 4, byrow = F)
Q1
mapply(rep,1:4,4)

