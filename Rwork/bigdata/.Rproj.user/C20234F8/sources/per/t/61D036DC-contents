install.packages("mongolite") #패키지 설치할 때는 큰따옴표 필요
library(mongolite) #라이브러리 올릴 때는 큰따옴표 없어도 인식
library("stringr")

#mongodb에 저장하기 위해서는 크롤링해야 한다.
# mongodb 커넥션
con <- mongo(collection = "crawl",
             db = "bigdata",
             url = "mongodb://127.0.0.1")


url <- "https://www.clien.net/service/group/community?&od=T31&po=0"
# readLines =inputStream과 비슷. 원격 서버 데이터, 파일 데이터도 읽을 수 있다. 
url_data <- readLines(url, encoding = "UTF-8") # url접속도 대신해줌(사이트에서 정보 받아옴) 
# 인코딩 확인!!
url_data
# 정보확인=============================
#class(url_data) #character
#length(url_data)
#head(url_data)
#tail(url_data)
# =====================================
url_data[200]
# 조건에 만족하는 데이터를 필터링
# 문자열에 패턴을 적용해서 일치여부를 T/F로 리턴

#### 데이터 필터링: title ####
# 1. str_detect(패턴을 검사할 문자열, 패턴)를 이용해서 웹페이지 전체에서 필요한 데이터만 먼저 추출 -> TRUE와 FALSE를 리턴
# 클래스명으로 뽑기
filter_data <- url_data[str_detect(url_data, "subject_fixed")] #TRUE와 FALSE로 나타나는 결과값을 배열에 넣으면 TRUE인 원소만 출력된다
filter_data

# 2. 추출한 데이터 전체에서 내가 필요한 문자열만 추출
# str_extract -> 패턴에 일치하는 문자열을 리턴
# 후방, 전방 탐색 정규 표현식
title <- str_extract(filter_data, "(?<=\">).*(?=</span>)")
title

#### 데이터 필터링: hit(조회수) ####
# 패턴: 큰따옴표는 앞에 \를 붙이면 문자로 인식한다.
# (자바스크립트는 작은따옴표)
# 태그로 뽑기
hit_data <- url_data[str_detect(url_data, "<span class=\"hit\">")]
hit_data
# 공지사항 제외
hit <- str_extract(hit_data, "(?<=\">).*(?=</span>)")[-1]
hit

#### 데이터 필터링: url ####
str_detect(url_data, "subject_fixed") 
#TRUE인 위치값에서 세 번 위로(중간에 공백 있음) 올라간 값을 뽑아낸다 = url위치
myurl <- url_data[which(str_detect(url_data, "subject_fixed"))-3]
myurl
url_val <- str_extract(myurl, "(?<=href=\").*(?=data-role)")
# 필요 없는 문자열을 잘라내기, end= -3 뒤에서 3개를 잘라내기
url_val <- str_sub(url_val, end= -3)
url_val <- paste0("https://www.clien.net",url_val)
url_val

# =>링크를 타고 타고 들어가서 크롤링 하는 상황에서 사용

#### csv파일로 생성 ####
final_data <- cbind(title, hit, url_val) # column bind
final_data
write.csv(final_data, "crawl_data.csv")
save(final_data, file = "crawl_data.RData") #R에서 사용하고 로딩하기 때문에 csv파일보다 로딩이 빠르다 => 몇만건 이상일 때는 R에서 작업할 때 빠르게 하기 위해 RData로 저장
length(title)
length(hit)
length(url_val)

#### mongodb에 저장하기 ####
# 기존에 저장되어 있는 것을 지우고 싶을 때
# con변수에는 자바에서 썼던것처럼 mongodb 함수를 지원해준다.
if(con$count()>0){
  con$drop()
}
final_data
class(final_data) #matrix
## mongodb에 데이터를 저장하기 위해서 dataframe으로 변환
final_data <- data.frame(final_data)
con$insert(final_data) #insert기본 타입은 data frame이어야 한다





