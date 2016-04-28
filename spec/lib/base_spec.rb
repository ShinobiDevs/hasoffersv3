describe HasOffersV3::Base do
  let(:url) { Regexp.new api_url('Base') }

  describe "#requires!" do
    it 'raises ArgumentError is parameters are missing' do
      expect { subject.requires!({}, [:dummy]) }.to raise_error(ArgumentError)
    end
  end

  describe "#get_request" do
    it "makes a proper request" do
      stub_call :get
      response = subject.get_request 'test'
      request = a_request(:get, url).with(query: hash_including('Method' => 'test'))
      expect(request).to have_been_made
      validate_call response
    end

    context "with HTTPS enabled" do

      before(:each) do
        @old_protocol = HasOffersV3.configuration.protocol
        HasOffersV3.configuration.protocol = 'https'
      end

      after(:each) do
        HasOffersV3.configuration.protocol = @old_protocol
      end

      it "makes a proper request" do
        stub_call :get
        response = subject.get_request 'test'
        expect(a_request(:get, url).with(query: hash_including('Method' => 'test'))).to have_been_made
        validate_call response
      end
    end
  end
end
