# -*- coding: utf-8 -*-
"""
Created on Sun Mar 17 15:16:40 2019

@author: PC
"""

import mymodule.crawler as crawler

crawler.crawl("http://www.naver.com")

result = crawler.crawl("http://news.naver.com")
print(result)