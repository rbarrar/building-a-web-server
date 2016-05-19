require './lib/request'
require './lib/http_parser'
require 'socket'

class HttpServer < TCPServer
  def serve
    parser = HttpParser.new

    while socket = accept
      request = parser.parse socket
      response = "Parsed request: #{request.inspect}"

      socket.write response
      socket.close
    end
  end
end

puts "listening on localhost:9000..."

HttpServer.new(9000).serve
