install.packages("dplyr")
library(dplyr)
install.packages("bindrcpp")
library(bindrcpp)
exam <- read.csv("C:/LJS/day03/excel_exam.csv")
View(exam)

# filter() 열 조건대로 행 뽑아오는함수.
# %>% 뒤와 앞을 연결.
exam %>% filter(class == 1) %>% head(3)
# exam 을 뽑아 와서 그 안에서 filter 함수 적용. class가 1인 행렬을 가져온다.
# head() 함수 : 뽑은 것 중에서 앞에서 몇개만 가져오게 하는 함수
# tail() 함수 : 뒤에서 몇개 가져오게 하는 함수 ( 갯수 제한)

class1 <- exam %>%filter(class ==1)
class2 <- exam %>%filter(class ==2)
class3 <- exam %>%filter(class ==3)
class4 <- exam %>%filter(class ==4)

# 하나를 제외하고 나머지를 추출하기.
classNot1 <- exam %>% filter(class!= 1)
classNot2 <- exam %>% filter(class!= 2)
classNot3 <- exam %>% filter(class!= 3)
classNot4 <- exam %>% filter(class!= 4)

# 특정 조건 만족시키는 행들의  특정 열 가져오기. 열 = 로우란다. (row)
# ex) english 가 80보다 작은 class 3 을 추출하라
# 둘중 하나만 만족해도 갖고 와라 --> | 사용 (역슬래쉬 쉬프트)
exam %>% filter(english <= 80 & class ==3)

# 예제) math 가 80점 이상, science 가 85점 이상 두 가지 조건 중 하나라도 만족시 추출.
exam %>% filter(math>=80 | science >= 85) %>% filter(class != 2 & class !=4)
# or
exam %>% filter(math>=80 | science >= 85) %>% filter(class ==1 | class == 3 | class ==5)
exam %>% filter(class %in% c(1,3,5))
# %in% 연산자 --> 포함 연산자. 이 안에 포함되면 추출.

# base 패키지 사용해서 평균 내보기
mean(class1$math)
max(class1$math)

# dplyr, ggplot2 은 패키지 다운로드시 데이터셋을 같이 제공한다 . 
install.packages("ggplot2")
library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg) # 자동차 연비 데이터 .

# 예제
# 1. ford 차량 row 추출
# 2. 고속도로 연비 추출
# 3. 평균.
ford <- mpg %>% filter(manufacturer == "ford")
mean(ford$hwy)

# 예제2 
# 1. class가 compact의 고속도로 연비(평균)
# 2. class가 suv의 연비(평균)
# 3. 뭐가 더 좋은지

compact <- mpg %>% filter(class == "compact")
suv <- mpg %>% filter(class =="suv")
compactmean <- mean(compact$hwy)
suvmean <- mean(suv$hwy)
library(glue)
a <- max(compactmean , suvmean)
glue("{a} is better hwy")

# 열을 추출해 보자 select()
exam %>% select(math)

exam %>% select(math, english) # 여러개 추출시.

exam %>% select(-math) # ~ 빼고 추출시.

exam %>% select(-math, -english) # 여러개 ~ 빼고 추출시.

# filter 는 보통 단위연산자를 사용. 행렬을 가져오기 때문에
exam %>% 
  filter(class == 1) %>% 
  select(english) %>% 
  head(2)# 보통 보기 쉽게 여러 줄로 정렬
# R은 들여쓰기 의미가 없다. 들여쓰는 이유는 가독성 때문. 파이썬은 들여쓰기 필수.

#정렬을 해보자
exam %>% arrange(math) # 오름차순 정렬
exam %>% arrange(-math) # 내림차순 정렬 
exam %>% arrange(desc(math)) # 내림차순 정렬
exam %>% arrange(desc(class) , math) # class 로 1차 내림차순 정렬 후 math 로 2차 오름차순 정렬.

#파생변수 만들기 : mutate()
exam <- exam %>% mutate(total = math + english + science)


# 그룹화 하기
exam %>% 
  group_by(class) %>%  # 딱히 여기까진 뭔가가 일어나지는 않음
  summarize(mean(math))  # 클래스별 math 평균치를 테이블화 한다.

exam %>% 
  group_by(class) %>%  # 이중그룹 : , 로 가능
  summarize(meanmath = mean(math) ,
            summath = sum(math) , 
            median = median(math) ,# 중간값.
            n = n())
# n = n() 빈도 함수 .

##########################
# 예제 : 회사별로 "suv" 자동차의 도시 및 고속도로 통합 연비 평균을 구해 내림차순으로 
# 정렬하고 1~5위까지 출력하기

# 1. 회사 별로 분리하기
mpg %>% 
  group_by(manufacturer) %>% 
  filter(class == "suv") %>% 
  mutate(tot = (cty + hwy)/2) %>% 
  summarise(meantot = mean(tot)) %>% 
  arrange(desc(meantot)) %>% 
  head(5)
























