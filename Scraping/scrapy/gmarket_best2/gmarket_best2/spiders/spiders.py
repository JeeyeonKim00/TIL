import scrapy
from gmarket_best2.items import GmarketBestItem


class Spider(scrapy.Spider):
    name = 'GmarketBestSellers'
    allowed_domains = ['gmarket.co.kr']
    start_urls = ['https://corners.gmarket.co.kr/bestsellers']

    def parse(self, response):
        links = response.xpath(
            "//*[@id='gBestWrap']/div/div[3]/div/ul/li/a/@href"
        ).extact()

        for link in links:
            yield scrapy.Request(link, callback=self.page_content)



    def page_content(self, response):
        item = GmarketBestItem()

        item['title'] =response.xpath(
            '//*[@id="itemcase_basic"]/div[1]/h1/text()'
        ).extract_first()

        item['s_price'] = response.xpath(
            '//*[@id="itemcase_basic"]/div[1]/p/span/strong/text()'
        ).extract_first().replace(",", "")

        try:
            item['o_price']=response.xpath(
                    '//*[@id="itemcase_basic"]/div[1]/p/span/span/text()'
                ).extract_first().replace(",", "")
            
        except:
            item["o_price"] = item["s_price"]

        item["discount_rate"] = str(
            round((1 - int(item["s_price"]) / int(item["o_price"]))*100, 2)) + "%"
        item["link"] = response.url 

        yield