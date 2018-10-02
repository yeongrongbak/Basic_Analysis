# 25.1 K-means

### 데이터 로드
wineUrl <- "http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data"

wine <- read.table(wineUrl, header=FALSE, sep=',',
                   stringsAsFactors = FALSE,
                   col.names=c("Cultivar", "Alcohol", "Malic.acid",
                               "Ash", "Alcalinity.of.ash",
                               "Magnesium", "Total.phenols",
                               "Flavanoids", "Nonflavnoid.phenols",
                               "Proanthocyanin", "Color.intensity",
                               "Hue", "OD280.OD315.of.diluted.wines",
                               "Proline"))
head(wine)

### Cultivar 변수 삭제
wineTrain <- wine
wineTrain$Cultivar<-NULL

### k-means의 클러스터 개수 결정을 위한 total.withinss값 추출
i<-3
for (i in 1:15) {
  km<-kmeans(x=wineTrain, centers=i)
  if (i==1) tw<-km$tot.withinss else tw<-c(tw,km$tot.withinss)
}

plot(tw)

### 결정된 cluster 개수에 대한 군집 실시 및 cluster별 mean을 data.frame으로 저장
set.seed(278613)
wineK4 <- kmeans(wineTrain, centers=4)
(wn_ctr<-as.data.frame(wineK4$centers))

### 원 데이터에 cluster 결과를 추가
head(wineTrain)
wineTrain$cls <- wineK4$cluster

### duncan.test 패키지 설치
install.packages("agricolae")
library(agricolae)

### Duncan.test (ANOVA결과를 전달하기 위해 생성)
aov_Alcoh<-aov(Alcohol ~ cls, wineTrain)
(dc_Alcoh<-duncan.test(aov_Alcoh,"cls",console=T))

### Duncan.test 결과를 cluster center에 투입
# Cluster의 관심 대상 변수로 내림차순으로 정렬
wn_ctr<-wn_ctr[order(wn_ctr$Alcohol, decreasing=T),]
wn_ctr

# Duncan.test 결과를 투입
wn_ctr$dc_Alc<-dc_Alcoh$group$groups
wn_ctr[,c("Alcohol","dc_Alc")]
dc_Alcoh$group
