### Chapter 13. purrr 패키지를 사용한 순회 ###

theList <- list(
  A = matrix(1:9, 3),
  B = 1:5,
  C = matrix(1:4, 2),
  D = 2)

lapply(theList, sum)

library(purrr) #install.packages("purrr")

theList %>% map(sum)

theList2 <- theList
theList2[[1]][2,1] <- NA
theList2[[2]][4] <- NA
theList2 %>% map(sum)

theList2 %>% map(function(x) sum(x, na.rm=TRUE))

theList2 %>% map(sum, na.rm=TRUE)

# 13.2 반환 값의 유형을 정의한 map 함수

# 13.2.1 map_int

theList %>% map_int(NROW)

theList %>% map_int(mean)

# 13.2.2 map_dbl

theList %>% map_dbl(mean)

# 13.2.3 map_chr

theList %>% map_chr(class)

theList3 <- theList
theList3[['E']] <- factor(c("A","B","C"), ordered = T)
class(theList3$E)

theList3 %>% map(class)

# 13.2.4 map_lgl

theList %>% map_lgl(function(x) NROW(x) < 3)

# 13.2.5 map_df

buildDF <- function(x){
  data.frame(A = 1:x, b=x:1)
}
listOfLengths <- list(3, 4, 1, 5)

listOfLengths %>% map(buildDF)

listOfLengths %>% map_df(buildDF)

# 13.2.6 map_if

theList %>% map_if(is.matrix, function(x) x*2)

theList %>% map_if(is.matrix, ~.x*2)
