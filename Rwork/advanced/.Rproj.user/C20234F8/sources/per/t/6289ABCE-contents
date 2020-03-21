test1 <- data.frame(id=c(1,2,3,4,5),
                    mid_jumsu = c(77,56,99,100,99))
test2 <- data.frame(id=c(1,2,3,4,5),
                    final_jumsu = c(77,56,99,100,99))
test1
test2
# 조인
final_data <- left_join(test1, test2, by="id") # 열방향으로 조인(조인key 명시)
final_data

namedata <- data.frame(class=c(1,2,3,4,5),
                       teacher=c("kim","lee","park","jang","hong"),
                       stringsAsFactors = F) # factor가 아니라 char타입으로 생성
#문자열을 지정하면 factor타입으로 지정되어서 5레벨로 뜬다. (순위)
str(namedata)

exam_new <- left_join(exam, namedata, by="class")
exam_new

#오전시험, 오후시험 (어제 크롤링, 오늘 크롤링)
# - 매일 크로링한 데이터를 파일로 저장할 때
groupA <- data.frame(id=c(1,2,3,4,5),
                    mid_jumsu = c(77,56,99,100,99))
groupB <- data.frame(id=c(6,7,8,9,10),
                    mid_jumsu = c(77,56,99,100,99))
group_total <- bind_rows(groupA, groupB)
group_total

