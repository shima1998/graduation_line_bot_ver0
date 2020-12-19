#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require "cgi"
require "uri"
require "json"

data = CGI.new()

a = "aaaaaaa"

# dJson = JSON.parse(data.to_s)

dStr = data.to_s

# p = post.to_s

#d = data

print "Content-type: text/html\n\n"

print a
print "<br>"
print dStr
# print dJson


f =File.open("test_stdin.txt", "w")
f.write(dStr)  # ファイルに書き込む
f.close

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