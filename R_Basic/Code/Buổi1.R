2 + 3
log(10)
log10(10)
2 ^ 5
abs(-4)
sqrt(25)
sum( 2 + 5)

# R object
a = TRUE
class(a)

b = 40.5 
class(b)

c = 5L
class(c)


d = 5 + 7i
class(d)

e = 'abc'
class(e)


v = c(1,2,3)
v1 = c("A","B","C","D","E", 1, 56,243)
v2 = c(4,5,6)
v + v2
v - v2
v * v2
v - v1
v1[3]
v1[1:3]
v1[c(1,4,5)]
1: 10
rep(2,3)
rep(c(1,2,7),each=  5)
seq(1,2,0.2)


# List
list1 = list(c(1,6,10),c(2,2,5),"Hello",312,"AAA")
list2 = list(list1, c(2,4,4))
list1
list2
list1[1]
list1[5]
list1[[1]][[3]]
list1[[3]] = "Hi"
list1

# Matrix
A = matrix(1:9,  nrow = 3,ncol = 3, byrow = T)
A
B = matrix(1:9, 3,3, byrow = F)
B
C = matrix(c(2,4,5,8,10,15), nrow =2, ncol = 3, byrow = T)
C
C[2,2]
C[2,3]
C[1,]
C[,3]
A[2:3,]
A[,1:2]
A[c(1,3),]
A[,c(1,3)]
A[1,2] = 5
A
A1 = matrix(c(1,3,2,7,2,4,2,10,8), 3 ,3, byrow = T)
A1
A + A1
A - A1
A * A1

# Factors
my.colors = factor(c("Green","Blue","Green","Red"))
my.colors
eg = factor(c("A","A","B","C","D","E","B","D","C"))
eg

data jdasd = 413
my_dsa = 4
abc4 = "HEllo"
a = 5
A = 5
a + A
my.data
my_data

# Doc file csv, excel
setwd("#Nhap duong dan den thu muc chua file can doc")
eg = read.csv("WHO.csv")
install.packages("readxl")
library(readxl)
eg1 = read_xlsx("Book1 2.xlsx")
