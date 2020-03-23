library(mongolite)
library("stringr")

load(file = "crawl_data.RData")
final_data
url_list <- final_data[,3]
class(url_list) # basic_crawling_mongodb.R을 실행해야 character로 출력. 아니면 factor로 출력된다.

#### 웹페이지 데이터 가져오기 ####
contentdata <- readLines(url_list[1], encoding = "UTF-8")
#tail(contentdata)
class(contentdata) #character인데 한줄 한줄이 vector로 들어갔다=> vector연산 가능
# 데이터프레임, 매트릭스, 벡터 => 벡터연산 가능

#### 원하는 부분만 가지고 오기 ####
start = which(str_detect(contentdata, "post_content"))
end = which(str_detect(contentdata, "post_ccls"))
start #vector number
end
content_filter_data <- contentdata[start:end]
content_filter_data

#### 데이터 정제하기 ####
# 1. 벡터로 리턴하므로 한 개로 합치기
content_filter_data <- paste(content_filter_data, collapse = "")
content_filter_data
# 2. 불필요한 기호나 태그 없애기
# 태그 없애기 - ?: >으로 끝났을 때 (연속되어 있는 데이터)
content_filter_data <- gsub("<.*?>", "", content_filter_data)
content_filter_data
content <- gsub("\t|&nbsp;","",content_filter_data) #연속되지 않은 기호 지울 때는 그냥 |로 써줘도 된다
content
