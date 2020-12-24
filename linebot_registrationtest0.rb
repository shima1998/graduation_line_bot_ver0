#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require "cgi"
require "uri"
require "json"
require "net/http"
require "mysql2"

puts <<-EOS                                                                                                              
Content-type: text/html\n\n

linebot
EOS

#パスはサーバーで入力
client = Mysql2::Client.new(host: '', username: '', password: '', :encoding => 'utf8', database: '')

data = CGI.new()
dValue = data.keys#LINEAPIで使うJSONが格納されてる
dJson = JSON.parse(dValue[0])
replyToken = dJson['events'][0]['replyToken']
userID = dJson["events"][0]["source"]["userId"]
regiCode = dJson["events"][0]["message"]["text"]
canGetInclude = "false"
subject = ""

if regiCode.include?("登録:") then
  canGetInclude = "true"
  subject = regiCode.delete!("登録:")#ここでもうもとの文字列から消されてる
  client.query("insert into *任意のテーブル名* values(\"#{subject}\",\"#{userID}\");")
end

channelAccessToken = ""

targetUri = "https://api.line.me/v2/bot/message/reply"

uri = URI.parse(targetUri)#OK

http = Net::HTTP.new(uri.host, uri.port)#
http.use_ssl = true #HTTPS 使う場合は trueを毎回設定

request = Net::HTTP::Post.new(uri)
request["Content-Type"] = "application/json"
request["Authorization"] = "Bearer #{channelAccessToken}"

reqBody = {"replyToken"=>"#{replyToken}","messages"=>[{"type"=>"text","text"=>canGetInclude.to_s}]}

request.body = reqBody.to_json
res = http.request(request)

f=File.open("test_stdin.txt", "w")
    f.write("bool:" + canGetInclude + "\n")
    f.write("UserID:" + userID.to_s + "\n")
    f.write("Code:" + regiCode.to_s + "\n")
    f.write("subject:" + subject.to_s + "\n")
f.close
