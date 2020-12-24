#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require "cgi"
require "uri"
require "json"
require "net/http"
require "mysql2"

# Only receive POST_Data                                                                                                 
# I want to receive POST_Data from CGI, but I couldn't get String. I get string "#<CGI:~~~~~>" from CGI only.

puts <<-EOS                                                                                                              
Content-type: text/html\n\n

linebot
EOS

client = Mysql2::Client.new()

data = CGI.new()
dValue = data.keys#LINEAPIで使うJSONが格納されてる
dJson = JSON.parse(dValue[0])
replyToken = dJson['events'][0]['replyToken']
userID = dJson["events"][0]["source"]["userId"]
regiCode = dJson["events"][0]["message"]["text"]
canGetInclude = "true"

toUserResponse = "Undefined"

#regiCodeSave = regiCode#deleteしたらこの値まで変わってしまうらしい

#regiCodeBool = dJson["events"][0]["message"]["text"]#deleteで消されないための変数
subject = regiCode.delete("登録:")#!をつけると、ここでもうもとの文字列から消されてる

lineDBs = client.query("select * from ;")

lineDBs.each do |lineDB|#重複がないか確認して重複したらFalse
  if lineDB["ID"] == userID || lineDB["USER"] == subject then
    canGetInclude = "false"
  end
end

if regiCode.include?("登録:") && canGetInclude == "true" then #上記のeach分で重複がなければ登録ができるはずだ
  client.query("insert into  values(\"#{subject}\",\"#{userID}\");")
end

channelAccessToken = ""

targetUri = "https://api.line.me/v2/bot/message/reply"

uri = URI.parse(targetUri)#OK

http = Net::HTTP.new(uri.host, uri.port)#
http.use_ssl = true #HTTPS 使う場合は trueを毎回設定

request = Net::HTTP::Post.new(uri)
request["Content-Type"] = "application/json"
request["Authorization"] = "Bearer #{channelAccessToken}"

if regiCode.include?("登録:") then#何が起きたのか返したい
  if canGetInclude == "true" then
    toUserResponse = "You can regist ID!"
  elsif canGetInclude == "false" then
    toUserResponse = "You can't regist ID..."
  else
    toUserResponse = "Error"
  end
else 
  toUserResponse = "Please, registration code."
end


reqBody = {"replyToken"=>"#{replyToken}","messages"=>[{"type"=>"text","text"=>toUserResponse.to_s}]}

request.body = reqBody.to_json
res = http.request(request)

f=File.open("test_stdin.txt", "w")
    f.write("bool:" + canGetInclude + "\n")
    f.write("UserID:" + userID.to_s + "\n")
    f.write("Code:" + regiCode.to_s + "\n")
#    f.write("DBs:" + lineDBs[3]["USER"].to_s + "\n")
    f.write("subject:" + subject.to_s + "\n")
f.close
