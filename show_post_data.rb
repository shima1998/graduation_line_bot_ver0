#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require "cgi"
require "uri"

data = CGI.new()

d = data.keys
print "Content-type: text/html\n\n"


f=File.open("test_stdin.txt", "w")
f.write("length:" + (d.length).to_s + "\n")
for i in 0..(d.length - 1) do
 f.write("key:" + d[i]+ "\n")  # ファイルに書き込む
 f.write("value:" + data[d[i]] + "\n")
end
f.close




# jsonの文字列はkeyに完全に格納されており、valueは空という罠
# length:1
# key:{"events":[{"type":"message","replyToken":"","source":{"userId":"","type":"user"},"timestamp":,"mode":"active","message":{"type":"text","id":"","text":"keyにJSONが格納されます"}}],"destination":""}
# value:

