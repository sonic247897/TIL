#수치형 변수
#정수 - integer(int), R에서 다루는 모든 숫자 - numeric
num1 <- 10
class(num1) #numeric: 기본 R의 숫자 타입(실수)
num2 <- 10L
class(num2) #integer(정수)
result <- num1+num2
result
class(result) #numeric <- integer와 numeric의 계산결과

