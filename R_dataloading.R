### Chapter 6. 데이터 읽어오기 ###

# 6.1 CSV 파일 읽기

theUrl <- "http://www.jaredlander.com/data/TomatoFirst.csv"
tomato <- read.table(file = theUrl, header = T, sep=",")

head(tomato)

# 6.1.1 read_delim

library(readr) # install.pakcages("readr")

tomato2 <- read_delim(file=theUrl, delim=',')

tomato2 # read_delim 함수는 tibble 객체를 반환하는 차이점 존재

head(tomato2) # 티블의 장점은 열 이름 아래 데이터 유형이 표시 된다는 것

# 6.1.2 fread
# data.table은 큰 파일을 불러오는 데 효율이 떨어진다
# 큰 데이터를 빠르게 읽는 방법 중 하나 fread
# read_delim 을 쓸지 fread를 쓸지는 데이터 조작 시 dplyr를 사용할 지 data.table을 사용할지에 달려있다.

library(data.table) # install.packages("data.table")

tomato3 <- fread(input=theUrl, sep=",", header=T)

head(tomato3)

# 6.2 엑셀 데이터

download.file(url="http://www.jaredlander.com/data/ExcelExample.xlsx", destfile = 'data/ExcelExample.xlsx', mode='wb')

library(readxl) # install.packages("readxl")
excel_sheets('data/ExcelExample.xlsx')

tomatoXL <- read_excel('data/ExcelExample.xlsx')
head(tomatoXL)

WineXL1 <- read_excel('data/ExcelExample.xlsx', sheet=2)
head(WineXL1)

# 6.3 데이터베이스에서 데이터 읽기

# PostgreSQL -> RPostgreSQL 패키지
# MySQL -> RMySQL 패키지
# SQLite -> RSQLite 패키지
# 특정 패키지가 없는 데이터 베이스 -> RODBC 패키지


download.file("http://www.jaredlander.com/data/diamonds.db", destfile = "data/diamonds.db", mode='wb')

library(RSQLite) # install.packages(RSQLite)

# dbDriver를 통해 드라이버 등록

drv <- dbDriver('SQLite')
class(drv)

# 특정 데이터베이스에 대한 커넥션 구성

con <- dbConnect(drv, 'data/diamonds.db')
class(con)

# 데이터베이스에 대한 정보 추출

dbListTables(con)
dbListFields(con, name='diamonds')
dbListFields(con, name='DiamondColors')

# dbGetQuery 함수를 사용해 쿼리를 실행 : 데이터 프레임을 반환해준다

diamondsTable <- dbGetQuery(con,
                            "SELECT * FROM diamonds",
                            stringAsFactors = F)
head(diamondsTable)

colorTable <- dbGetQuery(con,
                            "SELECT * FROM DiamondColors",
                            stringAsFactors = F)
head(colorTable)

# 두 테이블 조인

longQuery <- "SELECT * FROM diamonds, DiamondColors
WHERE diamonds.color = DiamondColors.Color"

diamondsJoin <- dbGetQuery(con, longQuery,
                           stringAsFactors=F)
head(diamondsJoin)

# 6.5 R 바이너리 파일

#토마토 데이터 프레임을 디스크에 저장
save(tomato, file="data/tomato.rdata")

#메모리에서 토마토를 제거
rm(tomato)

#아직도 남아있는지 확인
head(tomato)

#RData 파일에서 객체를 읽는다
load("data/tomato.rdata")

#세션에 존재하는지 확인
head(tomato)

# 6.6 R에 포함돼 있는 데이터

data(diamonds, package = 'ggplot2') # install.packages("ggplot2")
head(diamonds)

# 6.7 웹 사이트에서 데이터 추출하기

# 6.7.1 간단한 HTML 테이블

library(XML) # install.packages("XML")

theURL <- "https://www.jaredlander.com/2012/02/another-kind-of-super-bowl-pool/"

bowlPool <- readHTMLTable(theURL, which=1, header=F, stringsAsFactors=F)

library(rvest) #install.packages("rvest")

read_html(theURL) %>% html_table()

# 6.7.2 웹 데이터 스크래핑

#read_html을 통해 모든 html요소 불러옴

ribalta <- read_html("https://www.jaredlander.com/data/ribalta.html")

class(ribalta)

#ul요소 안에 있는 모든 span을 걸러 낸다

ribalta %>% html_nodes('ul') %>% html_nodes('span')

#street 클래스를 가진 요소를 찾는다
#하나의 클래스는 .을 통해, 아이디는 #(해시)를 통해 찾는다

ribalta %>% html_nodes('.street')

#html_text 함수를 사용해 span 요소에 저장된 텍스트 추출

ribalta %>% html_nodes('.street') %>% html_text()

#정보가 HTML요소의 속성으로 저장된 경우 html_attr 함수 사용

ribalta %>% html_nodes('#longitude') %>% html_attr("value")

library(magrittr) #install.packages("magrittr")

#특정 테이블을 지정하는 방법

ribalta %>%
  html_nodes("table.food-items") %>%
  magrittr::extract2(5) %>%
  html_table()

# 6.8 JSON 데이터 읽기

library(jsonlite) #install.packages("jsonlite")

pizza <- fromJSON("https://www.jaredlander.com/data/PizzaFavorites.json")
pizza
