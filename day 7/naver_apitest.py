# -*- coding: utf-8 -*-
"""
Created on Sun Mar 17 15:57:13 2019

@author: PC
"""

import mymodule.NAVER_API as naver

#result = naver.call("휴대폰", 1) 
#print(result)

result2 = naver.get1000result("휴대폰")
print(result2)