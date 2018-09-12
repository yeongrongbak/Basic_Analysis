### Chapter 9. General Statistics ###

# 9.1 Summarizing Your Data

summary()

# 9.2 Calculating Relative Frequencies

mean(x > 0)

# 9.3 Tabulating Factors and Creating Contingency Tables

table(f)

# 9.4 Testing Categorical Variables for Independence

summary(table(fac1,fac2))

# 9.5 Calculating Quantiles (and Quartiles) of a Dataset

quantile(vec, f)

quantile(vec, 0.05)

# 9.6 Inverting a Quantile

mean(vec < x)

# 9.7 Converting Data to Z-Scores

scale(x)

# 9.8 Testing the Mean of a Sample (t Test)

t.test(x, mu=m)

x <- rnorm(50, mean=100, sd=15)
t.test(x, mu=95)

# 9.9 Forming a Confidence Interval for a Mean

t.test(x)

t.test(x, conf.level=0.99)

# 9.10 Forming a Confidence Interval for a Median

wilcox.test(x, conf.int=TRUE)

# 9.11 Testing a Sample Proportion

prop.test(x, n, p)

# 9.12 Forming a Confidence Interval for a Proportion

prop.test(n, x)

# 9.13 Testing for Normality

shapiro.test(x)

# 9.14 Testing for Runs

library(tseries)
runs.test(as.factor(s))

library(tseries) #install.packages("tseries")
s <- sample(c(0,1), 100, replace=T)
runs.test(as.factor(s))

# 9.15 Comparing the Means of Two Samples

t.test(x, y, paired=TRUE)

# 9.16 Comparing the Locations of Two Samples Nonparametrically(비모수)

wilcox.test(x, y, paired=TRUE)

# 9.17 Testing a Correlation for Significance

cor.test(x, y) # Pearson

cor.test(x, y, method="Spearman")

# 9.18 Testing Groups for Equal Proportions

ns <- c(ns1, ns2, ..., nsN)
nt <- c(nt1, nt2, ..., ntN)
prop.test(ns, nt)

successes <- c(14,10)
trials <- c(38,40)
prop.test(successes, trials)

# 9.19 Performing Pairwise Comparisons Between Group Means

pairwise.t.test(x,f)

pairwise.t.test(comb$values, comb$ind)

# 9.20 Testing Two Samples for the Same Distribution

ks.test(x, y)

x <- sample(50)

### Chapter 10. Graphics ###

# 10.1 Creating a Scatter Plot

plot(x, y)

plot(cars)

# 10.2 Adding a Title and Labels

plot(x, main="The Title", xlab="X-axis Label", ylab="Y-axis Label")

plot(cars,
     main="cars: Speed vs. Stopping Distance (1920)",
     xlab="Speed (MPH)",
     ylab="Stopping Distance (ft)")

# 10.3 Adding a Grid

plot(x, y, type="n") # type = n 을 주면 frame만 만들고 데이터 포인트를 만들지 않는다.
grid()
points(x, y)


plot(cars,
     main="cars: Speed vs. Stopping Distance (1920)",
     xlab="Speed (MPH)",
     ylab="Stopping Distance (ft)",
     type="n")
grid(col="grey")
points(cars)

# 10.4 Creating a Scatter Plot of Multiple Groups

plot(x, y, pch=as.integer(f))

with(iris, plot(Petal.Length, Petal.Width))

with(iris, plot(Petal.Length, Petal.Width, pch=as.integer(Species)))

# 10.5 Adding a Legend

legend(1.5, 2.4, c("setosa","versicolor","virginica"), pch=1:3)

f <- factor(iris$Species)
with(iris, plot(Petal.Length, Petal.Width, pch=as.integer(f)))
legend(1.5, 2.4, as.character(levels(f)), pch=1:length(levels(f)))

legend(0.5, 95, c("Estimate","Lower conf lim","Upper conf lim"),
       lty=c("solid","dashed","dotted"))

# 10.6 Plotting the Regression Line of a Scatter Plot

library(faraway) # install.packages("faraway")
data(strongx)
m <- lm(crossx ~ energy, data=strongx)
plot(crossx ~ energy, data=strongx)
abline(m)

# 10.7 Plotting All Variables Against All Other Variables

head(iris)

plot(iris[,1:4])

# 10.8 Creating One Scatter Plot for Each Factor Level

data(Cars93, package="MASS")
coplot(Horsepower ~ MPG.city | Origin, data=Cars93)

# 10.9 Creating a Bar Chart

heights <- tapply(airquality$Temp, airquality$Month, mean)

barplot(heights)

barplot(heights,
        main="Mean Temp. by Month",
        names.arg=c("May", "Jun", "Jul", "Aug", "Sep"),
        ylab="Temp (deg. F)")

# 10.10 Adding Confidence Intervals to a Bar Chart

library(gplots)# install.packages("gplots")
barplot2(x, plot.ci=TRUE, ci.l=lower, ci.u=upper)

attach(airquality)
heights <- tapply(Temp, Month, mean)
lower <- tapply(Temp, Month, function(v) t.test(v)$conf.int[1])
upper <- tapply(Temp, Month, function(v) t.test(v)$conf.int[2])

barplot2(heights, plot.ci=TRUE, ci.l=lower, ci.u=upper)

barplot2(heights, plot.ci=TRUE, ci.l=lower, ci.u=upper,
         ylim=c(50,90), xpd=FALSE,
         main="Mean Temp. By Month",
         names.arg=c("May","Jun","Jul","Aug","Sep"),
         ylab="Temp (deg. F)")

