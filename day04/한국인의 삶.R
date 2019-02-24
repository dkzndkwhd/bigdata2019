# R 데이터 분석하기 연습 - 카페 -

nstall.packages("foreign")
library(foreign) # --> Read Data Stored by
#'Minitab', 'S', 'SAS', 'SPSS', 'Stata', 'Systat', 'Weka', 'dBase', ...
library(dplyr)
library(ggplot2)
install.packages("readxl")
library(readxl)
# f2 누르면 파일명 긁어오기 쉽다.
raw_welfare <-  read.spss(file = "C:/LJS/day04/Koweps_hpc10_2015_beta1.sav" , to.data.frame = T ) 
#데이터 프레임 형태로 spss 파일 읽어오기.
#복사본을 하나 만들어 놓자.
welfare <- raw_welfare
View(raw_welfare) # 데이터 너무 많아서 렉처먹음
head(welfare)
summary(welfare)

welfare <- rename(welfare,                    ### 복잡한 변수 내용들
                  gender = h10_g3,            ### 간단한 이름으로 바꾸어주는 함수
                  birth = h10_g4,             ### dplyr 의 rename() 함수 이용.
                  marriage = h10_g10,
                  religion = h10_g11,
                  income = p1002_8aq1,
                  code_job=h10_eco9,
                  code_region=h10_reg7
)


count(welfare , gender) # 데이터 프레임내 숫자 세주는 함수 count(데이터프레임, 변수)
welfare$gender

welfare$gender <- ifelse(welfare$gender == 9, NA , welfare$gender)
# 9인 이유 : 엑셀시트에 모름/무응답은 9라고 되어 있다고 써 있어서 9로 체크하는 것.

table(is.na(welfare$gender)) # welfare$gender 안에 NA 가 포함되어 있는가/ 를 요약한다.
# 결과값 : false : 그 안에 NA 가 없다는 뜻이다.

welfare$gender <- ifelse(welfare$gender == 1, "남" , "여")
# gender 가 1이면 남으로 아니면 여로 변경한다.

table(welfare$gender) # 변수의 빈도별로 정리한다.

qplot(welfare$gender) # 막대그래프로 그려보기.

class(welfare$income) # 변수의 형태 확인.

summary(welfare$income) # NA 갯수도 확인 가능.
qplot(welfare$income) + 
  xlim(0, 1000) 

table(is.na(welfare$income)) # NA 갯수 확인해서 출력. True 가 NA 갯수.

# %in% ??????

# 결측치 처리를 해보자
welfare$income <- ifelse(welfare$income %in% c(0,9999), NA , welfare$income)
table(is.na(welfare$income))  # ?????

# 성별 월급의 비교.
#1. NA 는 빼고 비교한다. ( 이상치도 NA 로 바꾸어 준다.)
#2. 성별로 그룹을 지어준다 (dplyr 패키지 활용)
#3. 평균을 내준다.
#4. 시각화
# --->
gender_income <- welfare %>%  # 일단 다 가져온다
  filter(!is.na(income)) %>% # NA 가 아닌 것만 가져온다 !!!
  group_by(gender) %>% # 그룹을 지어준다 !!!!!
  summarise(mean_income = mean(income)) #변수명을 나중에도 사용하기 위해 따로 이름을 지어준다.

gender_income

ggplot(data = gender_income , aes(x = gender, y =mean_income)) +
  geom_col()


# 나이별 월급을 비교
qplot(welfare$birth)
# 나이 변수가 없어서 birth 를 가지고 나이를 추출해낸다. --> 파생변수 만들기(mutate함수)
welfare$age <- 2015 - welfare$birth + 1
summary(welfare$age)
qplot(welfare$age)

# 나이별 평균 월급 (income 에서 NA 값 지우고)
age_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>%
  summarise(mean_age_income = mean(income))

  
ggplot(data = age_income , aes(x = age , y = mean_age_income)) +
geom_line()


# 연령대별 평균 월급 구하기
#1.  파생변수 만들기
welfare <- welfare %>%
  mutate(age2 = ifelse(age < 30 , "young" , 
                       ifelse(age<= 59 , "middle" , "old")))
welfare$age2
table(welfare$age2) # 빈도수 정리 테이블

qplot(welfare$age2)

#급2. 연령대별 평균 월그
age_income2 <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age2) %>%
  summarise(mean_age_income = mean(income))

ggplot(data = age_income2 , aes(x = age2 , y = mean_age_income)) +
  geom_col() + scale_x_discrete(limits = c("young" , "middle" , "old"))
# scale_x_discrete --> 자기가 원하는대로 x변수 순서 조절
table(age_income2)
age_income2


# 연령대 성별 평균수입 -- 그룹화를 2번 해야 한다 group_by( x , y ) 면됨
age_gender_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age2, gender) %>%
  summarise(mean_age_income = mean(income))
age_gender_income

ggplot(data = age_gender_income , aes(x = age2 , y = mean_age_income, fill= gender)) +
  geom_col(position = "dodge") + scale_x_discrete(limits = c("young" , "middle" , "old"))




# 연습
# 나이 + 성별 평균 월급의 흐름을 알고 싶습니다.
# 분석 후 시각화 ( 시계열로)
# 시계열인 경우 fill 옵션 대신 , "col = " 사용
age_gender_income2 <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age, gender) %>%
  summarise(mean_age_income = mean(income))
age_gender_income2

ggplot(data = age_gender_income2 , aes(x = age , y = mean_age_income, col = gender)) +
  geom_line(position = "dodge") 




# 엑셀파일의 직종 코드 시트를 읽어 오고, spss파일과 합쳐서 데이터프레임을 만들어보자.
# left_join() 함수 사요
list_job <- read_excel("C:/LJS/day04/Koweps_Codebook.xlsx" , col_names = T , sheet = 2)
list_job
welfare$code_job

# welfare$code_job 웰페어에도 코드 언더바 잡이 있고, list_job에도 code_job이 있다.
# id를 부여하여 합친다. 엑셀 파일의 job 값이 들어간다. 
welfare <- left_join(welfare , list_job, id = "code_job")
head(welfare$job)


#직종별 평균월급
jobincome<- welfare %>% 
  filter(!is.na(income) & !is.na(job)) %>% 
  group_by(job) %>%
  summarise(mean_age_income = mean(income))
jobincome



#상위 10개 추출
top10 <- jobincome %>% 
  arrange(desc(mean_age_income)) %>% 
  head(10)
top10


# 다시복습해보기
