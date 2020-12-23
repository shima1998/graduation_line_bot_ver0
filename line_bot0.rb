#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require "cgi"
require "uri"
require "json"
require "net/http"

# Only receive POST_Data
# I want to receive POST_Data from CGI, but I couldn't get String. I get string "#<CGI:~~~~~>" from CGI only.

#認証用
print <<-EOF
Content-type: text/html\n\n

linebot
EOF

#data = CGI.new()
#dValue = data.keys#LINEAPIで使うJSONが格納されてる
#dJson = JSON.parse(dValue[0])
#replyToken = dJson['events'][0]['replyToken']

channelAccessToken = "アクセストークン"
targetUri = "https://api.line.me/v2/bot/message/push"

uri = URI.parse(targetUri)#OK

http = Net::HTTP.new(uri.host, uri.port)#
http.use_ssl = true #HTTPS 使う場合は trueを毎回設定

request = Net::HTTP::Post.new(uri)
request["Content-Type"] = "application/json"
request["Authorization"] = "Bearer #{channelAccessToken}"

usrID = "超個人情報やで"

reqBody = {"to"=>"#{usrID}","messages"=>[{"type"=>"text","text"=>"Hey, Guys!"},{"type"=>"text","text"=>"It'push"}]}

request.body = reqBody.to_json
#http.request(request)
res = http.request(request)

#以下確認用
f=File.open("test_pushtest.txt", "w")
    f.write("ChannelAccessToken:" + channelAccessToken + "\n")
#    f.write("length:" + (dValue.length).to_s + "\n")
    f.write("targetURI:" + targetUri + "\n")
    f.write("URIHost:" + uri.host.to_s + "\n")
#    f.write("hashTest:" + reqBody0["second"][1]["rep"] + "\n")
    f.write("UserID: " + reqBody["to"] + "\n")
    f.write("HashToJson: " + reqBody.to_json + "\n")
    f.write("Content-Type: " + request["Content-Type"] + "\n")
    f.write("Authorization: " + request["Authorization"] + "\n")
    f.write("reqBody: " + request.body.to_s + "\n")
    f.write("resCode: " + res.code.to_s + "\n")
    f.write("resBody: " + res.body.to_s + "\n")
    f.write("resMsg: " + res.message.to_s + "\n")
    f.write("resEntity: " + res.entity.to_s + "\n")
    f.write("resValue: " + res.value.to_s + "\n")
f.close
