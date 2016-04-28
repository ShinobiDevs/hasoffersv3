describe HasOffersV3::AffiliateOffer do
  let(:url)  { api_url 'Affiliate_Offer' }

  describe '#target' do
    specify { expect(subject.target).to eq('Affiliate_Offer')}
  end

  context 'urls' do
    specify { expect(url).to eq('https://api.hasoffers.com/v3/Affiliate_Offer.json') }
  end

  describe '#find_all' do
    it 'makes a proper request call' do
      stub_call
      response = subject.find_all
      request = a_request(:post, url).with(body: hash_including('Method' => 'findAll'))
      expect(request).to have_been_made
      validate_call response
    end
  end

  describe '#find_by_id' do
    it 'makes a proper request call' do
      stub_call
      response = subject.find_by_id id: 1
      request = a_request(:post, url).with(body: hash_including('Method' => 'findById', 'id' => '1'))
      expect(request).to have_been_made

      validate_call response
    end

    context 'when there is no id' do
      it 'raises exception' do
        expect { subject.find_by_id }.to raise_error ArgumentError
      end
    end
  end

  describe '#get_categories' do
    it 'makes a proper request call' do
      stub_call
      response = subject.get_categories ids: [1, 2]
      request = a_request(:post, url).with(body: hash_including('Method' => 'getCategories'))
      expect(request).to have_been_made

      validate_call response
    end

    context 'when there is no id' do
      it 'raises exception' do
        expect { subject.get_categories }.to raise_error ArgumentError
      end
    end
  end

  describe '#get_target_countries' do
    it 'makes a proper request call' do
      stub_call
      response = subject.get_target_countries ids: [1, 2]
      request = a_request(:post, url).with(body: hash_including('Method' => 'getTargetCountries'))
      expect(request).to have_been_made

      validate_call response
    end

    context 'when there is no id' do
      it 'raises exception' do
        expect { subject.get_target_countries }.to raise_error ArgumentError
      end
    end
  end

  describe '#generate_tracking_link' do
    it 'makes a proper request call' do
      stub_call
      response = subject.generate_tracking_link offer_id: 1
      request = a_request(:post, url).with(body: hash_including('Method' => 'generateTrackingLink'))
      expect(request).to have_been_made

      validate_call response
    end

    context 'when there is no offer_id' do
      it 'raises exception' do
        expect { subject.generate_tracking_link }.to raise_error ArgumentError
      end
    end
  end

  describe '#find_my_offers' do
    it 'makes a proper request call' do
      stub_call
      response = subject.find_my_offers
      request = a_request(:post, url).with(body: hash_including('Method' => 'findMyOffers'))
      expect(request).to have_been_made

      validate_call response
    end
  end

end
