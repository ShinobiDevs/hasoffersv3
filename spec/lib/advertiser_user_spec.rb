describe HasOffersV3::AdvertiserUser do
  let(:url)  { api_url 'AdvertiserUser' }

  describe '#find_all' do
    it 'makes a proper request call' do
      stub_call
      response = subject.find_all
      expect(a_request(:post, url).with(body: hash_including({'Method' => 'findAll'}))).to have_been_made
      validate_call response
    end
  end
end
