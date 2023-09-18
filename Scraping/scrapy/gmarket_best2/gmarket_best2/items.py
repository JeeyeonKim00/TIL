# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class GmarketBestItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    title = scrapy.Field()
    s_price = scrapy.Field()
    o_price = scrapy.Field()
    discount_rate = scrapy.Field()
    link = scrapy.Field()
