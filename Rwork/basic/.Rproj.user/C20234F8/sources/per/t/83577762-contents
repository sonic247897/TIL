#행렬
matrix(1:15)
#? matrix
# nrow = 1, ncol = 1가 기본 값
mymat1 <- matrix(1:15, ncol = 3) #3열로 작성
mymat1 # 열방향으로 데이터가 들어간다.
# 1부터 15까지의 값을 3개의 열로 표현, row방향 값을 추가
mymat1 <- matrix(1:15, ncol = 3, byrow = T)
mymat1 # 행방향으로 데이터가 들어간다.
mytext # 변수명을 동일하게 하면 script끼리 변수를 공유한다.
#matrix에서 원하는 값을 추출하기
mymat1[2,2] #행, 열
mymat1[3,3]
mymat1[1,c(1:3)] #1행의 1,2,3열 데이터 출력
mymat1[1,] # 1행의 모든 열
mymat1[,1] # 1열의 모든 값
# 1행과 3행을 뺀 데이터
mymat1[-c(1,3),]
# 1행과 3행만 출력
mymat1[c(1,3),]
####### 미니실습1 - 2행부터 4행까지 출력(단, 2번 3번 칼럼만)
mymat1[2:4, c(2,3)]
mymat1
#cbind는 컬럼을 추가하는 함수 - 값이 부족하면 맨 앞의 값으로 나머지를 채운다.
#rbind는 row를 추가하는 함수
addmymat1 <- cbind(mymat1, c(1,11,111,1111)) #columnbind: 컬럼에 몇개의 row를 추가 
addmymat1 # 에러는 아니고 경고메시지 뜸
addmymat2 <- rbind(mymat1, c(1,11,111,1111)) #넘쳐도 경고메시지 뜸: 길이를 벗어난 원소는 안 채워진다
addmymat2
colnames(mymat1) <-c("a","b","c") #열에 이름 붙이기
mymat1
rownames(mymat1) <-c("r1","r2","r3","r4","r5")
mymat1
mean(mymat1) #평균

