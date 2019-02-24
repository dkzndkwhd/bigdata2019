#결측치 : 결과값이 없는것
# is.na(데이터프레임 이름) 결측치가 있는지 없는지 위치를 잡아주는 함수
# 결측치는 NA 로 표기한다.
# 결측치는 평균, 합계등 함수 적용불가.력

# 결측치 제거 방법 1. filter 2. na.rm = 옵션 사용하여 함수 사용하기

# dplyr 패키지를 로드해서
# 데이터프레임 %>%  filter(is.na(행&열)) # 데이터프레임내 행&열에서 NA 인 데이터만 출력
# 데이터프레임 %>%  filter(!is.na(행&열)) # 결측치 제거 후 출력.

file <- read.csv("C:/LJS/day04/naData.csv")  # --> 결측치가 있는 파일.
file
str(file)
mean(file$english)
mean(file$X)
mean(file$math)
mean(file$class)
# math  는 결측치가 있어 계산되지 않는다.

# 결측치를 0점처리 해보자.
file$math <- ifelse(is.na(file$math) , 0 , file$math) 
# file$math 에서 NA 값이면 0으로 바꾸고, 아니면 그대로 출력한다.
file

# 문자열 추출시 stringr 패키지를 이용하여 문자열 일부 추출하면된다.