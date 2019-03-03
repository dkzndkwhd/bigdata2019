#!/usr/bin/env python
# coding: utf-8

# In[1]:


from tkinter import *


# In[2]:


def f1():
    print("나를 호출했군요..")
    print("내가 실행될 코드입니다..")

f1()


# In[4]:


def f2():
    print("나는 f2입니다.")
    print("내가 실행될 코드입니다..")
    
def f3():
    print("나는 f3입니다.")
    print("내가 실행될 코드입니다..")

f2()
print()
f3()


# In[34]:


def call(event):
    print("버튼을 누르셨군요.")
    a = 100
    b = 200
    print(a+b)
    l["text"] = "나로 바꿔요."
    

w = Tk()
w.configure(bg="white")
b = Button(w, text="합계를 구해주세요.")
b.pack()

b.bind("<Button-1>", call)

l = Label(w, text="반갑습니다...", bg="white", font=("궁서체",30))
l.pack()

w.mainloop()







# In[ ]:




