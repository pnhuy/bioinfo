# Data Frame
my_data = data.frame(gender = c('Male','Male','Male','Female',"Male","Female","Female","Male"),
                     height = c(150,171,168,164,167,185,165,169),
                     weight = c(81,93,78,56,67,75,59,80),
                     age = c(42,38,26,23,40,55,27,47)
)
my_data
class(my_data)

gender = c('Male','Male','Male','Female')
height = c(150,171,168,164)
data0 = as.data.frame(cbind(gender, height))
class(data0)

str(my_data)
summary(my_data)
names(my_data)
dim(my_data)
head(my_data)
tail(my_data)
my_data[c(2:4),c(1:2)]
my_data[1,3]
result = data.frame(my_data$gender,my_data$height)
result
subset(my_data, gender == "Male" & age > 30)


my_data$name = c('A','B','C','D','E',"F","G","H") # them cot
my_data

# Them hang
my_data_new = data.frame(gender = c('Male','Female','Male'),
                         height = c(180,166,178),
                         weight = c(55,53,67),
                         age = c(19,45,34),
                         name = c("K","L","M"))

data_final = rbind(my_data,my_data_new)
data_final


# If-else
m = c('A',"B","C")
if ("B" %in% m){
  print("TRUE")
}else {
  print("FALSE")
}

x = 1
if (x>3){
  x = x-3
  print(x)
} else if (x == 3){
  x = 0
  print(x)
} else {
  x = 3 - x
  print(x)
}

# For
for (a in 1:length(y)) {
  if(y[a] < 0) {print(y[a])}
}

sum = 0
for (x in 1:10) {
  sum = sum + x
}
sum

nucleotides = c("A","T","G","X")
for (first_nt in nucleotides) {
  for (second_nt in nucleotides) {
    for (third_nt in nucleotides) {
      print(paste(first_nt, second_nt, third_nt, sep = ""))
    }
  }
}

# While
v = "Hello !!"
count = 1
while (count < 10){
  print(v)
  count = count + 1
}  

# Repeat
i = 0
repeat{
  i = i + 1
  print(i)
  if(i > 10) break
}

# Next, Break
for (i in 1:100) {
  if (i <= 20) {
    next
  }
  print(i)
}


for (i in 1:100) {
  print(i)
  if (i > 20) {
    break
  }
}


# Function
c(1,2,3)
Sys.Date()
f = function(){}
f()
class(f)

f1 = function(){
  cat("Hello World")
}
f1()


s = function(a = 4){
  for(i in 1 : a) {
    b = i^2
    print(b)
  }
}
s(3)
s()

new_function = function(){
  for(i in 1: 5) {
    print(i^2)
  }
}
new_function(9)

my_function = function(a = 2,b = 3,c){
  result = a*b + c
  print(result)
}
my_function(1,2,3)
my_function()



# Ngay
x = as.Date("1999-08-26")
class(x)
d1 = Sys.Date()
d1
unclass(d1) # 1970-01-01 = 0 
d2 = as.Date('1970-01-01')
d1 - d2
d3 = as.Date("1969-01-01")
unclass(d3)
d3 - d2

# Thoi gian
t1 = Sys.time()
t1
class(t1)
unclass(t1)
t2 = as.POSIXlt(t1)# POSIXlt(danh sach cac gia tri tao nen Ngay & Tgian)
class(t2)
unclass(t2)
str(unclass(t2))
t2$hour
t2$mon

weekdays(d1)
months(t1)
quarters(t2)

t3 = "August 26,1999 09:30"
class(t3)
t4 = strptime(t3, "%b %d, %Y %H:%M")
t4
class(t4)
t4$hour

date.hour=strptime("2011-03-27 01:30:00", "%Y-%m-%d %H:%M:%S")
date.hour
class(date.hour)


x = as.Date("1999-08-26")
y = as.Date("2017-08-26")
y - x

a = as.Date("2012-01-01")
b = strptime("9 Jan 2011", "%d %B %Y")
a1 = as.POSIXct(a)
b - a1


c <- as.POSIXct("2012-10-25 01:00:00")
d <- as.POSIXct("2012-10-25 06:00:00")
d - c

install.packages("lubridate")
library(lubridate)
t = today() # Date
day(t)
month(t)
year(t)
wday(t , label = T)

now = now() # Date time
now
class(now)
hour(now)
minute(now)
second(now)
as.Date(now)
ymd(20201027)
ymd_hms("2020-08-20 12:00:00")


t + days(10)
t - days(2)
t + months(1)
t + years(4)
now
now + hours(4)
now + minutes(15)
now + seconds(5)
