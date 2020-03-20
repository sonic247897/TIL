#랜덤값을 만들어낼 때 사용
set.seed(1222) #1222는 랜덤수를 발생시켰던 곳을 찾아갈 수 있는 key값
a<-sample(1:10, size = 5, replace = FALSE) 
a
#replace = FALSE: 샘플 데이터에서 추출한 데이터는 삭제하므로 중복x(default)
#replace = TRUE: 중복허용

#if문의 역할을 하는 함수 - ifelse
set.seed(1221)
ifdf <- data.frame(mynum=1:6,
                   myval=sample(c("spring","bigdata", "android"),
                                size = 6,
                                replace = TRUE))
ifdf
# 1. 오버헤드가 많고 속도가 느린 방법!
#myval의 값이 spring이면 프로젝트 완료
for(i in 1:nrow(ifdf)){
  #컬럼명을 index로 줄 수 있다
  if(ifdf[i,"myval"]=="spring" ){
    #새로 만들어지는 컬럼명
    ifdf[i,"info"] <- "프로젝트 완료"
  }else{
    ifdf[i,"info"] <- "할꺼야"
  }
}
ifdf

# 2. 함수를 이용해서 작업 - info2
# 없으면 새로 만든다
ifdf[,"info2"] <- ifelse(test = ifdf$myval=="spring", 
                         yes = "쉽다", 
                         no= "할꺼다")
ifdf

# 3. 조건이 두 개 이상인 경우 처리 - info3
ifdf[,"info3"] <- ifelse(test = ifdf$myval=="spring", 
                         yes = "쉽다", 
                         no= ifelse(test=ifdf$myval=="bigdata", 
                                    yes = "머신셋팅",
                                    no = "device셋팅완료"))
ifdf

ifdf[,"info4"] <- "쉽다"
ifdf
