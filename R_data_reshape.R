### Chapter 14. 데이터 재구조화 ###
# plyr, reshape2, data.table 패키지 활용

# 14.1 cbind와 rbind

sport <- c("Hockey", "Baseball", "Football")
league <- c("NHL", "MLB", "NFL")
trophy <- c("Stanley Cup", "Comissioner's Trophy", "Vince Lombardi Trophy")
trophies1 <- cbind(sport, league, trophy)

# data.frame() 사용

trophies2 <- data.frame(sport = c("Basketball", "Golf"),
                        league = c("NBA", "PGA"),
                        trophy = c("Larry O'Brien Championship Trophy", "Wanamaker Torphy"),
                        stringsAsFactors = FALSE)

# rbind를 사용해서 하나의 데이터 프레임으로 만든다.

trophies <- rbind(trophies1, trophies2)

# cbind 에서 데이터를 결합하면서 새로운 이름을 할당할 수도 있다.

cbind(Sport=sport, Association=league, Prize=trophy)

# 14.2 조인
# 베이스 R에 있는 merge 함수
# plyr 패키지에 있는 join 함수
# data.tables에 있는 머지 기능

download.file(url="http://jaredlander.com/data/US_Foreign_Aid.zip",
              destfile="data/ForeignAid.zip")
unzip("data/ForeignAid.zip", exdir="data")

library(stringr) #install.packages("stringr")

# 파일들의 리스트를 얻는다
theFiles <- dir("data/", pattern="\\.csv")

for(a in theFiles) {
  # 데이터를 할당한 좋은 이름을 만든다
  nameToUse <- str_sub(string = a, start = 12, end = 18)
  # read.table 함수를 사용해 csv 파일을 읽는다
  temp <- read.table(file = file.path("data", a),
                     header = T, sep=",", stringsAsFactors = F)
  # 읽은 데이터를 워크스페이스에 할당한다
  assign(x= nameToUse, value=temp)
  }

# 14.2.1 merge 함수

Aids90s00s <- merge(x = Aid_90s, y= Aid_00s,
                    by.x = c("Country.Name", "Program.Name"),
                    by.y = c("Country.Name", "Program.Name"))

head(Aids90s00s)

# merge 장점 : 각각의 데이터 프레임의 서로 다른 이름을 지정 할 수 있다.
# merge 단점 : 다른 대안들보다 훨씬 느리다.

# 14.2.2 plyr join 함수

# join 장점 : merge 보다 훨씬 빠르다.
# join 단점 : 각 테이블의 키 열의 이름이 같아야 한다.

library(plyr)
Aids90s00sJoin <- join(x=Aid_90s, y=Aid_00s,
                       by = c("Country.Name", "Program.Name"))
head(Aids90s00sJoin)

# 데이터 프레임의 이름 파악

frameNames <- str_sub(string = theFiles, start = 12, end = 18)

# 빈 리스트를 만든다

frameList <- vector("list", length(frameNames))
names(frameList) <- frameNames

# 각 데이터 프레임을 리스트에 추가한다

for(a in frameNames){
  frameList[[a]] <- eval(parse(text=a))
}

head(frameList[[1]])
head(frameList[["Aid_00s"]])
head(frameList[[5]])
