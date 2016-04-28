describe HasOffersV3::RawLog do
  let(:url)  { Regexp.new api_url('RawLog') }

  before :each do
    stub_call :get
  end

  describe '#get_download_link' do
    it 'makes a proper request call' do
      response = subject.get_download_link log_type: 'clicks', log_filename: 'xxx'
      expect(a_request(:get, url).with(query: hash_including({'Method' => 'getDownloadLink'}))).to have_been_made
      validate_call response
    end

    context 'when there is no log_type' do
      it 'raises an exception' do
        expect { subject.get_download_link log_filename: 'xxx' }.to raise_error ArgumentError
      end
    end

    context 'when there is no log_filename' do
      it 'raises an exception' do
        expect { subject.get_download_link log_type: 'clicks' }.to raise_error ArgumentError
      end
    end
  end

  describe '#get_log_expirations' do
    it 'makes a proper request call' do
      response = subject.get_log_expirations
      expect(a_request(:get, url).with(query: hash_including({'Method' => 'getLogExpirations'}))).to have_been_made
      validate_call response
    end
  end

  describe '#list_date_dirs' do
    it 'makes a proper request call' do
      response = subject.list_date_dirs log_type: 'clicks'
      expect(a_request(:get, url).with(query: hash_including({'Method' => 'listDateDirs'}))).to have_been_made
      validate_call response
    end

    context 'when there is no log_type' do
      it 'raises an exception' do
        expect { subject.list_date_dirs }.to raise_error ArgumentError
      end
    end
  end

  describe '#list_logs' do
    it 'makes a proper request call' do
      response = subject.list_logs log_type: 'clicks', date_dir: '20140101'
      expect(a_request(:get, url).with(query: hash_including({'Method' => 'listLogs'}))).to have_been_made
      validate_call response
    end

    context 'when there is no log_type' do
      it 'raises an exception' do
        expect { subject.list_logs date_dir: '20140101' }.to raise_error ArgumentError
      end
    end

    context 'when there is no date_dir' do
      it 'raises an exception' do
        expect { subject.list_logs log_type: 'clicks' }.to raise_error ArgumentError
      end
    end
  end
end
