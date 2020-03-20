#csv는 기본 패키지로 사용 가능(다시 로딩할 필요x)
#csv를 읽기기
mdf <- read.csv("csv_exam.csv")
mdf
mdf[2,]
#dataframe에서 조건에 만족하는 데이터를 조회
m <- matrix(1:20, ncol = 4) #matrix로 작업하는 것이 가장 편함
m
d <- data.frame(m)
d
myresult <- d[d$X3>=13,]
myresult
#조건에 만족하는 데이터를 result.csv로 저장
write.csv(myresult, file = "result.csv")
#csv로 보내지 않고 mongoDB나 HDFS로 보낼 수 있다.

##미션
csvDf <- read.csv("csv_exam.csv")
csvDf
csvDf2 <- csvMat[csvDf$science>=80,]
size <- length(csvDf2[,1])
size
mytotal <- 1:size
myavg <- 1:size

idx = 1:size
for (i in idx) {
  for(j in 3:5){
    mytotal[i] <- mytotal[i] + csvDf2[i,j]
  }
  myavg[i] <- mytotal[i]/3
}

csvDf2$x6 <- mytotal
names(csvDf2)[6] <- c("mytotal")
csvDf2$x7 <- myavg
names(csvDf2)[7] <- c("myavg")
csvDf2

write.csv(csvDf2,file="csv_exam_result.csv")



