# 크롤링시 RVest 사용.
install.packages("rvest")
library(rvest)

url <- "http://www.daum.net"
htmltext <- read_html(url)
htmltext
# 크롬에서 F12 누르기 head는 잘 안쓴다. 설정값이다. 보통 body를 긁어온다.
# 하나씩 하나씩 더 열어보면 원하는 부분이 나온다. class : 부분 이름/ 이걸 칠수도 있다
# ID , div(태그) 를 쳐도 가져온다. div는 양이 너무 많다. id는 없는 부분도 있다. class가 낫다.
# < > --> 하이퍼 텍스트. HTML (꺽새) 
# 더블클릭 복사
# 특정 부분이 어느 코드인지 알고싶을 때 : F12 누르고 왼쪽 위 화살표 누른다.
# 대봤을때 태그, 클래스가 나온다. .abcd 는 클래스, 그 앞은 태그이다
# 형태 : <div id="top" class="end"> 
# ctrl f 누를시 검색창 사용 가능

# 카페 참고하기 // 연습해보기.

# 와 tag 사이에 우리가 찾고 싶은 정보들이 있기 때문에 nodes 함수를 사용한다.
news <- html_nodes(htmltext , "#news") # #은 ID // nodes는 태그 전체를 가져오는 것이다.(여러개면 통채로 가져온다)
news

# nodes와 text 함수의 차이점 
# 형태 : <div id ="car class-"carname" > 현대벨로스터 </div> 이런식으로 되어 있다. 통째로 가져오는 것이 nodes. '그 다음 현대벨로스터' 를 가져오는 것이 text 함수이다.


product <- html_nodes(htmltext , ".screen_out") # class는 . 앞에 표시
product

product2 <- html_nodes(htmltext , "h2") # 태그는 그냥 넣는다.
product2

product1Text <- html_text(product)  # 텍스트화.
product1Text

product3 <- html_nodes(htmltext , ".link_webtoon") 
product3

product3Text <- html_text(product3)  # 텍스트화.
product3Text


product4 <- html_nodes(htmltext , ".txt_pctop") 
product4

product4Text <- html_text(product4)  # 텍스트화.  --> 다음 카테고리들 모두 가져온것.
product4Text[10]


