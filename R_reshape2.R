# 14.3 reshape2 패키지
# 데이터를 녹이는 일(열 방향의 데이터를 행 방향으로 전환)
# 데이터를 주조하는 일(행 방향의 데이터를 열 방향으로 전환)

# 14.3.1 melt 함수

head(Aid_00s) # 하나의 연도가 하나의 열을 차지하고 있다.

# 하나의 행이 하나의 국가-프로그램-연도 항목에 대한 금액을 표시하고 싶다.

library(reshape2) #install.packages("reshape2")

melt00 <- melt(Aid_00s, id.vars = c("Country.Name","Program.Name"),
               variable.name = "Year", value.name = "Dollars")

tail(melt00, 10)

# 각 프로그램에 대해 시간의 변화에 따라 어떻게 지원금이 변했는지 확인

library(scales)
library(stringr)
library(ggplot2)

# Year 열에서 앞의 FY를 제거해 숫자로 변경
melt00$Year <- as.numeric(str_sub(melt00$Year, 3,6))

# 데이터를 연도에 따라서 집계
meltAgg <- aggregate(Dollars ~ Program.Name + Year, data=melt00,
                     sum, na.rm=TRUE)

head(meltAgg)

# 프로그램 이름에서 앞의 10 문자만 유지한다.

# 다음 플롯을 그린다

meltAgg$Program.Name <- str_sub(meltAgg$Program.Name, start=1, end=10)
ggplot(meltAgg, aes(x=Year, y=Dollars))+
  geom_line(aes(group = Program.Name)) +
  facet_wrap(~ Program.Name) +
  scale_x_continuous(breaks = seq(from=2000, to=2009, by=2))+
  theme(axis.text.x = element_text(angle=90, vjust=1, hjust=0))

# 14.3.2 dcast 함수
# 녹인 데이터를 와이드 포맷으로 변형

cast00 <- dcast(melt00, Country.Name + Program.Name ~ Year,
                value.var = "Dollars")
head(cast00)

