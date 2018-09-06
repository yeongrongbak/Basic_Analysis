### Chapter 11. 그룹별 데이터 조작 ###

# 11.1 Apply 패밀리

# 11.1.1 apply 함수

theMatrix <- matrix(1:9, nrow=3)

# 행에 대한 합

apply(theMatrix, 1, sum)

# 열에 대한 합

apply(theMatrix, 2, sum)

# R에 내장된 함수 이용

rowSums(theMatrix)

colSums(theMatrix)

# 결측 값이 존재 할 때

theMatrix[2, 1] <- NA

apply(theMatrix, 1, sum)

apply(theMatrix, 1, sum, na.rm=T)

rowSums(theMatrix)

rowSums(theMatrix, na.rm=T)

# 11.1.2 lapply와 sapply 함수

# lapply : 리스트로 반환 , sapply : 벡터를 반환

theList <- list(A = matrix(1:9, 3), B=1:5, C=matrix(1:4, 2), D=2)

lapply(theList, sum)

sapply(theList, sum)

theNames <- c("Jared", "Deb", "Paul")

lapply(theNames, nchar)

# 11.1.3 mapply 함수

firstList <- list(A=matrix(1:16, 4), B=matrix(1:16, 2), C=1:5)
secondList <- list(A=matrix(1:16, 4), B=matrix(1:16, 8), C=15:1)

mapply(identical, firstList, secondList)

simpleFunc <- function(x,y) {
  NROW(x) + NROW(y)
}

mapply(simpleFunc, firstList, secondList)

# 11,2 집계 (aggregate 함수)

data(diamonds, package = "ggplot2")

head(diamonds)

# cut의 타입에 따른 price의 평균

aggregate(price ~ cut , diamonds, mean)

# 2개 이상의 변수를 사용한 그룹화

aggregate(price ~ cut + color, diamonds, mean)

# 2개 변수에 대한 그룹화

aggregate(cbind(price, carat) ~ cut, diamonds, mean)

# 2개 변수에 대해 2개 이상의 변수를 사용한 그룹화

aggregate(cbind(price, carat) ~ cut + color, diamonds, mean)

# 11,3 plyr 패키지

library(plyr)

head(baseball)

baseball$sf[baseball$year < 1954] <- 0

any(is.na(baseball$sf))

# 몸에 맞는 공이 NA인 경우 0으로 처리
baseball$hbp[is.na(baseball$hbp)] <- 0

any(is.na(baseball$hbp))

# 한 시즌 50 타석 미만인 선수는 제외
baseball <- baseball[baseball$ab >= 50,]

# 출루율 계산
baseball$OBP <- with(baseball, (h + bb + hbp)/(ab+bb+hbp+sf))
tail(baseball)

obp <- function(data){
  c(OBP = with(data, sum(h+bb+hbp)/ sum(ab+bb+hbp+sf)))
}

# ddply 함수를 사용해 선수별 경력 기간 동안의 출루율을 계산

careerOBP <- ddply(baseball, .variables = "id", .fun=obp)

careerOBP2 <- ddply(baseball, .variables = c("id","year"), .fun=obp)

# 결과를 출루율에 대해 정렬

careerOBP <- careerOBP[order(careerOBP$OBP, decreasing = T),]

head(careerOBP, 10)

careerOBP2 <- careerOBP2[order(careerOBP2$OBP, decreasing = T),]

head(careerOBP2, 10)

# 11.3.2 llply

llply(theList, sum)

identical(lapply(theList, sum), llply(theList,sum))

# 11.3.3 plyr 헬퍼 함수 (스킵)

# 11.3.4 속도 대 편의성 (스킵)

# 11.4 data.table

library(data.table)

theDF <- data.frame(A=1:10,
                    B=letters[1:10],
                    C=LETTERS[11:20],
                    D=rep(c("One", "Two", "Three"), length.out=10))

theDT <- data.table(A=1:10,
                    B=letters[1:10],
                    C=LETTERS[11:20],
                    D=rep(c("One", "Two", "Three"), length.out=10))

# data.frame 함수는 문자열을 디폴트로 팩터로 변환
# data.table 함수는 그렇지 않다

class(theDF$B)

class(theDT$B)

# 기존 데이터 프레임을 data.table로 바꿀수도 있다.

diamondsDT <- data.table(diamonds)
diamondsDT

theDT[1:2, ]
theDT[theDT$A >=7,]
theDT[A>=7,]

# 개별 열에 접근하는 방법

theDT[, list(A,C)]

theDT[, B]

theDT[, list(B)]

theDT[, "B", with = FALSE] # 열이름을 문자열로 주는 경우 with=FALSE 사용

# 11.4.1 키

# 테이블 보기

tables()

# 키 설정

setkey(theDT, D) # D열에 따라 알파벳 순으로 정렬

theDT