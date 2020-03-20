#dataframe 만들기 - 1. matrix를 dataframe으로 변환
#                   2. 벡터를 여러개 만들어서 dataframe을 작성
eng <- c(100,99,90)
math <- c(100,99,100)
mydf1 <- data.frame(eng,math)
mydf1
mean(mydf1$eng)
mean(mydf1$math)

# 3. dataframe을 직접 정의
mydf2 <- data.frame(eng=c(100,100,100),
                    math = c(90,90,90)) #매개변수에 바로 넣어서 생성
mydf2

#생성이 완료되어 사용중인 matrix, dataframe의 행과 열을 변경
m <- matrix(1:15, ncol = 3, byrow = T)
m
m <- t(m) #transform
m

d <- data.frame(m)
d 
d <- t(d)
d

##실습 p.88
제품 <- c("사과","딸기","수박")
가격 <- c(1800,1500,3000)
판매량 <- c(24,38,13)
df1 <- data.frame(제품,가격,판매량)
df1
price_avg <- mean(df1$가격)
sales_avg <- mean(df1$판매량)
price_avg
sales_avg
##


