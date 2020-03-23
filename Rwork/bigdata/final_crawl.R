##### 모두의 광장의 1페이지:10페이지의 모든 게시글 크롤링 ####
# 1. 모든 페이지의 title, hit, url, content 추출하기
# 2. crawl_result.csv, crawl_result.RData 저장
# 3. mongodb 저장 (300개 저장)
# 4. for, if문을 활용

library(mongolite) #라이브러리 올릴 때는 큰따옴표 없어도 인식
library("stringr")

con <- mongo(collection = "crawl",
             db = "bigdata",
             url = "mongodb://127.0.0.1")

# 0번부터 9번 페이지까지 반복 작업
final_data_list = NULL
for(i in 0:9){
  # 페이지마다 연결할 주소가 달라지므로 변수로 처리
  myurl <- paste0("https://www.clien.net/service/group/community?&od=T31&po=",i)
  url_data <- readLines(myurl, encoding = "UTF-8") 

  #### title 추출 ####
  final_filter_data <- url_data[str_detect(url_data, "subject_fixed")] 
  title <- str_extract(final_filter_data, "(?<=\">).*(?=</span>)")
  #### hit 추출 ####
  hit_data <- url_data[str_detect(url_data, "<span class=\"hit\">")]
  hit <- str_extract(hit_data, "(?<=\">).*(?=</span>)")[-1]
  
  #### url 추출 ####
  str_detect(url_data, "subject_fixed") 
  myurl <- url_data[which(str_detect(url_data, "subject_fixed"))-3]
  url_val <- str_extract(myurl, "(?<=href=\").*(?=data-role)")
  url_val <- str_sub(url_val, end= -3)
  url_val <- paste0("https://www.clien.net",url_val)
  
  ########## url을 이용해서 content항목 추출 ########
  contentlist = NULL #최초 변수 선언시 null로 초기화
  content_filter_data = NULL
  for(page in 1:length(url_val)){
    #데이터 가져오기
    contentdata <- readLines(url_val[page], encoding = "UTF-8")
    start = which(str_detect(contentdata, "post_content"))
    end = which(str_detect(contentdata, "post_ccls"))
    #정제
    content_filter_data <- contentdata[start:end]
    content_filter_data <- paste(content_filter_data, collapse = "")
    content_filter_data <- gsub("<.*?>", "", content_filter_data)
    content <- gsub("\t|&nbsp;","",content_filter_data)
    
    # 벡터니까 c로 삽입입해야 함
    # 기존에 저장되어 있는 contentlist의 내용에 추가
    contentlist <- c(contentlist, content_filter_data)
    ## cat: 디버깅!
    #cat("\n", page)
    }
  # 페이지가 바뀔때마다 arra list같은 것에 final_data를 쌓아야 한다.  
  final_data <- cbind(title, hit, url_val, contentlist)
  # 기존에 final_data_list에 있던 것과 연결하면 된다(rbind로 밑으로 붙여준다)
  final_data_list <- rbind(final_data_list, final_data)
  #cat("\n", i)
}

#### csv파일로 생성 ####
write.csv(final_data_list, "final_data.csv")
save(final_data_list, file = "final_data.RData") 

#### mongodb에 저장하기 ####
if(con$count()>0){
  con$drop()
}
final_mongo_data <- data.frame(final_data_list)
con$insert(final_mongo_data)
  


