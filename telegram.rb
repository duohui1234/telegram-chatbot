require 'rest-client'
require 'json'
require 'nokogiri'
require 'telegram/bot'



token = ENV["telegram_token"]

url = "https://api.telegram.org/bot#{token}/getUpdates"
res = RestClient.get(url)
id = JSON.parse(res)["result"][0]["message"]["from"]["id"]


bike_url = "https://www.bikeseoul.com/app/station/getStationRealtimeStatus.do?stationGrpSeq=15"
bike_res = RestClient.get(bike_url)
bike_json = JSON.parse(bike_res)["realtimeList"]
result = bike_json.select { |e| e["stationId"] == "ST-983" } 
result =  result[0]["parkingBikeTotCnt"]


    #         url = "https://comic.naver.com/index.nhn"
    #         webtoon_html = RestClient.get(url)
    #         genre = Nokogiri::HTML(webtoon_html).css('div.tab_gr li a')
    #         genre.lenth


bike_msg = "군자역 2번출구 대여가능 자전거 수: " + result
msg_url = URI.encode("https://api.telegram.org/bot#{token}/sendmessage?chat_id=#{id}&text=#{bike_msg}")
RestClient.get(msg_url)



