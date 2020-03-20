# =와 <-가 같은것처럼 보이지만 <-를 이용해서 변수에 데이터 할당
a=100
b <- 100
a
b
sqrt(9) #sqrt의 절대값 출력
sqrt(x=9) #x는 함수의 매개변수로 인식
x #객체를 찾을 수 없다고 출력(글로벌 변수로 따로 처리된것 X)
sqrt(x<-9) #x라는 변수로 활용
x
# R에서는 =은 거의 안 쓰고 <-을 사용한다!
? c
myvector1 <- c(100, 200, 300)
myvector1
myvector1[1]
myvector1[2]
myvector1[3]
myvector2 <- c(10,20,30)
myvector1
myvector2
myvector1+20
myvector1*2
myvector1 + myvector2 #조인?

mytext <- c("java", "R", "hadoop", "android")
mytext[1]
mytext[1,2] #matrix에 사용하므로 벡터에서 쓸 수 없다.
mytext[c(1,2)] #벡터의 1번 요소와 2번 요소만 출력
mytext[c(1,3)]
mytext[1:3] #1번~3번까지의 요소 선택
mytext[c(1:3)] #c로 묶어줘도 된다.(헷갈리면 c로 묶기)
1:3
1:100 #자동으로 1부터 100까지 벡터 만들어줌
mytext[-1] #1번 요소 제외한 나머지
mytext[c(-1,-3)] #1번, 3번 요소 제외한 나머지
mytext[c(-1:-3)] #1번~3번 요소 제외한 나머지
mytext[-c(1:3)] #위와 같음

#TRUE(T)와 FALSE(F)를 이용해서 작업하기
mytext[c(T,T,F,F)] #TRUE로 표현된 요소만 
mytext[mytext=="java"] #조건을 만족하는 요소
numlist <- 1:100
numlist
numlist%%2 == 0 # %%: 나머지 구하기(짝수인 것 구하기) 
numlist[numlist%%2 == 0] #짝수 구하기
numlist[numlist%%2 == 1] #홀수 구하기
numlist2 <- seq(1,10)
numlist2
numlist2 <- seq(1,10,by = 2)
numlist2

v1 <- c(70,80,90,100)
names(v1) #names는 벡터의 각 요소 이름을 출력
names(v1) <- c("국어","수학","영어","자바")
v1
length(v1) #요소의 개수를 리턴
mean(v1) # 평균 리턴
max(v1) # 최대값
min(v1) # 최소값

