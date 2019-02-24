## 크롤링의 과저
#1. 네트워크로 연결정
install.packages("rvest")
library(rvest)
library(dplyr)
#2. 문서를 읽어야 한다.
# url 복잡하므로 변수에 따로 저장해서 사용하는 것이 편하다.
url <-  "http://music.naver.com/listen/top100.nhn?domain=DOMESTIC&duration=1h"
download.file(url, destfile = "navermusic.html" , quiet = T ) #navermusic.html로 저장한다.
#quiet 는 옵션.
naver_music <- read_html("navermusic.html")

naver_music
# 사이트 들어가서 f12 눌러서 무엇을 가져 올지 선택
# 위 화살표 누르면 마우스 대는 곳의 소스코드 위치를 알아낼 수 있다.
# 태그는 같은 게 너무 많아서 가져오는 경우가 흔치 않다. 
# 보통 클래스로 가져온다.


#3. 데이터 추출( 열: 벡터) ,전처리

# 순위 랭킹을 가져와 보자
ranking <- naver_music %>% # 전체 트리 구조 안에서
  html_nodes("._tracklist_move .ranking") %>% # 노드는 마디.ranking 클래스를 모두 가져온다.
  html_text() %>%  #텍스트화.
  as.numeric() # 텍스트를 숫자로 바꾸어 주는 전처리.

ranking
# 트랙리스트 클래스 안에 있는 랭킹 클래스를 가져온 것.
# 클래스 이름이 같은 것들이 있을 경우 그 부모 클래스 .or 자식 클래스를 
# 같이 적어주면 정확성이 높아진다.


# 순위 변동을 가져와 보자
gap <- naver_music %>% # 전체 트리 구조 안에서
  html_nodes("._tracklist_move .change") %>% # 노드는 마디.ranking 클래스를 모두 가져온다.
  html_text()  %>% #텍스트화.
  gsub(pattern = "\r\n||\t||\n||\r" , replacement = "" )  # pattern 안에는 없애고자 하는 단어,
# ||는 또는 의 의미이다. 
# gsub는 전처리기 함수. 지우고 싶은 단어들을 지워서 깔끔하게 만들어주는 
# 베이스 함수이다.
gap


#노래 제목을 가져와 보자
title <- naver_music %>% 
  html_nodes("._tracklist_move ._title span") %>% 
  html_text() %>% 
  gsub(pattern="\r\n||\t||", replacement="") %>% 
  trimws() # 공백 지워주는 함ㅅ
# 가져올 떄 tracklist_move 클래스 안의 title 클래스 안에 span 사이에
#원하는 정보가 껴 잇어서 span 까지 가져온 것이다.
# 가수 이름을 가져와 보자.

artist <- naver_music %>% 
  html_nodes("._tracklist_move ._artist a") %>% 
  html_text() %>% 
  gsub(pattern="\r\n||\t||", replacement="") %>% 
  trimws()
# artist 클래스가 하나만 있을 경우 trcaklist를 빼고 artist 만 넣어도 된다
# a 는 안넣을시 51개의 데이터가 온다. 제목이 딸려서 온다. a 클래스 안에
#원하는 정보가 껴 있었기 때문에 a 안쪽까지 들어간다.
#4. 데이터 프레임에 넣는다

musicTop50 <- data.frame(ranking , gap , title , artist)
musicTop50%>% head(5)
musicTop50 %>% tail(5)




artist2 <- naver_music %>% 
  html_nodes(".ellipsis") %>% 
  html_text() %>% 
  gsub(pattern="\r\n||\t||", replacement="") %>% 
  trimws()

artist2
# ??









