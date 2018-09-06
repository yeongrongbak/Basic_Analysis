### Chapter.10 루프, R에서는 그다지 환영 받지 못하는 존재 ###

# for, while 루프를 사용
# R에서는 벡터화라는 개념을 사용하는 것이 권장

# 10.1 for 루프

for(i in 1:10){
  print(i)
}

print(1:10)

for(i in c(1,3,5,7,9)){
  print(i)
}

# 과일 이름을 가진 벡터

fruit <- c("apple", "banana", "pomegranate")

fruitLength <- rep(NA, length(fruit)) # fruit length만큼 NA를 반복

fruitLength

names(fruitLength) <- fruit

fruitLength

for(a in fruit) {
  fruitLength[a] <- nchar(a)
}

fruitLength

# 내장된 벡터화 연산

fruitLength2 <- nchar(fruit)

names(fruitLength2) <- fruit

fruitLength2

# 10.2 while 루프

x <- 1
while(x<=5){
  print(x)
  x <- x+1
}

# 10.3 루프 조절

for(i in 1:10){
  if(i==3){
    next
  }
  print(i)
}

for(i in 1:10){
  if(i==4){
    break
  }
  print(i) 
}

# 10.4 결론

# R에서는 벡터화나 행렬 연산을 주로 사용하고 루프 사용은 피하는 것이 바람직
# 중첩된 루프는 R에서 아주 느리게 처리된다