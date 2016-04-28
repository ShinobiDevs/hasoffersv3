describe HasOffersV3::Conversion do
  let(:url)  { Regexp.new api_url('Conversion') }

  before :each do
    stub_call :get
  end

  describe '#find_all' do
    it 'makes a proper request call' do
      response = subject.find_all
      expect(a_request(:get, url).with(query: hash_including({'Method' => 'findAll'}))).to have_been_made
      validate_call response
    end
  end

  describe '#find_added_conversions' do
    it 'makes a proper request call' do
      response = subject.find_added_conversions
      expect(a_request(:get, url).with(query: hash_including({'Method' => 'findAddedConversions'}))).to have_been_made
      validate_call response
    end
  end

  describe '#find_updated_conversions' do
    it 'makes a proper request call' do
      response = subject.find_updated_conversions
      expect(a_request(:get, url).with(query: hash_including({'Method' => 'findUpdatedConversions'}))).to have_been_made
      validate_call response
    end
  end
end
