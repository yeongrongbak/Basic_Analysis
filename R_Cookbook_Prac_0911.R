### R Cookbook ###

# p.121
# 5.17 Selecting One Row or Column from a Matrix

theData <- c(1.1, 1.2, 2.1, 2.2, 3.1, 3.2)
mat <- matrix(theData, 2, 3)

mat[1,]
mat[,3]

mat[1,,drop=F]
mat[,3,drop=F]


# 5. 27 Removing NAs from a Data Frame

dfrm <- data.frame(x = 1, y = 1:10)

cumsum(dfrm)

dfrm[3,1] <- NA

dfrm[4,2] <- NA

cumsum(dfrm)

cumsum(na.omit(dfrm))

# 6. Data Transformations

v <- c(40, 2, 83, 28, 58)
f <- factor(c("A","C","C","B","C"))

# 6.1 Splitting a Vector into Groups

library(MASS)

split(Cars93$MPG.city, Cars93$Origin)

g <- split(Cars93$MPG.city, Cars93$Origin) # MPG를 Origin으로 나누어서 본다

median(g[[1]])
median(g$USA)

median(g[[2]])
median(g$`non-USA`)

# 6.2 Applying a Function to Each List Element

scores <- list()
scores$S1 <- c(89, 85, 85, 86, 88, 89, 86, 82, 96, 85, 93, 91, 98, 87, 94, 77, 87, 98, 85, 89, 95, 85, 93, 93, 97, 71, 97, 93, 75, 68, 98, 95, 79, 94, 98, 95)
scores$S2 <- c(60, 98, 94, 95, 99, 97, 100, 73, 93, 91, 98, 86, 66, 83, 77, 97, 91, 93, 71, 91, 95, 100, 72, 96, 91, 76, 100, 97, 99, 95, 97, 77, 94, 99, 88, 100, 94, 93, 86)
scores$S3 <- c(95, 86, 90, 90, 75, 83, 96, 85, 83, 84, 81, 98, 77, 94, 84, 89, 93, 99, 91, 77, 95, 90, 91, 87, 85, 76, 99, 99, 97, 97, 97, 77, 93, 96, 90, 87, 97, 88)
scores$S4 <- c(67, 93, 63, 83, 87, 97, 96, 92, 93, 96, 87, 90, 94, 90, 82, 91, 85, 93, 83, 90, 87, 99, 94, 88, 90, 72, 81, 93, 93, 94, 97, 89, 96, 95, 82, 97)

lapply(scores, length)

sapply(scores, length)

sapply(scores, mean)

sapply(scores, sd)

sapply(scores, range)

tests <- lapply(scores, t.test)

str(tests)

tests[[1]]$conf.int

sapply(tests, function(t) t$conf.int)

Moe <- c(-1.8501520, -1.406571, -1.0104817, -3.7170704, -0.2804896)
Larry <- c(0.9496313, 1.346517, -0.1580926 ,1.6272786 ,2.4483321)
Curly <- c(-0.5407272, -1.708678, -0.3480616, -0.2757667, -1.2177024)

long <- rbind(Moe, Larry, Curly)
colnames(long)  <- c("trial1","trial2","trial3","trial4","trial5")
long

apply(long, 1, mean) # 1: row 기준으로 function 적용 
apply(long, 1, range)

apply(long, 2, mean) # 2: column 기준으로 function 적용

long

# 6.5 Applying a Function to Groups of Data

pop <- c(2853114 ,90352 ,171782 ,94487 ,102746 ,106221 ,147779 ,76031 ,70834 ,72616 ,74239 ,83048 ,67232 ,75386 ,63348 ,91452)

country <- c("Cook", "Kenosha", "Kane", "Kane", "Lake(IN)", "Kendall", "DuPage", "Cook", "Will",  "Cook", "Cook", "Lake(IN)", "Cook", "Cook", "Cook", "Lake(IL)")

tapply(pop, country, sum)

tapply(pop, country, mean)

tapply(pop, country, length)

df <- cbind(pop, country)

df <- as.data.frame(df)

df

df$pop <- as.character(df$pop)

df$pop <- as.numeric(df$pop)

str(df)

table(df$country)

## 7. String and Date

# 7.1 Getting the Length of a String

nchar("Moe")
nchar("Curly")

s <- c("Moe", "Larry", "Curly")
nchar(s)

length("Moe") # it returns the length of a vector.
length(c("Moe","Larry","Curly"))

# 7.2 Concatenating Strings

paste("Everybody", "loves", "stats.")

stooges <- c("Moe", "Larry", "Curly")

paste(stooges, "loves", "stats.")

paste(stooges, "loves", "stats", collapse=", and ")

# 7.3 Extracting Substrings

substr("Statistics", 1, 4)

substr("Statistics", 7, 10)

cities <- c("New York, NY", "Los Angeles, CA", "Peoria, IL")

substr(cities, nchar(cities)-1, nchar(cities))

# 7.4 Splitting a String According to a Delimiter

path <- "/home/mike/data/trials.csv"
strsplit(path, "/")

# 7.5 Replacing Substrings

s <- "Curly is the smart one. Curly is funny, too."
sub("Curly", "Moe", s)

gsub("Curly", "Moe", s)

sub(" and SAS", "", "For really tough problems, you need R and SAS.")

# 7.6 Seeing the Special Characters in a String

s <- "first\rsecond\n"
nchar(s)
cat(s) # cat은 special character를 보여주지 않는다

s <- "first\rsecond
\n
\n third"
cat(s)
print(s)

cat("\f") # console 창을 비워주는 역할

# 7.7 Generating All Pairwise Combinations of Strings

locations <- c("NY", "LA", "CHI", "HOU")
treatments <- c("T1", "T2", "T3")

outer(locations, treatments, paste, sep="-")
outer(treatments, treatments, paste, sep="-")
m <- outer(treatments, treatments, paste, sep="-")
a <- m[!lower.tri(m)]
b <- m[!upper.tri(m)]

all.equal(a,b)
