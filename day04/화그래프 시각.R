library(ggplot2)

mpg <- as.data.frame(ggplot2::mpg) # ggplot에서 제공하는 데이터 불러오기. ::하면 다른 데이터들도 나옴.

# 산점도 그리기.
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() # $ 는 쓰지 않는다.


midwest <- as.data.frame(ggplot2::midwest)
ggplot(data = midwest, aes(x = poptotal, y = popasian)) + 
  geom_point() +
  xlim(0 , 500000) +  # x축y축에 한계 설정하기
  ylim(0, 10000)


# 막대 그래프 - 평균 막대 그래프 만들기
library(dplyr) # 라이브러리는 위에다 몰아넣는게 좋다.

df_mpg <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy)) 

ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) +
  geom_col()

# 상자 그림 만들기.
ggplot(data = mpg , aes(x = drv , y = hwy)) +
  geom_boxplot()

# 다른 그래프들도 한번 연습해 보기.
# 1. geom_point() 산점도.
# 2. geom_col() 막대 그래프 - 요약표.
# 3. geom_bar() 막대 그래프 - 원자료.
# 4. geom_line() 선 그래프.
# 5. geom_boxplot() 상자 그림.
