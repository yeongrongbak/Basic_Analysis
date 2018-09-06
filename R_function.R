### Chapter 8. R 함수 작성 ###

# 파생변수 생성시 원하는 함수가 없다면 함수를 직접 생성해서 사용하기도 한다.

# 8.1 헬로 월드

say.hello <- function(){
  print("Hello, World!")
}

say.hello()

# 8.2 함수 인자

# 하나의 치환

sprintf("Hello %s", "Jared")

# 2개의 치환

sprintf("Hello %s, today is %s", "Jared", "Sunday")

hello.person <- function(name){
  print(sprintf("Hello %s", name))
}

hello.person("Jared")
hello.person("Bob")
hello.person("Sarah")

hello.person <- function(first, last){
  print(sprintf("Hello %s %s", first, last))
}

hello.person("Jared", "Lander")
hello.person(first="Jared", last="Lander")
hello.person(last="Lander", first="Jared")

# 8.2.1 디폴트 인자

# 8.2.2 부가 인자들

# 8.3 반환값

# 명시적인 return을 주지 않음

double.num <- function(x)
{
  x*2
}

double.num(5) 

# 명시적으로 return을 사용

double.num <- function(x)
{
  return(x*2)
}

double.num(5)

# 명시적으로 return을 사용한 다른 예

double.num <- function(x)
{
  return(x*2)
  print("hello!") # 한 번 return()이 실행되면 함수가 종료된다
  return(17)
}

double.num(5)

# 8.4 do.call
# 함수의 이름을 문자열이나 객체로 지정하고, 리스트를 갖고 해당 함수의 인자를 전달해 함수를 실행할 수 있다.
