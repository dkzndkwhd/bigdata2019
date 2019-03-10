install.packages("rJava") 
install.packages("DBI")
install.packages("RMySQL")
# R로 직접적인 데이터 조작은 불가능.
library(RMySQL)
# 1. DB 연결하기
con <- dbConnect(MySQL(), dbname = "bigdata" , user ='root' , password = "1234")
# 데이터베이스 이름, 유저명( 루트는 기본값) 패스워드 순서대로 입력한다.
dbListTables(con) # db안에 들어있는 테이블을 보여달라. (테이블 이름)
dbListFields(con , 'member') #db안에 있는 필드(항목)들을 출력하라.
d <- dbReadTable(con , "member") # 멤버 테이블을 읽어온다
d

################################################
#csv sql에 덮어씌우기 (db에 파일 읽어서 넣기.)
dfdata <- read.csv("member.csv", head = T)
dfdata

dbWriteTable(con, "member", dfdata, overwrite = T) # R에서기 csv파이 sql 데이터에 덮어씌우기.

d <- dbReadTable(con , "member") # 멤버 테이블을 읽어온다
d

################################################
# sql에서 R로 받아오기 (SQL 문을 요청해서 결과 받아오기.)
df.table <- dbGetQuery(con, "select * from member")
df.table
class(df.table)

# db 연결 끊기 --> 안하면 항상 연결되어 있어서 작업용량이 줄어든다.
dbDisconnect(con)
# 2. SQL문 실행 요청