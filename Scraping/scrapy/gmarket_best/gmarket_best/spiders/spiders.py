import scrapy
from gmarket_best.items import GmarketBestItem


# class라는게

class Spider(scrapy.Spider):

    # 1. 스파이더의 이름(크롤러의 이름)
    name = 'GmarketBestSellers'

    # 2. 크롤링할 웹 사이트의 도메인 (호스트)
    allowed_domains = ['gmarket.co.kr']

    # 3. 스크래이핑 시작할 주소(크롤링 어디서부터 할거니?)
    start_urls = ['https://corners.gmarket.co.kr/BestSellers']

    # 크롤링을 수행하여 item으로 만들어주는 메소드
    # start_urls로 요청을 보낸 결과가 들어옴
    # start_ulrs로 들어갔을 때 시작하는 것들
    def parse(self, response):
        links = response.xpath(
            '//*[@id="gBestWrap"]/div/div[3]/div/ul/li/a/@href'
        ).extract()

        # Request 객체를 만들어서 스파이더한테 던짐
        for link in links:
            # callback: 작업의 결과를 어떻게 처리할지를 지정
            # Request 객체를 만들어서 스파이더한테 던져줌
            yield scrapy.Request(link, callback=self.page_content)

    # 상세 페이지에서 데이터를 추출

    def page_content(self, response):

        # 스크레이핑한 데이터를 저장할 GmarketBestItem
        item = GmarketBestItem()

        # item의 멤버 변수의 이름과 키의 이름은 항상 일치..
        # 즉, item[a] 에서 a에 들어가는 멤버 변수는 items.py에 있는 키 이름과 일치해야
        item["title"] = response.xpath(
            '//*[@id="itemcase_basic"]/div[1]/h1/text()'
        ).extract_first()

        item["s_price"] = response.xpath(
            '//*[@id="itemcase_basic"]/div[1]/p/span/strong/text()'
        ).extract_first().replace(",", "")

        try:
            item["o_price"] = response.xpath(
                '//*[@id="itemcase_basic"]/div[1]/p/span/span/text()'
            ).extract_first().replace(",", "")

        except:
            item["o_price"] = item["s_price"]

        item["discount_rate"] = str(
            round((1 - int(item["s_price"]) / int(item["o_price"]))*100, 2)) + "%"
        item["link"] = response.url  # 요청한 링크 얻기

        yield
        # link 안에
