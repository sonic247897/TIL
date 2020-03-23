#css의 선택자를 활용할 수 있는 방법 - rvest
install.packages("rvest")
library(rvest)

url <- "https://www.clien.net/service/group/community?&od=T31&po=0"
readPage <- read_html(url)

# jQuery함수와 비슷하다
# html_nodes(선택자): 일치하는 모든 태그를 추출
# html_node(선택자): 일치하는 태그 한 개
# html_text(): 텍스트를 추출
# html_children(): 하위 노드 추출
# html_attr(): attribute 추출

readPage %>% 
  # 이런 이름으로 되어 있는 모든 tag를 뽑아옴
  html_nodes("span.subject_fixed") %>% 
  html_text() -> title_data  # DOM기반: node=tag 
title_data

# 이걸로 딱 맞아떨어지지 않는 경우에는 어쩔수없이 final_crawl.R을 쓰지만 보통 이 방법을 사용한다.