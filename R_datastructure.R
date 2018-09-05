### Chapter 5. 고급 데이터 구조 ###

# DataFrame : 데이터 분석에서 가장 일반적으로 사용(중요)
# Matrix : 텍스트마이닝에서 주로 사용
# List : 모델이 대부분 리스트 형태

# 5.1 데이터 프레임

x <- 10:1
y <- -4:5
q <- c("Hotkey", "Football", "Baseball", "Curling", "Rugby", "Lacrosse", "Basketball", "Tennis", "Cricket", "Soccer")


# 데이터 프레임 생성
theDF <- data.frame(x, y, q)
theDF

# 속성의 이름 값 부여
theDF <- data.frame(First = x, Second = y, Sport = q)
theDF

# 행과 열의 개수 파악

nrow(theDF)
ncol(theDF)
dim(theDF)

# 열의 이름 파악

names(theDF)
names(theDF)[3]

# 행에 이름 할당

rownames(theDF)
rownames(theDF) <- c("One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten")
rownames(theDF)

# 일반 인덱스로 다시 놓기

rownames(theDF) <- NULL
rownames(theDF)

# 처음 몇 개의 행만 출력

head(theDF)

# 클래스 체크

class(theDF)

# 특정 열에 접근

theDF$Sport
theDF[3]
theDF[3,2]

# 하나 이상의 행, 열을 지정하고 싶은 경우

theDF[3, 2:3] # 3행, 2열에서 3열까지
theDF[c(3,5), 2] # 3행과 5행의 2열
theDF[c(3,5), 2:3] # 3,5행의 2,3열


# 전체 열(or행)에 접근할 떄는 행(or열)은 지정하지 않고 비워둔다

theDF[, 3]
theDF[, 2:3]
theDF[2, ]
theDF[2:4,]

# 열 이름을 사용한 접근

theDF[, c("First", "Sport")]

class(theDF[, "Sport"])

# 한 열의 데이터 프레임 반환

theDF["Sport"]
class(theDF["Sport"])

# 팩터형 벡터를 반환

theDF[["Sport"]]
class(theDF[["Sport"]])

# 원 데이터의 형태를 유지하는 방법 (drop = False)

theDF[, "Sport", drop=FALSE]
class(theDF[, "Sport", drop=FALSE])

theDF[, 3, drop=FALSE]
class(theDF[, 3, drop=FALSE])

# model.matrix 함수를 사용한 지표 변수 (가변수) 생성

newFactor <- factor(c("Pennsylvania", "New York", "New Jersey", "New York", "Tennessee", "Massachusetts", "Pennsylvania", "New York"))

model.matrix( ~ newFactor -1)

# 5.2 리스트

# 3개의 요소를 가진 리스트

list(1,2,3)

# 하나의 요소가 여러 개의 요소를 가진 벡터

list(c(1,2,3))

(list3 <- list(c(1,2,3), 3:7))

list(theDF, 1:10)

list5 <- list(theDF, 1:10, list3)
list5

names(list5)

names(list5) <- c("data.frame", "vector", "list")

names(list5)

list5

# 이름은 리스트를 만들 때 지정도 가능하다

list6 <- list(theDataFrame = theDF, TheVector = 1:10, TheList = list3)

names(list6)
list6

# 특정 크기를 가진 빈 리스트를 만들때는 vector 함수 사용

(emptyList <- vector(mode ="list", length=4)) # 4개 빈 리스트 생성

# 리스트에서 개별 요소에 접근 할 때는 이중 대괄호 사용

list5[[1]]

list5[["data.frame"]]

# 하나의 요소를 가져오고 나면 다시 인덱싱 해 실제값 사용 가능

list5[[1]]$Sport

list5[[1]][, "Second"]

list5[[1]][,"Second", drop=FALSE]

# 존재하지 않는 숫자 또는 이름에 인덱스를 사용해 인덱스에 요소를 추가할 수 있다

length(list5)

list5[[4]] <- 2

length(list5)

list5[['NewElement']] <- 3:6

length(list5)

list5

# 5.3 행렬

A <- matrix(1:10, nrow=5)

B <- matrix(21:30, nrow=5)

C <- matrix(21:40, nrow=2)

A

B

C

nrow(A)
ncol(A)
dim(A)

A+B

A*B

A==B

A %*% t(B)

colnames(A)

rownames(A)

colnames(A) <- c("Left", "Right")
rownames(A) <- c("1st", "2nd", "3rd", "4th", "5th")

colnames(B) <- c("First", "Second")
rownames(B) <- c("One", "Two", "Three", "Four" ,"Five")

colnames(C) <- LETTERS[1:10]
rownames(C) <- c("Top", "Bottom")

t(A)

A %*% C

# 5.4 배열 (다차원 벡터)

theArray <- array(1:12, dim = c(2,3,2))
theArray

theArray[1,,]

theArray[1,,1]

theArray[,,1]
