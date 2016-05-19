require './request'
require './http_parser'
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

HttpServer.new(9000).serve
