### Chapter 7. R 통계 그래프 ###

# 7.1 기본 그래픽스

library(ggplot2)
data(diamonds)
head(diamonds)

# 7.1.1 기본 히스토그램

hist(diamonds$carat, main = "Carat Histogram", xlab= "Carat") # 한 개 변수의 분포

# 7.1.2 기본 산점도

plot(price ~ carat, data=diamonds) # 두 개 변수의 관계

plot(diamonds$carat, diamonds$price) # 하나의 데이터 프레임에 함께 들어있지 않아도 plotting이 가능하다

# 7.1.3 상자 그림

boxplot(diamonds$carat)

# 7.2 ggplot2

# 7.2.1 ggplot2 히스토그램과 밀도 곡선

ggplot(data=diamonds) + geom_histogram((aes(x=carat)))

ggplot(data=diamonds) + geom_density(aes(x=carat), fill="grey50")

# 7.2.2 ggplot2 산점도

ggplot(diamonds, aes(x=carat, y=price)) + geom_point()

g <- ggplot(diamonds, aes(x=carat, y=price)) # ggplot 객체를 변수에 저장

g + geom_point(aes(color=color))

g + geom_point(aes(color=color)) + facet_wrap(~color) # 어떤 변수의 레벨에 따라 데이터를 세분화

g + geom_point(aes(color=color)) + facet_grid(cut ~ clarity) # 어떤 변수의 모든 레벨을 하나의 행이나 열에 할당

#패싯팅(faceting)은 히스토그램이나 다른 지옴에서도 사용 가능하다

ggplot(diamonds, aes(x= carat)) + geom_histogram() + facet_wrap(~color)

# 7.2.3 ggplot2 상자그림과 바이올린 플롯

ggplot(diamonds, aes(y=carat, x=1)) + geom_boxplot()

ggplot(diamonds, aes(y=carat, x=cut)) + geom_boxplot() # level 별로 plotting

ggplot(diamonds, aes(y=carat, x=cut)) + geom_violin()

#레이어의 순서에 따라 다른 plotting (비교)

ggplot(diamonds, aes(y=carat, x=cut)) + geom_point() + geom_violin()
ggplot(diamonds, aes(y=carat, x=cut)) + geom_violin() + geom_point()

# 7.2.4 ggplot2 꺾은선 그래프

ggplot(economics, aes(x=date, y=pop)) + geom_line()

library(lubridate) #install.packages("lubridate")

#year, month 변수 생성
economics$year <- year(economics$date)
#다음 label 인자는 월을 숫자가 아닌 이름으로 반환하게 한다
economics$month <- month(economics$date, label=TRUE)

#조건이 참인 경우에 해당하는 인덱스를 반환한다.
ind <- which(economics$year >= 2000)
econ2000 <- economics[ind,]

econ2000 <- economics[which(economics$year >= 2000),]

#축 포맷팅을 위해서 scales 패키지를 로딩
library(scales) #install.packages("scales")

#플롯의 초기화
g <- ggplot(econ2000, aes(x=month, y=pop))

#선들을 색으로 코드화하고, year에 따라 그룹화한다.
#group 에스테틱은 데이터를 별도의 그룹으로 세분화한다.

g<- g + geom_line(aes(color=factor(year), group=year))

#레전드 이름을 Year로 한다

g<- g+scale_color_discrete(name ="Year")

#y축 포맷

g<- g+scale_y_continuous(labels = comma)

#제목과 축 레이블 추가

g<- g+labs(title="Population Growth", x="Month", y="Population")

#플롯출력
g

# 7.2.5 테마

library(ggthemes) #install.packages("ggthemes")

g2 <- ggplot(diamonds, aes(x=carat, y=price)) + geom_point(aes(color=color))

#테마 설정
g2 + theme_economist() + scale_colour_economist()
g2 + theme_excel() + scale_colour_excel()
g2 + theme_tufte()
g2 + theme_wsj()
