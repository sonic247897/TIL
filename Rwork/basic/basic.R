#R에서 사용하는 주석문
num = 100 #num이 100이다.
num
num <- 1000 #num변수에 1000을 저장하라는 의미
num
# =는 인식을 못하는 경우가 생기므로 <-를 써야한다.
num == 1000 #num이 1000과 같은지 비교: TRUE, FALSE(전부 대문자)
# T, F로 줄여 쓸 수도 있다.
num==100
num!=1000
num>100
num<100
#자바스크립트처럼 내부에 데이터타입이 존재한다.
test <- "myR"
test
myR <- num
test <- myR
test
"fasdfawefawefaweawe"

result1 <- 100 #숫자형
result1
result2 <- "test" #문자형
result2

#R에서 제공되는 함수를 이용할 수 있으며
#class함수는 타입을 확인
class(result1) #numeric
class(result2) #character
test <- as.character(result1)
test
class(test) #character
test <- as.numeric(result1)
test
class(test) #numeric
