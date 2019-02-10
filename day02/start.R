a <- 100
b <- 200
print(a + b)
# 주석 (설명 )
# 프로그램 전체 제어문
  # 1. 프로그램은 순차적으로 실행
  # 2. 조건
  # 3. 반복
# 데이터의 자료 구조
 #데이터프레임 = > 벡터(열) + 리스트(행)

# 벡터를 만들어 보자. c 함수 : combine
name <- c(1, 2, 3, 4, 5)
name[3] # 인덱스[]사용
# name[3] = print(name[3])
name[3] <- 333
name[3]
print(name)

## 이름 벡터를 만들어서 출력하고 마지막 김민지
## 를 송민지로 만들어서 출력하라
names <- c('김지훈', '이유진', '박동현' ,'김민지')
print(names)
names[4] <- '송민지'
print(names)

str(name) # 구조 확인
table(name) # 테이블 형태로 요약해준다.
# table 밑에 나오는 숫자는 빈도수
class(name) # 데이터의 타입 확인
typeof(name) #데이터의 타입 확인(더 디테일하게)

eng <- c(90, 80, 60, 70)
math <- c(50, 60, 100, 20)

# 이걸 데이터테이블로 만들어 보자
# 자동완성(컨트롤+스페이스바,탭)과 복사를 활용
midterm <- data.frame(names,eng,math)
midterm



  str(midterm) # 구조 확인
table(midterm) # 테이블 형태로 요약해준다.
# table 밑에 나오는 숫자는 빈도수
class(midterm) # 데이터의 타입 확인
typeof(midterm) #데이터의 타입 확인(더 디테일하게)
## name 은 factor 로 들어간다.
View(midterm) # 앞문자 대문자이


##############################################
# 2.데이터프레임 변수 안만들고 바로 만들기.
# --> 직접 데이터프레임 만들기
lastTerm <- data.frame(name2 = c('song','park','kim'),
eng2 = c(100, 50, 80),
math2 = c(50, 60, 90)
)
lastTerm
# 함수 작성 도중 엔터 눌러서 다음 줄로 넘길
# 수 있다. $로 열들을 구분해서 확인 가능하다.
# 문자열을 보통 factor 로 인식한다.
lastTerm$name2
lastTerm$eng2

str(lastTerm$name2)
str(lastTerm$eng2)
table(lastTerm$eng2)

test <- c("apple","banana", "kiwi", "apple",
          "banana", "apple")
table(test)

# 간단한 통계기법 활용

mean(lastTerm$eng2)
mean(lastTerm$math2)

# 파일 불러올때 역슬래쉬를 슬래쉬로 바꾸자
# F2 누르면 파일 이름 긁어올 때 편하다
# csv파일 만들 시 마지막줄 쓰고 엔터쳐야한다.
# --> 그래야 마지막줄을 인식할 수 있다.
# 팩터값으로 지정되면 추가할 수 없다.
midtest2 <- read.csv("C:/LJS/day02/midterm2.csv")
View(midtest2)
str(midtest2)
# 엑셀을 읽으려면 다른 패키지를 설치해줘야한다.
#install.packages("readxl")
library("readxl")
#컴퓨터가 가끔씩 라이브러리 안쓰면 지맘대로 내린다
# 다시 불러와줘야 한다.
#엑셀 읽어오기
midterm3 <- read_excel("C:/LJS/day02/midtest3.xlsx")
View(midterm3)
# 파일 확장명 건드릴 때를 위해 탐색기에서 확장명
# 나오도록 설정해 준다.
str(midterm3)
table(midterm3)
class(midterm3)
typeof(midterm3)
# ---> 이친구는 chr 로 불러온다.
# 가끔씩 수정된 파일 읽을시 수정 전 파일을 읽어올 때가
#있다 그럴 때에는 변수명이나 파일명을 바꾸어 주면 해결된다.
child <- read_excel("C:/LJS/day02/child.xlsx")
View(child)
# 변수 지우는 방법 
# -> rm()함수 -> 변수 지우기
# -> ls() 변수들의 리스트

list <- ls()
list
# 변수 전체 다 지울 때
# rm(list = ls())
rm(list = ls())

# 엑셀 데이터 원하는 부분만 떼오기
midterm3$name
submidterm <- data.frame(midterm3$name, 
                         midterm3$tel)
submidterm
submidterm2 <- data.frame(name2 = midterm3$name,
                          tel2 = midterm3$tel)
submidterm2

# 새로 만든 파일 csv파일로 저장하기.
write.csv(submidterm2, file = "submidterm2.csv")
# 새로 만든 파일 excel 파일로 저장하기

submidterm2
# 데이터프레임에 새로운 열 추가하기
# $ 후 없는 열 그냥 쓰고 내용 추가.
submidterm2$age2 <- c(20, 30, 40)

# 기존에 있던 벡터 추가할시.
addr <- c("서울시", "부산", "경기도")

submidterm2$addr <- addr
names(submidterm2)
# names() 함수 --> 변수들 추출해주는 함수

#행, 열 추처
submidterm2[1] # --> 열추출   
# 정확히 하자면 submidterm2[,1]
# 데이터프레임 열 접근방법 : $ 사용하기,
# and 인덱스 사용하기
submidterm2[1,]출 # --> 행추출
submidterm2[1,1]
submidterm2[3,1]
submidterm2[3,3]

# 행, 열 삭제
submidterm2[,-1] # 이것만 하면 cpu에서 잠깐
# 띄우기만 하고 실제 RAM 에서 삭제 안한다.
submidterm3 <- submidterm2[,-1] # 열 지우기
submidterm3

submidterm4 <- submidterm2[-1,] # 행 지우기
submidterm4

# 여러 줄 지울 때, c함수와 : 를 활용하자
submidterm5 <- submidterm2[, -c(2:4)]
submidterm5
# 선택적으로 여러 줄 지울 때.
submidterm6 <- submidterm2[,-c(1,3)]
submidterm6

temp1 <- c(1:100)
temp1



