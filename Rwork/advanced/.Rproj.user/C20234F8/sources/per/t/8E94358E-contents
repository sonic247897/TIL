library("dplyr")
exam <- read.csv("csv_exam.csv")
exam
# chaining결과를 grouping할 때 문제가 발생할 수 있다.
# 원래 R에서는 <-로 변수에 할당하고 변수를 찍어야 결과가 나오는데
# 체이닝 오퍼레이터 때문에 그냥 출력된다.

# filter: 조건을 정의
exam %>% 
  filter(class==1) %>%  # ctrl+shift+m 단축키 
  filter(math>=50)

# select - 추출하고 싶은 변수를 정의. 오라클에서의 select와 비슷
exam %>% select(-math) # math컬럼 제외
exam %>% select(id, math, english)

exam %>% 
  filter(class==1) %>% 
  select(id, math, science)


# arrange
exam %>% arrange(id)
exam %>% arrange(desc(id))
exam %>% arrange(class, desc(english)) #class로 먼저 정렬하고, 같은 클래스 안에서 english를 내림차순으로 정렬한다

# mutate - 파생변수 추가하기(원본에 없는 컬럼 추가)
# 파생변수 만드는 방법 중 가장 빠른 방법[데이터가 많을 때 사용]
exam %>% 
  mutate(total=math+english+science,
         mean = total/3,
         info = ifelse(science>=70, "통과", "재시험")) # ifelse문 yes, no 안 써도 됨

# group으로 묶고 난 후에 연산
exam %>% 
  group_by(class) %>% 
  summarise(math_sum = sum(math),
            math_mean = mean(math),
            math_median = median(math),
            math_count = n())# 내부적으로 class끼리 묶음






