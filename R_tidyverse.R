### Chapter 15. 타이디버스로 데이터 재구조화 ###

# 해들리 위캄이 만든 패키지를 합쳐서 타이디버스라고 한다. (dplyr, tidyr)

# 15.1 행과 열을 붙이기

# dplyr 패키지에서 rbind와 cbind 역할을 하는 함수로 bind_rows와 bind_cols가 있다.
# 이들 함수들은 데이터 프레임(과 티블)에만 적용할 수 있따.

# dplyr 패키지 로딩

library(dplyr)
library(tibble)

# 2개의 열을 가진 티블 생성

sportLeague <- tibble(sport = c("Hotkey", "Baseball", "Football"),
                      league = c("NHL", "MLB", "NFL"))

# 하나의 열을 가진 티블 생성

trophy <- tibble(trophy = c("Stanley Cup", "Commissioner's Trophy",
                            "Vince Lombardi Trophy"))

# 하나의 티블로 결합

trophies1 <- bind_cols(sportLeague, trophy)

# 행에서 데이터를 지정하는 방식으로 새로운 티블을 만듦

trophies2 <- tribble(
  ~sport, ~league, ~trophy,
  "Basketball", "NBA", "Larry O'Brein Championship Trophy",
  "Golf", "PGA", "Wanamaker Trophy"
)

trophies <- bind_rows(trophies1, trophies2)
trophies

# 15.2 dplyr를 사용한 조인

library(readr)
colorsURL <- "http://www.jaredlander.com/data/DiamondColors.csv"
diamondColor <- read_csv(colorsURL)

# diamonds 데이터 로딩

data(diamonds, package= "ggplot2")
unique(diamonds$color)

head(diamonds)
head(diamondColor)

# 왼쪽 외부조인과 키 값 지정
# 왼쪽 외부조인은 왼쪽 테이블의 모든 행은 유지되고 오른쪽 테이블에서는 매칭되는 행들만 포함된다

library(dplyr)
left_join(diamonds, diamondColor, by=c('color'='Color'))

# 몇 개 열만 선택해서 확인

left_join(diamonds, diamondColor, by = c('color' ='Color')) %>%
  select(carat, color, price, Description, Details)

# diamondColor는 조인된 결과보다 더 많은 color, description 값에 대한 유니크한 값을 갖고 있다

left_join(diamonds, diamondColor, by=c('color'='Color')) %>%
  distinct(color, Description)

diamondColor %>% distinct(Color,Description)

# 오른쪽 외부조인을 하게 되면 diamondColor가 diamond보다 Color가 더 많은 유니크한 값을 가지고 있기 때문에 결과는 diamonds보다 더 많은 행을 가지게 된다.

right_join(diamonds, diamondColor, by=c('color'='Color')) %>% nrow
diamonds %>% nrow

# 내부조인(inner join)은 양쪽 테이블에서 모두 매칭되는 행들만 반환한다.
# 위 예시의 경우 left 조인과 inner 조인의 결과가 같다

all_equal(
  left_join(diamonds, diamondColor, by=c('color'='Color')),
  inner_join(diamonds, diamondColor, by=c('color'='Color'))
)

# 완전조인(full outer join)은 두 테이블에 있는 모든 행들을 반환한다.
# 위 예시의 경우 right 조인과 full outer 조인의 결과가 같다.

all_equal(
  right_join(diamonds, diamondColor, by=c('color'='Color')),
  full_join(diamonds, diamondColor, by=c('color'='Color')))

# 세미 조인은 두 테이블을 합치는 것은 아니고 오른쪽 테이블과 매칭되는 행에 왼쪽 테이블의 행의 첫 행들을 반환한다. (Vlookup)

semi_join(diamondColor, diamonds, by=c('Color'='color'))

# 안티 조인은 세미 조인의 반대다.

anti_join(diamondColor, diamonds, by=c('Color'='color'))

# 세미 조인이나 안티 조인은 filter, unique 함수를 사용해도 얻을 수 있다.

diamondColor %>% filter(Color %in% unique(diamonds$color))

# 15.3 데이터 포맷 변환
# 기존에 melt와 dcast 함수를 사용해 데이터를 변환
# tidyr 패키지는 reshape2 패키지의 차기버전
# 계산 속도보다는 사용 편의성이 용이해진 버전이다.

library(readr)
emotion <- read_tsv("http://www.jaredlander.com/data/reaction.txt")
emotion

# tidyr에서 gather 함수는 기존의 melt 함수와 같은 역할을 한다.

library(tidyr) #install.packages("tidyr")
emotion %>%
  gather(key=Type, value=Measurement, Age, BMI, React, Regulate)

# ID에 따라서 데이터를 재정렬

emotionLong <- emotion %>%
  gather(key=Type, value=Measurement, Age, BMI, React, Regulate) %>%
  arrange(ID)
head(emotionLong, 20)

# 마이너스 기호(-)를 사용해서 피벗팅을 하지 않을 열을 지정할 수 있다.

emotion %>%
  gather(key=Type, value=Measurement, -ID, -Test, -Gender)

identical(
  emotion %>%
    gather(key=Type, value=Measurement, -ID, -Test, -Gender),
  emotion %>%
    gather(key=Type, value=Measurement, Age, BMI, React, Regulate)
)

# tidyr에서 spread 함수는 reshape2 패키지의 dcast와 유사하다.

emotionLong %>%
  spread(key=Type, value=Measurement)