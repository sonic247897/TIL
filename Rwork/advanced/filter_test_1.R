# 주어진 데이터에서 원하는 데이터만 추출
# dplyr은 문자열에 대한 작업에 특화된 기능이 많은 패키지
# C++로 구현되어 있어 가장 빠르다.
# dplyr라이브러리는 실행할 때 코드 전체를 범위지정해서 실행
# (덜 올라온 상태에서 다음줄 실행하면 실행 안되므로)
library("dplyr") # 기본적으로 따옴표 붙이는게 맞음
data("airquality") 
head(airquality) #로딩된 것을 그대로 사용하므로 따옴표 안붙이기??

df2 <- airquality
df2

# 필터링 - 벡터연산
head(df2[,1:4])
df2_data1 <- df2[1:5, ]
df2_data1
df2[df2$Day==1,] #조건을 만족하는 행만 보겠다(열은 전부 봄)
#조건이 TRUE나 FALSE를 리턴하고, TRUE에 맞는 행만 출력한다
df2[df2$Day!=1,]
df2[df2$Day<=2,]
df2[df2$Day==1 & df2$Day==2, ] 
df2[df2$Day==1 | df2$Day==2, ]

sum(df2$Day %in% 1:2) #oracle의 in연산자와 비슷 - day가 1이거나 2인 개수
# 아래작업을 위의 명령어로 할 수 있음
df2_data2 <- df2[df2$Day %in% 1:2, ]
nrow(df2_data2)

# dplyr패키지에서 지원하는 필터 관련 함수
filter(df2, Day==1 & Month==5) #자동완성 지원x
filter(df2, Day %in% c(1,3,5))










