### Chapter 9. 제어문 ###

# 9.1 if와 else

as.numeric(TRUE)

as.numeric(FALSE)

toCheck <- 1

if(toCheck ==1){
  print("hello")
}

if(toCheck==0){
  print("hello")
}

check.bool <- function(x){
  if(x==1){
    print("hello")
  } else {
    print("goodbye")
  }
}

check.bool(1)
check.bool(0)
check.bool("k")
check.bool(TRUE)

check.bool <- function(x){
  if(x==1){
    print("hello")
  } else if(x==0){
    print("goodbye")
  } else{
    print("confused")
  }
}

check.bool(1)
check.bool(0)
check.bool("k")

# 9.2 switch

# else if 문을 반복적으로 사용하는 것은 효율적이지 않다
# 이런 경우에서 switch가 가장 유용하다

use.switch <- function(x){
  switch(x,
         "a"="first",
         "b"="second",
         "z"="last",
         "c"="third",
         "other")
}

use.switch("a")
use.switch("b")
use.switch("c")
use.switch("d")
use.switch("e")
use.switch("z")

use.switch(1)
use.switch(2)
use.switch(3)
use.switch(4)
use.switch(5)
use.switch(6) # 아무것도 반환하지 않음
is.null(use.switch(6))

# 9.3 ifelse

# 1과 1이 같은지 확인

ifelse(1==1, "Yes", "No")

# 1과 0이 같은지 확인

ifelse(1==0, "Yes", "No")

# 벡터 인자 사용

toTest <- c(1,1,0,1,0,1)

ifelse(toTest == 1, "Yes", "No")

ifelse(toTest == 1, toTest *3, toTest)

ifelse(toTest == 1, toTest *3, "Zero")

# NA 값이 있는 경우

toTest[2] <- NA

ifelse(toTest==1, "Yes", "No")

ifelse(toTest == 1, toTest *3, toTest)

ifelse(toTest == 1, toTest *3, "Zero")

