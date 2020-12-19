#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require "cgi"
require "uri"
require "json"

data = CGI.new()

a = "aaaaaaa"

# p = post.to_s

#d = data

print "Content-type: text/html\n\n"

print a
print "<br>"
print data['book_name'].to_s

f =File.open("test_stdin.txt", "w")
f.write(data['destination'].to_s)  # ファイルに書き込む
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

# s = STDIN.read


# post = $stdin.read

###########################################################################################
# POSTで送られてきたJSONをまんまtxtに入れてみた結果                                          #
###########################################################################################
# WebhookURLのverify時に送られるJSONは
# {"events":[],"destination":"任意のdestination"}
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
# 返信する際のテンプレートのJSON
# 
# 'Content-Type: application/json' \
# 'Authorization: Bearer {channel access token}' \
# '{
#     "replyToken":"nHuyWiB7yP5Zw52FIkcQobQuGDXCTA",
#     "messages":[
#         {
#             "type":"text",
#             "text":"Hello, user"
#         },
#         {
#             "type":"text",
#             "text":"May I help you?"
#         }
#     ]
# }'
###########################################################################################