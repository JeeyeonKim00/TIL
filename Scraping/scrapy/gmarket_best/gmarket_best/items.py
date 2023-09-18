# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy

# spiders.py의 결과물=item.py
class GmarketBestItem(scrapy.Item): #수집대상                                      
    title = scrapy.Field() #상품명
    s_price = scrapy.Field() #할인 가격
    o_price = scrapy.Field() #원래 가격
    discount_rate = scrapy.Field() #할인율
    link = scrapy.Field() #상세 페이지 링크

