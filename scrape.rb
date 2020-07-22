require 'net/http'
require 'nokogiri'
require 'json'

# 対象サイトのHTMLを取得するメソッド
def get_from(url)
  Net::HTTP.get(URI(url))
end

# 取得したHTMLを保存するメソッド
def write_file(path, text)
  File.open(path, 'w') { |file| file.write(text) }
end

# newsを取得するメソッド
def scrape_news(news)
  {
    title: news.xpath('./p/strong/a').first.text,
    url: news.xpath('./p/strong/a').first['href']
  }
end

# sectionを取得するメソッド
def scrape_section(section)
  {
    category: section.xpath('./h6').first.text,
    news: section.xpath('./div/div').map { |node| scrape_news(node) }
  }
end


html = File.read('pitnews.html')
doc = Nokogiri::HTML.parse(html, nil, 'utf-8')
pitnews = doc.xpath('/html/body/main/section[position() > 1]').map { |section| scrape_section(section) }
write_file('pitnews.json', {pitnews: pitnews}.to_json)