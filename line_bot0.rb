#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require "cgi"
require "uri"
require "json"
require "net/http"
# Only receive POST_Data                                                                                                  
# I want to receive POST_Data from CGI, but I couldn't get String. I get string "#<CGI:~~~~~>" from CGI only.             

data = CGI.new()

d = data.keys
print "Content-type: text/html\n\n"


f=File.open("test_stdin.txt", "w")
f.write("length:" + (d.length).to_s + "\n")
for i in 0..(d.length - 1) do
 f.write("key:" + d[i]+ "\n")  # ファイルに書き込む                                                                       
 f.write("value:" + data[d[i]] + "\n")
 dJson = JSON.parse(d[i])
 f.write("json: " + dJson["destination"].to_s + "\n")
end


###########################################################################################
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
