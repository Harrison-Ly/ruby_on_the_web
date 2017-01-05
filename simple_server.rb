require "socket"
require "json"

server = TCPServer.new("localhost", 8080)
puts "server running..."

loop {
  connection = server.accept
  method, path, ver, content = connection.gets.split(" ")
  header = connection.gets
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
  elsif method == "POST"
      if path == "/post"
        params = JSON.parse(connection.gets)
        output = ""
        params["viking"].each { |k, v| output << "<li>#{k}: #{v}</li>" }

        thanks_html = File.open("thanks.html", "r").readlines.join("")
        send = thanks_html.gsub("<%= yield %>", output)
        connection.puts send
      end
  end
  
  connection.close
}
