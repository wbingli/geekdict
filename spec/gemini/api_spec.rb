require 'geekdict'

describe GeekDict::Gemini do
  describe '.translate' do
    let(:client) { instance_double(HTTPClient, :cookie_manager= => nil) }

    around do |example|
      original_api_key = ENV['GEMINI_API_KEY']
      ENV['GEMINI_API_KEY'] = 'test-api-key'
      example.run
    ensure
      ENV['GEMINI_API_KEY'] = original_api_key
    end

    before { allow(HTTPClient).to receive(:new).and_return(client) }

    it 'posts to the model generateContent endpoint and returns non-thought text' do
      response = double(
        'response',
        status: 200,
        body: { candidates: [{ content: { parts: [
          { text: 'thinking...', thought: true },
          { text: 'Theory' }
        ] } }] }.to_json
      )

      expect(client).to receive(:cookie_manager=).with(nil)
      expect(client).to receive(:post) do |url, body, headers|
        expect(url).to eq('https://generativelanguage.googleapis.com/v1beta/models/gemini-3.5-flash-lite:generateContent')
        expect(headers['x-goog-api-key']).to eq('test-api-key')
        payload = JSON.parse(body)
        expect(payload.dig('contents', 0, 'parts', 0, 'text')).to eq('理论')
        expect(payload.dig('systemInstruction', 'parts', 0, 'text')).to include('translator')
        response
      end

      expect(described_class.translate('理论', model: 'gemini-3.5-flash-lite')).to eq('Theory')
    end

    it 'accepts OpenRouter-style google/ model IDs' do
      response = double('response', status: 200, body: { candidates: [{ content: { parts: [{ text: 'ok' }] } }] }.to_json)
      expect(client).to receive(:post).with(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-3.5-flash-lite:generateContent', anything, anything
      ).and_return(response)

      expect(described_class.translate('good', model: 'google/gemini-3.5-flash-lite')).to eq('ok')
    end

    it 'includes the API error message on failure' do
      response = double(
        'response',
        status: 429,
        body: { error: { code: 429, message: 'Quota exceeded' } }.to_json
      )
      allow(client).to receive(:post).and_return(response)

      expect(described_class.translate('good')).to eq('Error: Failed to get translation (429): Quota exceeded')
    end
  end
end
