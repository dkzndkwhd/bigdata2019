#1. 네트워크 연결 (requests)
#2. 결과값 받아온 것을 분석(뷰티풀숲 bs4)

import requests
from bs4 import BeautifulSoup

def crawl(url) :
    print(url , ": crawl")
    result = requests.get(url)
    body_content = BeautifulSoup(result.content, "html.parser")
    return body_content

    
    
    
    

