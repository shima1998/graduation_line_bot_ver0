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
replyToken = dJson['events'][0]['replyToken']

reqBody0 = {"first"=>["test","test2"],"second"=>[{"rep"=>"max","rep2"=>"max2"},{"rep"=>"max3","rep2"=>"max4"}], "third"=>"max5"}#テスト用変数

channelAccessToken = "htNZIbGAyild9vBwhBbrqrGg4VCZpoX/I/1EMOTj7Z0WbtiHoeND49zOqjEdEpCMnF9pv/iYUWzENZpU8bNztf0fPffWWASxAlaD8Aukfma++7Ljj491eIJtIAvk2X9S6n8P1DTJomw9NUGVhHTEaQdB04t89/1O/w1cDnyilFU="
#repToken = dJson['events'][0]['replyToken'].to_s#アウト

targetUri = "https://api.line.me/v2/bot/message/reply"

uri = URI.parse(targetUri)#OK

http = Net::HTTP.new(uri.host, uri.port)#
http.use_ssl = true #HTTPS 使う場合は trueを毎回設定
#http.verify_mode = OpenSSL::SSL::VERIFY_NONE#なんかだめだった

request = Net::HTTP::Post.new(uri)
request["Content-Type"] = "application/json"
request["Authorization"] = "Bearer #{channelAccessToken}"

reqBody = {"replyToken"=>"#{replyToken}","messages"=>[{"type"=>"text","text"=>"Hello, user"},{"type"=>"text","text"=>"May I help you?"}]}
request.body = reqBody.to_json
http.request(request)

#response = http.post_form(uri, request)

#puts response.code, response.msg, response.body

#response = Net::HTTP.start(uri.hostname, uri.port, http.use_ssl){|http|
 # http.request(request)
#}
f=File.open("test_stdin.txt", "w")
    f.write("length:" + (dValue.length).to_s + "\n")
    f.write("targetURI:" + targetUri + "\n")
    f.write("URIHost:" + uri.host.to_s + "\n")
    f.write("hashTest:" + reqBody0["second"][1]["rep"] + "\n")
    f.write("replyToken: " + reqBody["replyToken"] + "\n")
    f.write("HashToJson: " + reqBody.to_json + "\n")
    f.write("Content-Type: " + request["Content-Type"] + "\n")
    f.write("Authorization: " + request["Authorization"] + "\n")
    f.write("reqBody: " + request.body.to_s + "\n")
    #f.write("resBody: " + response.body.to_s + "\n")
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


puts <<-EOF
Content-type: text/html\n\n

linebot
EOF
