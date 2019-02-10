a <- 100
b <- 200
c <- 100
print(a == b) # 비교의 결과는 참(true)/거짓(false)이다
print(a == c)

if (a==b) {
  
}
# if문이 true이면 중괄호 안의 명령을 수행하라

if (a!=b) {
  print("different number")
  print("끝...")
}때 # if -close
# 제어문 안에 조건이 true 일 때만 실행된다.
#괄호 -> 열면 무조건 닫아야 한다.
# () 소괄호 :함수, 조건
# {}중괄호 : 포함
# []대괄호 : 인덱스. 리스트

##################################
# 프로그램
# 순차적 실행이 기본이다
# 조건문( 조건에 따라서 다르게 처리해야하는경우)
# 반복문 (여러번 반복해서 처리해야하는 경우)

i <- 6
if (i<5) {  
  print("smaller than 5")  # 구분을 위해 들여쓰기
}else{
  print("bigger than 5")
}
# 또 다른 조건 else문으로 추가 가능

i2 <- "PYTHON"
if (i2=="BIG_DATA") {  
  print("빅데이터반이 맞군요")  
}else if(i2=="PYTHON") {  # else if는 갯수제한이 없다.
  print("파이썬반이군요")
}else{
  print("빅데이터반이 아니군요")
}

i3 <- "사과"
if (i3 == "사과") {
  print("사과이면 제철이군요")
}else if(i3 == "배") {
  print("배이면 설에 먹어요")
}else if (i3== "키위") {
  print("키위이면 수입이에요")
}else {
  print("아무것도 아니면 과일이 아닌가봐요")
}

# 날짜와 관련된 함수들을 사용 가능하게 해주는 패키지
install.packages("lubridate") #"" 써야함
library(lubridate)# ""안써도 됨
now() # 현재 시간 알려주는 함수
date <-  now()
year(date)# 모두 lubridate 함수드
month(date)
day(date)
wday(date)
wday(date, label = TRUE) ## 1이 일요일, 라벨을 붙여줘야 요일이 나온다.
hour(date)
minute(date)
second(date)

if (hour(date)<11) {
  print("Good morning")
} else if (hour(date)>11 & hour(date)<15){
  print("Good afternoon")
} else if (hour(date)>15 & hour(date)<20){
  print("Good evening")
} else {
  print("Good night")
}


date + minutes(10) # date에 10분을 더한 날짜와 시각

########################################
# 입력받은 값 판별
input <- scan()

if (input == 100) {
  print("만점입니다")
}else {
  print("다음 기회에")
}

# ifelse : True 일때와 false 일때 값을 각각 낼 수 있다
# temp <- ifelse(i>100, "true" , "false")

# 삼항 연산자
temp3 <-80
result <- ifelse(temp3 > 100 , " Big" , "Small")
result

###############################################
# 반복문을 해보자
temp4 <- 10
while (temp4 > 7) {
  print("Bigger than 7..!!!")
  temp4 = temp4 - 1
}

temp5 <- c("park", "Kim" , "song" , "jung")
for(x in temp5) {
  cat("당신의 이름은" ,x, "입니다\n")
}

student <-data.frame(name = temp5 , 
                     age2 = c(30,50,15,45)
                     )
student
# for 문으로 데이터프레임을 찍어 보자
for(y in student$name) {print(y)}


# 반복문 예제
while(TRUE) {
  input2 <- scan()
  if(input2 ==0) {
    print("End of the session")
    break
  }
  print(input2)
}










