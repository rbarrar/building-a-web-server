require './lib/http_parser.rb'
require './lib/request.rb'

describe HttpParser do
  subject { described_class.new }

  context '#parse' do
    subject { described_class.new }
    it 'with a nil request raises an empty request error' do
      request = StringIO.new ""
      expect{ subject.parse(request) }.to raise_error EmptyRequestError
    end

    context 'with valid request' do
      let(:request) {StringIO.new "GET /index.html\r\n\r\n"}
      it 'returns a request object' do
        expect(subject.parse(request)).to be_a Request
      end

      it 'parses the correct path' do
        parsed = subject.parse(request)
        expect(parsed.path).to eq "/index.html"
      end

      it 'parses the correct HTTP method' do
        parsed = subject.parse(request)
        expect(parsed.http_method).to eq "GET"
      end

      it 'parses the correct headers' do
        request = StringIO.new "GET /index.html\r\nAccept: text/html\r\nContent-type: text/html\r\n\r\n"
        parsed = subject.parse(request)
        expect(parsed.headers).to eq({
          "Accept" => "text/html",
          "Content-type" => "text/html"
          })
        end

        it 'reads the request body and parses it into a hash' do
          request = StringIO.new "POST /index.html\r\nAccept: text/html\r\nContent-type: text/html\r\nContent-length: 11\r\n\r\nq=hello&a=1"
          parsed = subject.parse(request)
          expect(parsed.body).to eq({ "q" => "hello", "a" => "1"})
        end
      end
    end
  end
