describe GeekDict::CLI do
  describe '#t' do
    before do
      # Keep specs off the real ~/.geekdict history and ~/.geekdict.config files.
      allow(LocalHistory).to receive(:save)
      allow(GeekDict::Config).to receive(:load_config).and_return(provider: nil, model: nil)
    end

    it 'prints the translation from the provider and model given as options' do
      expect(GeekDict::OpenRouter).to receive(:translate).with('good', model: 'test-model').and_return('好')

      expect { GeekDict::CLI.start(%w[t good -p openrouter -m test-model]) }.to output("好\n").to_stdout
    end

    it 'falls back to the provider and model from the config file' do
      allow(GeekDict::Config).to receive(:load_config).and_return(provider: 'openai', model: 'gpt-test')
      expect(GeekDict::OpenAI).to receive(:translate).with('good', model: 'gpt-test').and_return('好')

      expect { GeekDict::CLI.start(%w[t good]) }.to output("好\n").to_stdout
    end
  end
end
