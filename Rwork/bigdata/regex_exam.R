#정규표현식을 실행하거나 문자열을 가지고 작업할 때 사용하는 패키지
library("stringr") 
#패턴
mytext <- "     test$uuuuu"
mytext2 <- "https://cran.r-project.org/"
# 패턴을 실행해주는 함수
# 자바처럼 패턴과 일치하는 문자열도 리턴
str_extract(mytext2, ".+(:)") # 기호()- 하나로 묶어주는 용도로 사용
# .+의 뜻은 : 앞에 문자가 여러개 와도 된다는 뜻

#### 전방탐색 #####
# 패턴과 일치하는 문자를 찾아 일치 문자 바로 전까지 리턴
str_extract(mytext2, ".+(?=:)") # ?=(전방탐색. 자바에서도 사용 가능)

#### 후방탐색 ####
# 패턴과 일치하는 문자를 찾아 일치 문자 뒤부터 리턴
str_extract(mytext, "(?<=\\$).*") # ?<= 후방탐색
# $를 인식시키려면 \\붙여줘야 함

## 전방탐색과 후방탐색은 DOM탐색하거나, 웹페이지에서 사이의 문자열을 추출하는데 많이 사용된다.

#문자열 관련 함수
# paste - 벡터를 연결해서 하나의 문자열로 생성
# paste0 - 여러 개를 연결
str <- c("java", "hadoop", "R", "mongodb")
paste(str, collapse = " ") #어떤 기호를 이용해서 연결할 건지
paste(str, collapse = ",")
paste0(mytext, mytext2)
# 문자열 안의 특정 문자열을 replace
# 아무것도 안 주면 잘라버리는 효과 줄 수 있다!
data <- gsub("u", "", mytext) # 문자 치환
data
str_trim(data) #앞뒤로 공백 없애줌


