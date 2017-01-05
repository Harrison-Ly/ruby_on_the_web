require "socket"

hostname = "localhost"
port = 8080
path = "/index.html"

request = "GET #{path} HTTP/1.0\r\n\r\n"

s = TCPSocket.open(hostname, port)
s.puts(request)
while line = s.gets
  puts line.chop
end
s.close
