### Chapter 16. 문자열 처리 ###

# 16.1 paste 함수
# 일련의 문자열이나 문자열로 평가되는 표현식을 받아 그것을 하나의 문자열로 바꾼다.

paste("Hello", "Jared", "and others") # seperate의 default는 공백이다

paste("Hello", "Jared", "and others", sep="/")

paste(c("Hello","Hey","Howdy"), c("Jared","Bob","David"))

paste("Hello", c("Jared","Bob","David")) # 재사용 규칙 적용

# 문자열 벡터에 대해 문자열을 묶어 하나의 문자열로 만드는 기능

vectorOfText <- c("Hello", "Everyone", "out there", ".")

paste(vectorOfText, collapse = " ")

paste(vectorOfText, collapse = "*")

# 16.2 spintf 함수
# 긴 문장열에 값을 삽입시킬 특별한 마커를 삽입해 간단하게 처리해준다.



person <- "Jared"
partySize <- "eight"
waitTime <- 25

sprintf("Hello %s, your party of %s will be sited in %s minutes",
       person, partySize, waitTime)

sprintf("Hello %s, your party of %s will be sited in %s minutes",
        c("Jared","Bob"), c("eight",16,"four",10), waitTime)

# 16.3 텍스트 추출

library(XML)

theURL <- "http://www.loc.gov/rr/print/list/057_chron.html"

presidents <- readHTMLTable(theURL, which = 3, as.data.frame = T,
                            skip.rows = 1, header = T,
                            stringsAsFactors = F)

head(presidents)

tail(presidents$YEAR)

presidents <- presidents[1:64,]

library(stringr)

yearList <- str_split(string = presidents$YEAR, pattern = "-")
head(yearList)

# 리스트를 하나로 묶어서 행렬로 만든다.

yearMatrix <- data.frame(Reduce(rbind, yearList))

head(yearMatrix)

names(yearMatrix) <- c("Start", "Stop")

# 데이터 프레임에 새 열 추가

presidents <- cbind(presidents, yearMatrix)

# Start, Stop 열을 숫자로 변환

presidents$Start <- as.numeric(as.character(presidents$Start))
presidents$Stop <- as.numeric(as.character(presidents$Stop))

head(presidents)

# str_sub 함수를 사용하면 원하는 문자를 선택할 수 있다.

str_sub(string = presidents$PRESIDENT, start = 1 , end = 3)

# 16.4 정규 표현식

# 특정 문자를 찾기 위해 str_detect 함수를 사용한다.

# John이 이름에 포함돼 있으면 T/F 반환

johnPos <- str_detect(string=presidents$PRESIDENT, pattern="John")
presidents[johnPos, c("YEAR", "PRESIDENT", "Start", "Stop")]

badSearch <- str_detect(presidents$PRESIDENT, "john")
goodSearch <- str_detect(presidents$PRESIDENT, regex("john", ignore_case = T))

sum(badSearch)
sum(goodSearch)

# 미국 전쟁 리스트에 대한 데이터 테이블 활용

con <- url("http://www.jaredlander.com/data/warTimes.rdata")
load(con)
close(con)

head(warTimes)

# 전쟁의 시작 정보를 담은 새로운 열을 생성하고자 한다.

# 구분자는 일반적으로 ACAEA, "-"이 사용된 경우도 존재

warTimes[str_detect(string = warTimes, pattern ="-")]

