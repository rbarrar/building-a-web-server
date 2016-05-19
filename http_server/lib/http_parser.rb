require "rack"
# This is a subclass from Exception
EmptyRequestError = Class.new Exception

class HttpParser
  def parse(socket)
    line = socket.gets
    raise EmptyRequestError if line.nil?

    Request.new do |request|
      request.path = line.split(" ")[1]
      request.http_method = line.split(" ")[0]
      request.headers = parse_headers(socket)

      unless ["GET", "DELETE"].include? request.http_method
        request.body = parse_body(socket, request.headers["Content-length"].to_i)
      end

    end
  end

  private

  def parse_headers(socket)
    request_headers = {}
    while (line = socket.gets) != "\r\n"
      key = line.split(": ").first
      value = line.split(": ").last.chomp
      request_headers[key] = value
    end
    request_headers
  end

  def parse_body(socket, number_of_bytes)
    raw_body = socket.read(number_of_bytes)
    Rack::Utils.parse_nested_query raw_body
  end

end
