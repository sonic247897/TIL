####외부데이터 읽어오기(데이터 정제하기)####

####csv파일 읽기####
# 가정: csv의 한 컬럼에 모든 데이터가 ,로 묶여서 들어가 있을 때 데이터 정제하는 법
#readLines를 이용하면 데이터가 커도 어떤 구성인지 확인하기 편하다
dfimport <- readLines("01_csv.csv", n=3) 
dfimport

#csv파일이므로 ,로 구분이 되어 있지만 사용자가 원하는 구분자를 적용해서 작성한 문자열인 경우
#01_csv.csv 읽은 내용을 가공해서 데이터프레임을 작성
dfcsv <- data.frame(num=1:3, 
                    mydata=dfimport,
                    stringsAsFactors = FALSE)
dfcsv
class(dfcsv)
dfcsv$mydata #컬럼 안의 문자열에 ,가 추가된 상태
#,로 분리는 되지만 list로 결과가 리턴되어 불편하다.
strsplit(dfcsv$mydata, split = ",") #결과가 list로 나온다(size, type이 제각각)
class(strsplit(dfcsv$mydata, split = ","))
strsplit(dfcsv$mydata, split = ",")[[1]]
strsplit(dfcsv$mydata, split = ",")[[2]]

#하나의 컬럼 안에 구분자로 텍스트가 구성된 경우 분리
install.packages("splitstackshape")
library("splitstackshape")
dfcsv2 <- cSplit(indt = dfcsv, #처리할 df
                 splitCols = "mydata", #split할 컬럼명
                 sep=",") #separator
dfcsv2
class(dfcsv2) #data table이기도 하고 data frame이기도 함
# cSplit하면서 data table의 속성도 갖게 되어서 다시 하나의 타입으로 바꿔줘야 한다.
# 타입변경
# as의 함수들을 이용해서 변경. as는 ~~~가 아닌 것을 ~~~로 변경한다는 의미
# - data.table과 data.frame의 속성을 갖고 있는 dfcsv2를 
dfcsv2 <- as.data.frame(dfcsv2)
class(dfcsv2)
class(dfcsv2$num) #integer
class(dfcsv2$mydata_1) #factor
class(dfcsv2$mydata_2) #factor
class(dfcsv2$mydata_3) #factor
class(dfcsv2$mydata_4) #factor
class(dfcsv2$mydata_5) #factor
class("dd")
dfcsv2
str(dfcsv2) #전체 데이터의 구조를 확인
#변환한 데이터들의 타입이 Factor
#Factor는 순서와 명목형
#1,2,3,....의 값이 어떤 순서를 의미하는 경우: 컬럼의 데이터가 순서형
#class컬럼 1,2,3,4,...: 순서를 의미하지 않고 1반, 2반, 3반,.. 자체로 의미가 있는 것 => 순서가 적용되도록 정의된 Factor타입을 일반 char로 변경
#1번 컬럼을 뺀 나머지 컬럼의 타입을 char로 변환
for(i in 2:ncol(dfcsv2)){ #ncol():컬럼의 개수 세주는 함수
  dfcsv2[,i] = as.character(dfcsv2[,i])
}

str(dfcsv2)

####tsv파일 읽기####
#tab으로 구분된 파일(\t) 읽기 - 읽기만 달라지고 처리는 다 똑같다!
df3 <- read.delim("02_tsv.txt", sep="\t") #delim: StringTokenizer와 비슷
head(df3)

####xml파일 읽기####
install.packages("XML")
library("XML")
?xmlTreeParse
#기본 정보 포함
dfxml <- xmlTreeParse("03_xml.xml")
dfxml
#root element와 하위 엘리먼트만 추출
dfxml <- xmlRoot(dfxml)
dfxml

#xml에 있는 모든 태그의 name과 value를 추출(데이터 정제)
#-XXXApply함수는 for문 대신으로 사용할 수 있는 함수[문서의 종류마다 이름이 다르다]
#-depth=2라서 두번 밖에 안 돌았다
dfxml <- xmlSApply(dfxml, function(x){
                  xmlSApply(x,xmlValue) #x로 전달받은 값을 정제하여 xmlValue로 뽑아냄
                }) 
dfxml
dfxml <- data.frame(t(dfxml),row.names = NULL)
dfxml

####xlsx(액셀)파일 읽기####
install.packages("readxl")
library("readxl")
# xls: 예전 확장자
dfxlsx <- read_xlsx("07_xlsx.xlsx")
dfxlsx #tibble타입 => data.frame과 비슷한 다른 종류의 라이브러리



