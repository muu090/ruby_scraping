require 'net/http'

url = 'https://masayuki14.github.io/pit-news/' # 対象サイト指定
uri = URI(url)
html = Net::HTTP.get(uri) # 対象サイトのHTMLを取得しhtmlに代入

file = File.open('pitnews.html', 'w') # pitnews.htmlというファイルを書き込みモードで開く（作成）
file.write(html) # 作成したpitnews.htmlファイルに先の処理で取得したHTMLが代入されたhtmlの情報を書き込む
file.close