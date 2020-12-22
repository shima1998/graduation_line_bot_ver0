#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require "cgi"
require "uri"
require "json"
require "net/http"

# Only receive POST_Data                                                                                                  
# I want to receive POST_Data from CGI, but I couldn't get String. I get string "#<CGI:~~~~~>" from CGI only.             
data = CGI.new()
dValue = data.keys#LINEAPIで使うJSONが格納されてる
dJson = JSON.parse(dValue[0])

channelAccessToken = "任意のチャンネルアクセストークン"
#repToken = dJson['events'][0]['replyToken'].to_s#アウト

targetUri = "https://api.line.me/v2/bot/message/reply"

uri = URI.parse(targetUri)#OK
reqBody0 = {"first"=>["test","test2"],"second"=>[{"rep"=>"max","rep2"=>"max2"},{"rep"=>"max3","rep2"=>"max4"}]}

http = Net::HTTP.new(uri.host, uri.port)#

#http.use_ssl = true #HTTPS 使う場合は trueを毎回設定
#http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(uri)
request["Content-Type"] = "application/json"
request["Authorization"] = "bearer #{channelAccessToken}"

f=File.open("test_stdin.txt", "w")
    f.write("length:" + (dValue.length).to_s + "\n")
    f.write("targetURI:" + targetUri + "\n")
    f.write("URIHost:" + uri.host.to_s + "\n")
    f.write("replyToken:" + reqBody0["first"][1] + "\n")
    f.write("Content-Type: " + request["Content-Type"] + "\n")
    f.write("Authorization: " + request["Authorization"] + "\n")
for i in 0..(dValue.length - 1) do
    f.write("key:" + dValue[i]+ "\n")  # ファイルに書き込
    f.write("value:" + data[dValue[i]] + "\n")
    dJ = JSON.parse(dValue[i])
    f.write("Jsonlength:" + (dJ.length).to_s + "\n")
    f.write("jsonDesitination: " + dJ["destination"].to_s + "\n")
    f.write("jsonEvents: " + dJ['events'][0].to_s + "\n")
    f.write("jsonReplyToken: " + dJ['events'][0]['replyToken'].to_s + "\n")
end
f.close


reqLook = JSON.parse(reqBody)

f=File.open("lookBody.txt", "w")
f.write("body:" + reqLook["messages"][0]["text"].to_s + "\n")


request.body = reqBody

response = http.request(request)

f=File.open("test_response.txt", "w")
f.write("code:" + response.code + "\n")
f.write("msg: " + response.msg + "\n")
f.write("msg: " + response.body + "\n")


#puts response.code, response.msg, response.body
puts <<-EOS                                                                                                              
Content-type: text/html\n\n

linebot
EOS

# 返信で送るJSONの形
# 'Content-Type: application/json' 
#  'Authorization: Bearer {channel access token}' 
#  '{
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
