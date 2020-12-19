#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require "cgi"
require "uri"
 
data = CGI.new()

dStr = data.to_s

#$stdin = data

# post = $stdin

a = "aaaaaaa"

# p = post.to_s

#d = data

print "Content-type: text/html\n\n"

print a
print "<br>"
print data['book_name'].to_s
print "<br>"
print dStr
print "<br>"
print "content: " + data.content_type
print "<br>"
print data.content_length
print "<br>"
print data.query_string
print "<br>"
print data.request_method
print "<br>"
# print "stdin: " + s
print "<br>"
# print s.length
print "<br>"
# print "stdinsplit: " + s.split("&").to_s
print "<br>"
#print p
print "<br>"
print p.length
print "<br>"
print URI.decode_www_form(d)
print "<br>"
print URI.decode_www_form(p)
print "<br>"
