describe GeekDict::OpenRouter do
  describe '.translate' do
    it 'disables cookies before posting to OpenRouter' do
      client = instance_double(HTTPClient)
      response = double(
        'response',
        status: 200,
        body: { choices: [{ message: { content: 'Theory' } }] }.to_json
      )
      original_api_key = ENV['OPENROUTER_API_KEY']
      ENV['OPENROUTER_API_KEY'] = 'test-api-key'

      allow(HTTPClient).to receive(:new).and_return(client)
      expect(client).to receive(:cookie_manager=).with(nil).ordered
      expect(client).to receive(:post).ordered.and_return(response)

      expect(described_class.translate('理论')).to eq('Theory')
    ensure
      ENV['OPENROUTER_API_KEY'] = original_api_key
    end
  end
end
