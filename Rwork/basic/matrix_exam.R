# matrix에 값을 넣을 때는 보통 한번에 다 넣는다!
myjumsuMat <- matrix(c(80,90,70,100,80,99,78,72,90,78,82,78,99,89,78,90), nrow=4, byrow = T)
myjumsuMat
colnames(myjumsuMat) <-c("국어","영어","과학","수학")
rownames(myjumsuMat) <-c("kim","lee","hong","jang")
myjumsuMat
avg_name <- c(mean(myjumsuMat[1,]),mean(myjumsuMat[2,]),mean(myjumsuMat[3,]),mean(myjumsuMat[4,]))
avg_subject <- c(mean(myjumsuMat[,1]),mean(myjumsuMat[,2]),mean(myjumsuMat[,3]),mean(myjumsuMat[,4]))
avg_name
avg_subject
