class Request

  attr_reader :headers, :info
  attr_accessor :http_method, :path, :query, :post_data, :cookies, :content_length

  def initialize
    @headers = {}
    @cookies = {}
    @post_data = {}
    @content_length = 0
    yield self if block_given?
  end

  def info
    return "#{@http_method} #{@path}"
  end

  def params
    @params ||= @query.merge(@post_data)
  end

end
