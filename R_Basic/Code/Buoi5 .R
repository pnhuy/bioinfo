# Logistic resgression
hours = c(0.5,0.75,1,1.25,1.5,1.75,1.75,2.0,2.25,2.5,
          2.75,3,3.25,3.5,4,4.25,4.5,4.75,5,5.5)
pass = c(0,0,0,0,0,0,1,0,1,0,
         1,0,1,0,1,1,1,1,1,1)
res = glm(hours ~ pass, family = binomial)
summary(res)
predict(res)
predict(res, type = 'response')
plot(fitted(res) ~ hours)
plot(hours, jitter(pass, 0.15), pch = 16)
xv = seq(min(hours),max(hours))
yv = predict(res,list(hours = xv), type = 'response')
lines(xv,yv, col = "red")

#Chi square
A = matrix(c(123,200,158,119,528,181), 3,2,byrow = T)
A
chisq.test(A)


#ANOVA
A = c(8,9,11,4,7,8,5)
B = c(7,17,10,14,12,24,11,22)
C = c(28,21,26,11,24,19)
D = c(26,16,13,12,9,10,11,17,15)
x = c(A,B,C,D)
x
length(x)
group = c(rep("A", 7 ), rep("B",8), rep('C',6), rep("D", 9))
dat = data.frame(x, group)
dat
av = aov(x ~ group)
summary(av)
TukeyHSD(av)