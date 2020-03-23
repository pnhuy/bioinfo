
smokers = c(18,22,21,17,20,17,23,20,22,21)
nonsmokers = c(16,20,14,21,20,18,13,15,17,21)
cbind(smokers,nonsmokers)
t.test(smokers,nonsmokers)


# t-test(x ~ group)
x = c(smokers, nonsmokers)
g = rep("Smokers", 10)
g1 = rep("Nonsmoker", 10)
group = c(g,g1)
cbind(x, group)
t.test(x ~ group)
t.test(homeless,group,paired = T)





# Z-test (edited)
install.packages("DescTools")
library(DescTools)
attach(mtcars)
head(mtcars)

# One sample Z-test
ZTest(mpg, mu = 25, sd_pop = 5)
# Two sample Z-test
mpg_cyl4 = mpg[cyl ==4]
mpg_cyl8 = mpg[cyl == 8]
ZTest(mpg_cyl4,mpg_cyl8, sd_pop = 5)
ZTest(before,after, sd_pop = 5, paired = T)

# One sample T-test
t.test(mpg, mu =25)
t.test(mpg_cyl4, mpg_cyl8)
before = c(200.1,190.9,192.7,213,241.4,196.9,172.2,185.5,205.2,193.7)
after = c(392.9,393.2,345.1,393,434,427.9,422,383.9,392.3,352.2)
t.test(before,after, paired = TRUE)
attach(airquality)
pairwise.t.test(Ozone,Month)
var.test(before,after)
