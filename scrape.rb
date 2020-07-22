require 'net/http'

# 対象サイトのHTMLを取得するメソッド
def get_from(url)
  Net::HTTP.get(URI(url))
end

# 取得したHTMLを保存するメソッド
def write_file(path, text)
  File.open(path, 'w') { |file| file.write(text) }
end

# html = get_from('https://masayuki14.github.io/pit-news/')
# write_file('pitnews.html', html)
# ↓上の２行を１行で書くとこうなる
write_file('pitnews.html', get_from('https://masayuki14.github.io/pit-news/'))

