require './lib/http_parser.rb'

describe HttpParser do
  subject { described_class.new }

  context '#parse' do
    it 'with a nil request raises an empty request error'
    context 'with valid request' do
      it 'returns a request object'
      it 'parses the correct path'
      it 'parses the correct HTTP method'
      it 'parses the correct headers'
      it 'reads the request body and parses it into a hash'
    end
  end
end
