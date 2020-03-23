my.data = read.csv("bone.csv", header = TRUE)
attach(my.data)
names(my.data)
m1 = lm(fnbmd ~ wt)
summary(m1)
m1
plot(fnbmd ~ wt, pch =16, ylab = "fnbmd", xlab = "weight (kg)")
abline(m1, col = "red")
y = a +bx fnbmd(y) = 0.38 + 0.006wt(x)
# Phuong sai
anova(m1)
var(na.omit(fnbmd))
dif = 0.0239 - 0.0159
dif
dif/0.0239
