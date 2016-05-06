describe HasOffersV3::Logger do
  let(:log) { double('log') }
  subject { described_class.new(log) }

  describe '.new' do
    it 'initializes properly' do
      expect(subject.log).to eql log
    end
  end

  describe '#log_request' do
    let(:request) do
      double('request',
        method: 'POST',
        each_capitalized: { 'Header' => 'value' },
        body: 'Var1=value1&Var2=value2'
      )
    end
    let(:uri) { double('uri', to_s: 'http://api.applift.com/path') }

    it 'logs HTTP request' do
      expected_message = "[HasOffersV3] Request: POST http://api.applift.com/path\nHeader: value\n\nVar1=value1&Var2=value2\n"
      expect(log).to receive(:info).with(expected_message)

      subject.log_request(request, uri)
    end
  end

  describe '#log_response' do
    let(:response) do
      double('response',
        http_version: '1.1',
        code: 200,
        message: 'OK',
        each_capitalized: { 'Header' => 'value' },
        body: 'Body of this response'
      )
    end

    it 'logs HTTP response' do
      expected_message = "[HasOffersV3] Response: HTTP/1.1 200 OK\nHeader: value\n\nBody of this response\n"
      expect(log).to receive(:info).with(expected_message)

      subject.log_response(response)
    end
  end
end
