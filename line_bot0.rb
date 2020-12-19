#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require "cgi"
require "uri"

#data = CGI.new()

# s = STDIN.read


post = $stdin.read

###########################################################################################
# WebhookURLのverify時に送られるJSONは{"events":[],"destination":"任意のdestination"}
# 
# 文章が送られてきたときのデータは改行なしで、JSON形式
# {
# "events":[{
#     "type":"message",
#     "replyToken":"任意のリプライトークン",
#     "source":{
#         "userId":"ユーザーのID",
#         "type":"user"
#         },
#     "timestamp":任意のタイムスタンプ(int),
#     "mode":"active",
#     "message":{
#         "type":"text",
#         "id":"任意のID",
#         "text":"ふぁふぁふぁ"
#         }
#     }],
# "destination":"任意のdestination"
# }
###########################################################################################


a = "aaaaaaa"

p = post.to_s

#d = data




print "Content-type: text/html\n\n"

print a

f =File.open("test_stdin.txt", "w")
f.write(p)  # ファイルに書き込む
f.close
   
# print "<br>"
# #print data['book_name']
# print "<br>"
# #print "content: " + data.content_type
# print "<br>"
# #print data.content_length
# print "<br>"
# #print data.query_string
# print "<br>"
# #print data.request_method
# print "<br>"
# print "stdin: " + s
# print "<br>"
# print s.length
# print "<br>"
# print "stdinsplit: " + s.split("&").to_s
# print "<br>"
# #print p
# print "<br>"
# #print p.length
# print "<br>"
# #print URI.decode_www_form(d)
# print "<br>"
# #print URI.decode_www_form(p)
# print "<br>"