#### 교통사고 분석 케이스

car1 <- read.csv("C:/LJS/day03/car1.csv")
# Envirnoment -->import dataset 에서도 위 함수를 읽어올 수 있다
View(car1)

str(car1)
# obs : 행  var : 열(변수)
# name : factor 로 받아들인 chr --> 몇 개가 있느냐  ** 이상 추가하려 해도 안들어감
# 나머지 : integar 
# $ 하나의 항목 지정시 사용

# names() 함수
names(car1)  # --> factor들을 한눈에 볼 수 있도록 해주는 함수
names(car1) <-c("이름", "밤낮", "사고수", "사망", "중상", "부상", "고통", "리포트")
names(car1)
# names 함수로 데이터프레임 내의 factor 들을 바꾸어 줄 수 있다.
names(car1) <- c("name", "DayNight", "count", "death",  "injury",   "Sinjury",  "wound",    "report" )
names(car1)

car1$name # name 열의 모든 데이터를 뽑아낸다.

# 밑 과정은 분석을 쉽게 해주는 전처리 과정이다.
#ifelse 조건문 : 양자택일이 가능하게 하는 간단한 조건문

# ifelse(조건 , True 일때 출력 , False 일때 출력)
car1$result1 <- ifelse(car1$DayNight == 1 , "낮" , "밤")
# result 1 열을 새로 만들어 car1의 daynight 항이 1일 경우 낮, 0일 경우 밤인 새로운 행을 추가하라
car1$result2 <- ifelse(car1$name == "과속" , "속도문제", "x")
car1$result3 <- ifelse(car1$count>5000, "큰사고", "작은사고") 

# 중간에 뜬금없는 값이 있으면 그거에 대한 전처리 또한 해주어야 한다.
# table() 함수 = 변수 갯수 세어 주는 함수
table(car1$DayNight)
table(car1$result1)

# hist() 히스토그램 그릴 때 사용하는 함수.
#hist(table(car1$result1))

plot(table(car1$result1))  # --> 막대그래프 형태 가장 간단한 시각화 장치
# table 함수로 생긴 변수 갯수를 시각화한것이다.
# 더 예쁘게 하려면
install.packages("ggplot2")
library(ggplot2)
qplot(car1$result1) # ggplot2 패키지
plot(car1$result1) # 얘는 qplot 처럼 빈도수를 계산할 수 없다. table 함수를 이용해야
# 그래프를 그릴 수 있다 . 막대그래프


# 없는 칼럼을 하나 변수로 만들어 추가할 때 
#파생 변수라고 부른다.
# 이중 조건문. 마지막 False 자리에 ifelse 구문을 써서 이중으로 조건문이 기동한다
car1$result4 <- ifelse(car1$death >= 1000 , "대형사고" , 
                      ifelse(car1$death >= 100, "중형사고" ,
                             "보통사고"))
table(car1$result4)
qplot(car1$result4)

### 기존의 데이터프레임에서 또 다른 데이터프레임 만들기

car2 <- data.frame(car1$name , car1$count , car1$result4)
View(car2)
car2
## 변수 이름을 어떻게 깔끔하게 내 마음대로 바꿀까?
car2 <- data.frame(name = car1$name , count = car1$count , 
                   result = car1$result4)
car2

# 데이터 분석시 유용한 함수 --> 1. 요약함수 -->table() 함수
# 2. 막대그래프 (qplot함수)

#서로 다른 항목 간 조건문을 통해 특정 열만 가져오기 : subset() 함수
# 부분 추출 함수 : subset(추출할 데이터 , 조건)
daycount <- subset(car1$count , car1$DayNight == 1)
daycount

nightcount <- subset(car1$count , car1$DayNight == 0)
nightcount
# 무슨 타입일까?
typeof(daycount)
class(daycount)
str(daycount)
table(daycount)
# daycount 는 한 가지 형태의 데이터가 여러 개 들어가 있는 벡터 형태이다.
# base 패키지 위주로
sum(daycount)
sum(nightcount)
# 밤보다 낮에 사고 건수가 더 많다.
# 왜 그럴까 ? -->요인 분석
# 시간별 요인 분석 --> 시계열 분석
# 미래 예측 --> 회귀분석

# 실습  
# 1. 밤낮의 전체 사고 건수 결과를 데이터 프레임에 넣기
# 2. 요약하자
# 3. 막대그래프를 그려 보자

daynight_accident <- data.frame(dayaccident = sum(daycount) , 
                                nightaccident = sum(nightcount))
View(daynight_accident)
table(daynight_accident)
qplot(sum(daycount) , sum(nightcount)) # --> plot , qplot 은 한 개의 컬럼만 그린다
#데이터프레임은 컬럼이 2개 이상이기 때문에 그릴 수 없다.
# 컬럼 : 열 (변수)
# 나중에 더 배우고 나서 테이블을 시각화할 수 있다.


# sum() 함수 : 합계를 구하는 함수
sum(daycount)
sum(nightcount)
# mean() 함수 : 평균을 구하는 함수
mean(daycount)
mean(nightcount)
# max() min() 최대 ,최솟값 구하는 함수

# ifelse(조건 1 & 조건 2)
# 밤에 과속인 총 수
# 중복 조건은 &
nightover <- sum(ifelse(car1$DayNight == 0 , ifelse(car1$name == "과속" , car1$count , 0)
                    , 0))
nightover
# 밤에 신호위반
nightbreak <- sum(ifelse(car1$DayNight == 0 , ifelse(car1$name == "신호위반" , car1$count , 0)
                          , 0))
nightbreak


# 정답 : 
sum(ifelse(car1$DayNight == 0 & car1$name == "과속" , car1$count , 0))
sum(subset(car1$count , car1$DayNight == 0 & car1$name == "과속"))

sum(ifelse(car1$DayNight == 0 & car1$name == "신호위반" , car1$count , 0))
sum(subset(car1$count , car1$DayNight == 0 & car1$name == "신호위반"))

# 누가 더 큰가?
max(nightover , nightbreak)

# 위 과정들을 더 간단하게 하기 위해 패키지들을 활용할 수 있다.
# %>% pipe 연산자 a->b->c 순차적으로 실행
# 데이터 전처리 - dplyr 패키지 사용



