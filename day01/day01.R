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
names <- c('john','cindy','walker')
names[2] <- '박아무개'
print(names)
print(names[2])


