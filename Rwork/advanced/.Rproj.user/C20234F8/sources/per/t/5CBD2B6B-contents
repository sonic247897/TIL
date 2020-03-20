library("ggplot2")
exam <- read.csv("csv_exam.csv")
exam

#전체 레코드의 맨 위에서부터 정의한 개수만큼 가져오기
head(exam, n = 5) # 5개만 가져오기
tail(exam, 5) #아래쪽부터 가져오기. 변수명은 생략해도 된다.

#실제 뷰어로 보기
View(exam)
#행의 개수
nrow(exam)
#컬럼의 개수
ncol(exam)
#행과 열의 개수
dim(exam)

#타입 확인
class(exam) #dataframe

#구조 확인
str(exam)

#데이터에 대한 요약정보 - 최소값, 최대값, 평균, 중간값, 4분위 수의 1,3번째
summary(exam)

exam

#컬럼의 이름을 변경 - dplyr(display rename?)
install.packages("dplyr")
library("dplyr")
#rename(data, 변경할 컬럼명=기존컬럼명)
exam <- rename(exam, eng=english) 
exam

#빈도수
table(exam$eng)
qplot(exam$eng)
