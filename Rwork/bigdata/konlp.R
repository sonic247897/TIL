# 더이상 R에서 지원x. 제일 유명한 라이브러리
# 블로그에서 KoNLP zip파일 받아서 R3.6.3의 library에 압축풀기
install.packages("KoNLP")
# install.packages로 KoNLP를 설치하지 못해서 의존모듈을 직접 설치해줘야 한다
# 의존모듈 설치: 사전
install.packages("Sejong")
install.packages("hash")
# R이랑 java랑 연동하는 패키지
install.packages("rJava")
install.packages("tau") #테이블셋
install.packages("RSQLite")
install.packages("devtools")
library(KoNLP)
library(stringr)

#### KoNLP의 함수를 테스트 ####
# 명사만 추출하는 함수
extractNoun("롯데마트가 판매하고 있는 흑마늘 양념 치킨이 논란이 되고 있다.")

SimplePos09("롯데마트가 판매하고 있는 흑마늘 양념 치킨이 논란이 되고 있다.")

convertHangulStringToJamos("R는 많은 공헌자에의한 공동 프로젝트입니다")

#### 분석할 샘플데이터 로딩 ####
load("comments.RData")
load("score.RData")

length(comments)
length(score)
head(comments, 10)
head(score, 10)

sampledata <- comments[1:1000]
class(sampledata)

#### 형태소 분석을 하기 위해서 명사 분리 ####
# list: 다른 길이의 데이터를 저장할 수 있는 자료구조
# 댓글을 분리하면 분리된 명사의 개수가 다르므로 리스트를 이용
data_list = list() 
for(i in 1:length(sampledata)){
  data <- SimplePos09(sampledata[i])
  data_list[[i]] <- data # 2차원 배열과 비슷한 개념
}
data_list[[2]]
head(data_list, 20)
# 명사는 한 단어에 하나만 있고, 앞에 위치한다
# /로 분할 - 리스트의 모든 요소에 저장된 문자열을 /로 분리
#             => N이 있는 문자열의 첫번째 요소 가져오기 
# sapply를 이용하면 반복작업을 할 수 있다.
# sapply(data.frame(test=c(1,2,3,4,5,6),
#                   test2=c(3,4,5,6,7,8)
#                   ), # 반복작업할 데이터
#        function(x){ #익명 함수
#          x[1]
#         } # 반복해서 적용할 함수
#        )
 # str_split은 기호를 기준으로 분리
class(data_list) #list
wordlist <- sapply(str_split(data_list, "/"), function(x){
                                              x[1]
                                          })
class(wordlist) #character
head(data_list, 20)
head(wordlist, 20) #제대로 분석되지 않음 - list인 채로 분석하면 list로 나온다

# sapply 함수 내부에서 요구되어지는 사항: list는 분석할 수 없다
class(unlist(data_list)) # character 벡터
wordlist <- sapply(str_split(unlist(data_list), "/"), function(x){
  x[1]
})
head(data_list, 20)
head(wordlist, 20)

# table함수를 이용해서 단어의 빈도수를 구하기
# table함수는 벡터에 저장되어 있는 모든 단어들의 빈도수를 계산해서 변환
# - 단어를 이용해서 변수명으로 사용
tablewordlist <- table(wordlist)
tablewordlist[1]
tablewordlist[89]
names(tablewordlist)

# 분석한 데이터를 이용해서 sort
sort(tablewordlist, decreasing = T)[1:100]
# 분석 결과를 가지고 기준을 적용해서 정리 - 한 글자수 빼기
nchar("글자수") #글자수 반환
tablewordlist_result <- tablewordlist[
                                nchar(names(tablewordlist)) >1 ]
tablewordlist_result <- sort(tablewordlist_result, decreasing = T)[1:100]
tablewordlist_result

# 감정분석 1. 머신러닝 2. 감정어 사전 
# 지수 계산해서 수치가 높은 쪽을 판단


