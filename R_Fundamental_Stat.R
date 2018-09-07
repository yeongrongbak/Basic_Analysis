### Chapter 8. 기초 통계학 ###

# 18.1 요약 통계

x <- sample(x = 1:100, size = 100, replace = T)

summary(x)

# 18.2 상관과 공분산

library(ggplot2)

head(economics)

cor(economics$pce, economics$psavert)

# 여러 변수간의 상관계수를 한꺼번에 계산

cor(economics[, c(2,4:6)])

# 상관계수에 대한 시각화 install.packages("GGally")

GGally::ggpairs(economics[,c(2,4:6)]) +
  ggplot2::theme(axis.text=ggplot2::element_text(size=2))

# 데이터를 녹이기 위해서 reshape2 패키지를 로딩

library(reshape2)

# ggplot을 만들 때 추가 기능을 위해 scales 패키지 로딩

library(scales)

# 상관 행렬 만들기

econCor <- cor(economics[,c(2,4:6)])

# 롱 폼으로 변환

econMelt <- melt(econCor, varnames = c('x','y'), value.name='Correlation')

# 상관 계수에 따라서 정렬

econMelt <- econMelt[order(econMelt$Correlation),]

# 데이터 확인

econMelt

# ggplot으로 플롯팅

ggplot(econMelt, aes(x=x, y=y)) +
  geom_tile(aes(fill=Correlation))+
  scale_fill_gradient2(low=muted("red"), mid = "white", high="steelblue",
                       guide = guide_colourbar(ticks=F, barheight=10),
                       limits = c(-1,1)) +
  theme_minimal() +
  labs(x=NULL, y=NULL)

# 18.3 t- 검정

data(tips, package = "reshape2")

head(tips)

unique(tips$sex)

unique(tips$day)

# 18.3.1 단일 표본 t 검정

t.test(tips$tip, alternative = "two.sided", mu=2.50)

t.test(tips$tip, alternative = "greater", mu=2.50)

# 18.3.2 이표본 t 검정 : 두 집단 간의 평균 차이

# 18.3.3 짝 t 검정 : 같은 집단에 대해 변화 전 후의 차이 비교

# clustering 이후 t-test 하는 것 : 군집 간 특정 변수의 평균을 비교하고 각 그룹의 평균이 차이가 있는지에 대해 알고 싶을 때 많이 사용한다.

# 18.4 ANOVA : 여러 그룹에 대한 차이 비교