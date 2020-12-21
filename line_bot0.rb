#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require "cgi"
require "uri"
require "json"
require "net/http"
# Only receive POST_Data                                                                                                  
# I want to receive POST_Data from CGI, but I couldn't get String. I get string "#<CGI:~~~~~>" from CGI only.             

data = CGI.new()

targetUri = "https://api.line.me/v2/bot/message/reply"
uri = URI.parse(targetUri)#URLをURIオブジェクトにしてRubyでオブジェクトとして使えるようにしている
httpReq = Net::HTTP::Post.new(uri)
channelAccessToken = "任意のチャンネルアクセストークン"

dValue = data.keys#LINEAPIで使うJSONが格納されてる

# dJson = JSON.parse(dValue[0])#データをJSON化した

# replyToken = dJson['events'][0]['replyToken'].to_s


#print "Content-type: text/html\n\n"

f=File.open("test_stdin.txt", "w")
f.write("length:" + (dValue.length).to_s + "\n")
for i in 0..(dValue.length - 1) do
    f.write("key:" + dValue[i]+ "\n")  # ファイルに書き込む                                                                       
    f.write("value:" + data[dValue[i]] + "\n")
    dJ = JSON.parse(dValue[i])
    f.write("Jsonlength:" + (dJ.length).to_s + "\n")
    f.write("jsonDesitination: " + dJ["destination"].to_s + "\n")
    f.write("jsonEvents: " + dJ['events'][0].to_s + "\n")
    f.write("jsonReplyToken: " + dJ['events'][0]['replyToken'].to_s + "\n")
end

dJson = JSON.parse(dValue[0])
rToken = dJson['events'][0]['replyToken'].to_s

httpReq.content_type = "application/json"
httpReq["Authorization"] = "Bearer #{channelAccessToken}"
httpReq.body = JSON.dump({
    replyToken => "#{rToken}",
    messages => [
      {
        type => "text",
        text => "Hello, user"
      }
    ]
  })

reqOptions = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, reqOptions) do |http|
  http.request(httpReq)
end

# response.code
# response.body

# channelAccessToken = "任意のチャンネルアクセストークン"
# replyJsonStr = "{
#         \"replyToken\": \"#{replyToken}\",
#         \"messages\":[
#             {
#                 \"type\":\"text\",
#                 \"text\":\"OK!\"
#             }
#         ]
#     }"#JSONを文字列で作って後でJSONに変えます

# replyJson = JSON.parse(replyJsonStr)

# httpReq.post(uri.path, replyJson, header = "Content-type: application/json\n" + "Authorization: Bearer #{channelAccessToken}")#ヘッダーを送ってJSONを送る

# f=File.open("test_stdin.txt", "w")
# f.write("length:" + (dValue.length).to_s + "\n")
# f.write("Jsonlength:" + (dJson.length).to_s + "\n")
# for i in 0..(dValue.length - 1) do
#     f.write("key:" + dValue[i]+ "\n")  # ファイルに書き込む                                                                       
#     f.write("value:" + data[dValue[i]] + "\n")
#     # dJson = JSON.parse(dValue[i])
#     f.write("jsonDesitination: " + dJson["destination"].to_s + "\n")
#     f.write("jsonReplyToken: " + dJson["replyToken"].to_s + "\n")
# end

# H = ["Content-type: application/json", "Authorization: Bearer #{channelAccessToken}"]




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
