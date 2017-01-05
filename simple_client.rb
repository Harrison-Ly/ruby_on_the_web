require "socket"
require "json"

hostname = "localhost"
port = 8080
path = "/index.html"

puts "What request do you want to send?"
ans = gets.chomp

request = ""
if ans == "GET"
  request = "GET #{path} HTTP/1.0\r\n\r\n"
elsif ans == "POST"
  hash = {}
  puts "what is you name?"
  name = gets.chomp
  puts "what is your email?"
  email = gets.chomp
  hash[:viking] = {:name => name, :email => email}
  request = "#{ans} /post HTTP/1.0\r\nContent-Length: #{hash.to_json.length}\r\n#{hash.to_json}"
end

s = TCPSocket.open(hostname, port)
s.puts(request)
while line = s.gets
  puts line
end
s.close
