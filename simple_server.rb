require "socket"

server = TCPServer.new("localhost", 8080)
loop {
  connection = server.accept

  method, path, ver = connection.gets.split(" ")
  if method == "GET"
    if path == "/index.html"
      connection.puts "HTTP/1.0 200 OK"
      connection.puts "Date: #{Time.now.ctime}"

      body = File.open("index.html", "r").readlines
      connection.puts "Content-Type: text/html"
      connection.puts "Content-Length: #{body.join("").length}"
      connection.puts "\r\n\r\n"
      connection.puts body
    else
      connection.puts "HTTP/1.0 404 Not Found"
    end
  end
  connection.close
}
