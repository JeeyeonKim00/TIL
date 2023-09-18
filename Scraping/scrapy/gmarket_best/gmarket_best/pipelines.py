# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
from itemadapter import ItemAdapter
import requests
import json


class GmarketBestPipeline:

    def __send_slack(self, msg):
        WEBHOOK_URL = ####

        payload = {
            "channel": "#잡담",
            "username": "알림봇",
            "text": msg
        }

        print("payload", payload)

        requests.post(WEBHOOK_URL, json.dumps(payload))

    # ⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐⭐
    # 크롤링 된 아이템을 최종적으로 후처리
    #  pipeline작동시키려면 settings.py들어가서 item_pipelines주석 풀기

    def process_item(self, item, spider):

        keyword = '봄'

        if keyword in item['title']:
            msg = f"/{keyword}알림!🍀🍀 // {item['title'], {item['s_price'], {item['link']}}}"
            self.__send_slack(msg)
        return item
