## 벡터 연산 Remind

x <- 1:10
y <- -4:5

q <- c("Hockey", "Football", "Baseball", "Curling", "Rugby", "Lacrosse", "Basketball", "Tennis", "Cricket", "Soccer")

nchar(q) # 각 요소의 문자열 길이 계산
nchar(y) 

x[1] # 첫번째 인자 접근
x[1:2] # 연속한 요소 접근
x[c(1,4)] # 연속하지 않은 요소 접근

# 이름-값 쌍을 사용해 각 요소에 이름을 지정
c(One = "a", Two="y", Last="r") 

# 하나의 벡터를 생성
w <- 1:3 

# 요소의 이름을 부여
names(w) <- c("a", "b", "c")
w

# 팩터형 벡터
q2 <- c(q, "Hockey", "Lacrosse", "Hockey","Water Polo", "Hockey","Lacrosse")

q2Factor <- as.factor(q2)
q2Factor

# ordered 인자에 TRUE 값을 주면 순서를 지정할 수 있다

factor(x = c("High School", "College", "Masters", "Doctorate"), levels = c("High School", "College", "Masters", "Doctorate"), ordered = TRUE)


factor(x = c("High School", "College", "Masters", "Doctorate"), levels = c("High School", "College", "Masters", "Doctorate"))

# 파이프

library(magrittr)

mean(x)
x %>% mean

z <- c(1, 2, NA, 8, 3, NA, 3)

sum(is.na(z))

z %>% is.na %>% sum
z %>% mean(na.rm=TRUE)