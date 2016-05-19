require "./lib/request.rb"

describe Request do
  subject do
    described_class.new do |r|
      r.http_method = "GET"
      r.path = "/test"
      r.query = {key: 'value'}
      r.post_data = {hello: 'world'}
    end
  end

  context "#initialize" do
    it "defaults post_data to an empty hash" do
      expect(described_class.new.post_data).to eq({})
    end
    it "accepts a block yielding itself" do
      described_class.new do |request|
        expect(request).to be_a(described_class)
      end
    end
  end
  context "#headers" do # see request_headers_spec for more info
    it "is a Hash" do
      expect(subject.headers).to be_a Hash
    end
  end
  context "#info" do
    it "returns a string of the HTTP method and path" do
      expect(subject.info).to eq('GET /test')
    end
  end
  context "#params" do
    it "merges the query hash and post_data hash and memoizes it" do
      expect(subject.params).to eq({key: "value", hello: "world"})
      expect(subject.params.object_id).to be subject.params.object_id
    end
  end
  context "#cookies" do
    it "returns a hash" do
      expect(subject.cookies).to be_a Hash
    end
  end
  context "#content_length" do
    it "returns an integer" do
      expect(subject.content_length).to be_a Integer
    end
  end
end
