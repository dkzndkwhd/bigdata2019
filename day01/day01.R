#외부 라이브러리 설치

install.packages("glue")
install.packages("ggplot")

#외부 라이브러리 사용
library(glue)

# 여기에 glue 를 이용해서 프린트 연습
# temp 변수 : 아무것도 안붙어여. 
#             정적인 값 저장
# temp() 함수 : 동적인 처리

# 벡터 만들어 보기 
# 할당 연산자 단축기 바꾸기 : assign 을 알트+-
#바꾸어주면 편하다 할당 연산자 : <-
ages <- c(10,30,50)
# 벡터 내부 요소 변경시
ages[1] <- 20
# 나중에 벡터와 리스트로 테이블 인덱싱 할시
# 인덱싱을 2중으로 하게 된다
# R은 인덱싱을 1부터 시작한다.

# pipe 연산자 단축키 알트+/

# 이름 벡터를 만들고
# 두번째 사람이 박아무개로 개명
# 이름의 전체 내용을 출력
names <- c('john','cindy','walker','psy')
names[2] <- '박아무개'
names

# factor 구분 하기
address <- c("서울","대구","부산","군산","서울","서울","대구")
address
str(address)
# address를 address2 에 factor 로 저장
address2 <- as.factor(address)
address2
address2[1] <- "대구"
address2

#factor 바꾸기 위해서는 다시 char 로 바꾸어야 한다
address3 <- as.character(address2)
address3
address3[2] <- "광주"
address3

#입력의 다양한 형태
x <-  scan() ## 먼저 이거 입력후 콘솔에서 따로 입력.
x

x2 <- scan()
x2

x2[2] <- 222
x2
str(x2)

# scan 을 문자열로 입력하고 싶다면??
food <-  scan(what = "") ## 먼저 이거 입력후 콘솔에서 따로 입력.\
food

str(food)
class(food)
typeof(food)

favorite <-  food[1]
print("내가 제일 좋아하는 음식은" , favorite)
# 프린트는 하나씩만 인쇄 가능. 파이선처럼 여러개 같이 출력 불가

#여러개 출력시 cat, glue 사용
cat("내가 제일 좋아하는 음식은" , favorite)
#glue 는 중간중간에 쑤셔넣을 수 있다. glue는 따로 설치해야 사용가느
glue("내가 제일 좋아하는 음식은 {favorite}이다" )
second <-  food[2]
glue("나의 {second}음식은 2번째로 좋아하는 음식이예요")
