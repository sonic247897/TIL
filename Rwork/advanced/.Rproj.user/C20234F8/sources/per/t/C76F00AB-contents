data(package="MASS") #data: R 내부의 샘플데이터 셋을 가져오는 함수
# R설치시 기본으로 제공되는 MASS 라이브러리에 있는 data set목록 출력
library(MASS)
data("Boston")
head(Boston)
t(t(colnames(Boston))) #두 번 t하면 일렬로 볼 수 있다.
df <- head(Boston[,1:7]) # 1~7번 컬럼에 해당하는 모든 데이터 보기
df
# 반복작업을 할 때 사용할 수 있도록 함수를 지원
# (R에서는 paging처리 되어있는 웹사이트를 크롤링할 때 정도만 for문을 사용하고 나머지는 함수를 사용해서 계산한다)
# margin=1 -> 행방향으로 반복계산, 2: 열방향으로 반복계산
df[,"total"] <- apply(X = df, MARGIN = 1, FUN="sum") # X:데이터 프레임
df
df[,"avg"] <- apply(X = df, MARGIN = 1, FUN="mean")
df

#소수점 4째자리까지만 출력
round(apply(X = df, MARGIN = 2, FUN="sum"), 4)
round(apply(X = df, MARGIN = 2, FUN="mean"), 4)

#apply의 margin속성을 2로 정의한 것과 같다
apply(X = df, MARGIN = 2, FUN="mean")
sapply(X = df, FUN = "mean")
t(t(sapply(X = df, FUN = "class"))) #각 컬럼의 타입 확인



