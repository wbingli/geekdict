describe GeekDict::Youdao do
  describe '.translate' do
    let(:client) { instance_double(HTTPClient) }

    before { allow(HTTPClient).to receive(:new).and_return(client) }

    def response(body)
      double('response', status_code: 200, content_type: 'application/json', body: body.to_json)
    end

    it 'returns the basic explanations' do
      allow(client).to receive(:get).and_return(response(errorCode: 0, basic: { explains: ['adj. 好的'] }))

      expect(described_class.translate('good')).to eq(['adj. 好的'])
    end

    it 'returns an empty list when the API reports an error' do
      allow(client).to receive(:get).and_return(response(errorCode: 50))

      expect(described_class.translate('good')).to eq([])
    end
  end
end
