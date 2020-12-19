#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require 'mysql2'
require 'cgi'
require 'date'

data=CGI.new()

#グローバル変数
$_GET = {}
$_POST = {}
$_COOKIE = {}
$_FILES = []

s = STDIN.read

# Rubyの正規表現による置換
s = s.gsub(/[\d]+/,'') #数値を除去

# # 正規表現で判定
# if s =~ /\A\d+\z/
#     # 数値のみ
# end

# リクエストのメソッド判定
if ENV['REQUEST_METHOD']=='POST'

　　# multipart/form-data を判定
  if ENV['CONTENT_TYPE'].match(/multipart/form-data; boundary=(.+)/)

　　　　# 区切り文字列のboundaryを取得して渡し
    $_POST = multipart($1)

  else
　　　　# 標準入力から取り出して渡し
    $_POST = decode(STDIN.read)
  end
end
