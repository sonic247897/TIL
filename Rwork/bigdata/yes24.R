library(rvest)

url <- "http://www.yes24.com/searchcorner/Search?keywordAd=&keyword=&qdomain=%c0%fc%c3%bc&query=%c0%da%b9%d9&domain=BOOK&disp_no=001001003&scode=007_001"
readPage <- read_html(url)

# jQuery함수와 비슷하다
# html_nodes(선택자): 일치하는 모든 태그를 추출
# html_node(선택자): 일치하는 태그 한 개
# html_text(): 텍스트를 추출
# html_children(): 하위 노드 추출
# html_attr(): attribute 추출

readPage %>% 
  html_nodes("p.goods_name") %>% 
  html_text() -> title_data  
title_data 
