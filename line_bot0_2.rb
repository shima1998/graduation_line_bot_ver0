# -*- coding: utf-8 -*-
require "cgi"
require "uri"

data = CGI.new()

d = data['datatext']
print "Content-type: text/html\n\n"
print a
f =File.open("test_stdin.txt", "w")
f.write(d.to_s)  # ファイルに書き込む
f.close