describe HasOffersV3::Configuration do
  describe '#http_logger' do
    it 'returns an instance of HasOffersV3::Logger' do
      expect(subject.http_logger).to be_instance_of(HasOffersV3::Logger)
    end

    context 'when logger is default' do
      it 'uses null HTTP logger' do
        expect(subject.http_logger.log).to be_nil
      end
    end

    context 'when logger is supplied' do
      let(:logger) { double('logger') }
      subject { described_class.new(logger: logger) }

      it 'uses supplied logger' do
        expect(subject.http_logger.log).to eq logger
      end
    end
  end

  describe '#base_uri' do
    context 'when configuration is default' do
      it 'builds default base URI' do
        expect(subject.base_uri).to eq 'https://api.hasoffers.com/v3'
      end
    end

    context 'when configuration is customized' do
      subject do
        described_class.new(
          host: 'api2.hasoffers.com',
          protocol: 'http',
          base_path: '/v4'
        )
      end

      it 'builds base URI according options' do
        expect(subject.base_uri).to eq 'http://api2.hasoffers.com/v4'
      end
    end
  end
end
