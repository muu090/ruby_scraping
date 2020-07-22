file = File.open('scrape.rb', 'r') # 'r' => ファイルを読み込みモードで開く
puts file.read
file.close

file = File.open('hello.txt', 'w') # 'w' => ファイルを書き込みモードで開く　※既に存在するファイルの場合中身を空にしてしまう）
file.write('Hello World!')
file.close