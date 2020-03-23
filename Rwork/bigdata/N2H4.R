#네이버 크롤링 라이브러리 - 다음도 있음
install.packages("N2H4")
library(N2H4)
library(stringr) 
library(dplyr) #체이닝 연산자

url <- "https://news.naver.com/main/read.nhn?mode=LSD&mid=shm&sid1=100&oid=020&aid=0003276790"
getAllComment(url) %>% 
  select(userName, contents) -> mydata #변수에 대입식 거꾸로 사용 가능
mydata
mycomment <- mydata$contents  
mycomment
