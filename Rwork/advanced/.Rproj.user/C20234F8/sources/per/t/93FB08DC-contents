#data.table - dataframe보다 강력
# install packages와 library는 맨 위에 모아놓는다
install.packages("data.table")
library("data.table")

df <- data.frame(mydata1=1:5,
                 mydata2=letters[1:5], # letters는 a~z까지의 알파벳 소문자
                 mydata3=c("이민호","android", "@!한글$#","test","한글")) 
#dataframe이므로 사이즈가 같아야 한다.
df
# #### 4개를 쓰면 북마크로 사용할 수 있다.
####파일write####
write.csv(df, "encoding_test.csv", row.names = FALSE)
#한글 안깨짐
write.csv(df, "encoding_test_euckr.csv", row.names = FALSE, fileEncoding = "euc-kr")
#한글 안깨짐
write.csv(df, "encoding_test_cp949.csv", row.names = FALSE, fileEncoding = "cp949")
#한글 깨짐
write.csv(df, "encoding_test_utf8.csv", row.names = FALSE, fileEncoding = "utf8")



####깨진파일 처리하기####
read.csv("encoding_test_utf8.csv")
#한글이 깨지면 못 읽으므로 0행으로 인식
readLines("encoding_test_utf8.csv") #깨져도 한줄씩 읽는다
readLines("encoding_test_utf8.csv", encoding = "UTF-8") #안깨진다

#data.table - dataframe보다 강력
#fread는 data.table에서 지원되는 함수
dftable <- fread("encoding_test_utf8.csv")
head(dftable) #위에서부터 6줄(default). 한글 깨져서 출력

#인코딩함수
Encoding(dftable$mydata3) = "UTF-8" #깨진 열만 인코딩
head(dftable)



