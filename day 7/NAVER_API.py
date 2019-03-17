import requests

def call(keyword , start): # 검색어, 페이지값
    url = "https://openapi.naver.com/v1/search/blog?query="+keyword + "&display=100" + "&start=" + str(start) #display :100개씩 보이도록
    
    result = requests.get(url = url, 
                         headers={"X-Naver-Client-Id": "P4OkJnk8FgF9b5b3P0Nv", 
                                  "X-Naver-Client-Secret": "OQgz7tBp23"})
    print(result)
    return result.json()# json형식으로 가져옴
    
    
def get1000result(keyword):
    list1 = []
    for num in range(0, 10):
        list1 = list1 + call(keyword , num*100+1)['items'] #items 라는 목록들만 가져온다. () 안은 json형태로 되어있는것
    return list1