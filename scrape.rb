require 'net/http'

# 対象サイトのHTMLを取得するメソッド
def get_from(url)
  Net::HTTP.get(URI(url))
end

# 取得したHTMLを保存するメソッド
def write_file(path, text)
  File.open(path, 'w') { |file| file.write(text) }
end


require 'nokogiri'

html = File.open('pitnews.html', 'r') { |f| f.read }
doc = Nokogiri::HTML.parse(html, nil, 'utf-8')

section = doc.xpath('/html/body/main/section[2]').first

pitnews = []
doc.xpath('/html/body/main/section').each_with_index do |section, index|

  next if index.zero?

  contents = {category: nil, news: []}
  contents[:category] = section.xpath('./h6').first.text
  
  section.xpath('./div/div').each do |node|
    title = node.xpath('./p/strong/a').first.text
    url = node.xpath('./p/strong/a').first['href']
    
    news = {title: title, url: url}
    contents[:news] << news
  end

  pitnews << contents  
end


require 'json'

File.open('pitnews.json', 'w') { |file| file.write({pitnews: pitnews}.to_json) }