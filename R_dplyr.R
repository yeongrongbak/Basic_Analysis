### Chapter 12. dplyr 패키지로 빠르게 그룹 단위로 데이터 다루기 ###

library(plyr) # install.packages("plyr")
library(dplyr) # install.packages("dplyr")

# dplyr를 사용한 데이터 먼징 작업이 사실상의 표준 방법이 되어가고 있다.
# select, filter, group_by, mutate 등의 함수가 존재한다
# plyr과 dplyr를 동시에 사용하는 경우 plyr를 먼저 로딩하는 것이 중요
# Why? 같은 이름을쓰는 함수가 많은데 R에서는 마지막 패키지의 함수가 우선 적용

# 12.1 파이프(Pipes)
# 파이프를 사용하면 앞의 함수가 반환한 객체를 다음 함수의 첫 번째 인자로 보낸다.

library(magrittr)
data(diamonds, package="ggplot2")

dim(head(diamonds, n=4))

diamonds %>% head(4) %>% dim

# 12.2 tbl
# tbl 객체를 통해 데이터 프레임을 확장한다.

library(ggplot2)
class(diamonds)
head(diamonds)

library(dplyr)
head(diamonds)

# tble은 자동으로 일부 행만 보여주기 때문에 굳이 head를 쓸 필요가 없다.

diamonds

# 12.3 select
# select 함수는 첫 번째 인자로 데이터 프레임 또는 tbl 객체를 받고, 그 다음은 원하는 열들을 이름을 인자로 취한다.

select(diamonds, carat, price)

diamonds %>% select(carat, price)

diamonds %>% select(c(carat, price))

diamonds %>% select_('carat', 'price') # select_ 함수는 더 이상 쓰지 않도록 권고 되고 있는 중이다.

theCols <- c('carat', 'price')
diamonds %>% select_(.dots = theCols)

diamonds %>% select(one_of('carat','price')) # select_ 의 대안으로 사용하고 있는 방법이다.

theCols <- c('carat', 'price')
diamonds %>% select(one_of(theCols))

diamonds[, c('carat', 'price')] # 전통적인 R의 꺾쇠 괄호를 사용해도 그대로 적용이 된다.

select(diamonds, 1, 7) # 열 이름 대신 인덱스를 사용할 수 있다.

diamonds %>% select(1,7)

# 열 이름에 대해 부분 매칭을 사용해 검색하는 경우 starts_with, ends_with, contaions 라는 dplyr 함수들을 사용한다.

diamonds %>% select(starts_with('c'))

diamonds %>% select(ends_with('e'))

diamonds %>% select(contains('l'))

diamonds %>% select(matches('r.+t')) # 정규 표현식에 대한 검색으로는 matches 함수를 사용

diamonds %>% select(-carat, -price) # 마이너스 기호는 해당 열을 제외

diamonds %>% select(-c(carat, price))

diamonds %>% select(-1, -7)

diamonds %>% select(-c(1,7))

# 12.4 filter
# 논리 값에 기반해 특정 행을 고를 때 사용

diamonds %>% filter(cut =="Ideal")

diamonds[diamonds$cut == "Ideal",] # Base R 에서의 방법

# 어떤 열의 값이 여러 가능한 값 가운데 하나라도 맞는 행들을 필터링

diamonds %>% filter(cut %in% c("Ideal", "Good"))

# 모든 표준 비교 연산자들을 filter에서 사용 가능하다

diamonds %>% filter(price >=1000)

diamonds %>% filter(price !=1000)

# 복잡한 필터링 조건은 콤마(,)나 앰퍼샌드(&) 기호를 사용해 만들 수 있다.

diamonds %>% filter(carat>2, price<14000)

diamonds %>% filter(carat>2 & price<14000)

diamonds %>% filter(carat<1 | carat >5)

head(diamonds)

# 12.5 slice
# slice 함수는 행 번호를 가지고 행을 필터링 한다.

diamonds %>% slice(1:5)

diamonds %>% slice(c(1:5, 8, 15:20))

diamonds %>% slice(-1) # 인덱스를 음수로 정하면 해당 행은 제외한다.

# 12.6 mutate
# 새로운 열을 추가하거나 기존의 열로부터 새로운 열을 만들어 추가할 때 사용

diamonds %>% mutate(price/carat)

# 새롭게 추가한 열이 잘 보이도록 하려면, 관심 있는 열들을 select 함수를 써서 선택하고 그것을 mutate 함수로 파이핑하는 방법을 사용.

diamonds %>% select(carat, price) %>% mutate(price/carat)

# 새롭게 생성한 변수에 대한 이름 부여

diamonds %>% select(carat, price) %>% mutate(Ratio=price/carat)

# mutate 함수로 생성되는 열들은 같은 mutate 함수 호출에서 곧바로 사용 가능

diamonds %>%
  select(carat, price) %>%
  mutate(Ratio = price/carat, Double = Ratio*2)

# (주의) 변경된 내용을 저장하기 위해서는 새로운 결과를 명시적으로 저장해야 한다.

# magrittr 패키지의 기능 중 할당 파이프(%<>%)를 사용하면 된다
# 할당 파이프는 왼쪽에 있는 것을 오른쪽에 파이핑 함과 동시에 그 결과를 다시 왼쪽에 할당한다.

library(magrittr)
diamonds2<- diamonds
diamonds2

diamonds2 %<>%
  select(carat,price) %<>%
  mutate(Ratio=price/carat, Double=Ratio*2)

diamonds2

# 전통적인 할당 연산자를 사용해도 된다.

diamonds2 <- diamonds2 %>%
  mutate(Quadruple = Double *2)

diamonds2

# 12.7 summarize

summarize(diamonds, mean(price))

diamonds %>% summarize(mean(price))

# 이름 부여 가능

diamonds %>%
  summarize(AvgPrice = mean(price),
            MedianPrice = median(price),
            AvgCarat = mean(carat))

# 12.8 group_by
# 그룹 별 요약 통계량 산출에 매우 유용

diamonds %>%
  group_by(cut) %>%
  summarize(AvgPrice = mean(price))

diamonds %>%
  group_by(cut) %>%
  summarize(AvgPrice = mean(price), SumCarat=sum(carat))

diamonds %>%
  group_by(cut, color) %>%
  summarize(AvgPrice = mean(price), SumCarat=sum(carat))

# 12.9 arrange

# 오름차순

diamonds %>%
  group_by(cut) %>%
  summarize(AvgPrice = mean(price), SumCarat = sum(carat)) %>% arrange(AvgPrice)

# 내림차순

diamonds %>%
  group_by(cut) %>%
  summarize(AvgPrice = mean(price), SumCarat = sum(carat)) %>% arrange(desc(AvgPrice))

# 두 가지 조건 (1순위, 2순위)

diamonds %>%
  group_by(cut) %>%
  summarize(AvgPrice = mean(price), SumCarat = sum(carat)) %>% arrange(AvgPrice, SumCarat)

# 12.10 do 함수
# filter, mutate, summarise 등과 같은 조작함수로 다루지 못하는 계산은 do 함수를 사용해 해결한다.

topN <- function(x, N=5){
  x %>% arrange(desc(price)) %>% head(N)
}

diamonds %>% group_by(cut) %>% do(topN(., N=3))

# 12.11 데이터베이스와 dplyr 사용

download.file("http://www.jaredlander.com/data/diamonds.db",
              destfile = "data/diamonds.db", mode='wb')

library(dbplyr)#install.packages("dbplyr")
diaDBSource <- src_sqlite("data/diamonds.db")
diaDBSource

diaDBSource2 <- DBI::dbConnect(RSQLite::SQLite(), "data/diamonds.db")
diaDBSource2

diaTab <- tbl(diaDBSource, "diamonds")
diaTab

diaTab %>% group_by(cut) %>% summarize(Price=mean(price, na.rm=T))

diaTab %>% group_by(cut) %>%
  summarize(Price = mean(price,na.rm=T), Carat = mean(Carat,na.rm=T))
