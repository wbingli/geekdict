require 'json'
require 'httpclient'

module GeekDict
  module Gemini
    module_function

    API_BASE = 'https://generativelanguage.googleapis.com/v1beta/models'

    # Calls the Gemini API (Google AI Studio) directly. Requires GEMINI_API_KEY.
    def translate(word, model: nil)
      @debugger = GeekDict.debugger

      # Accept OpenRouter-style IDs (google/gemini-...) so the same config works for both providers.
      effective_model = (model || 'gemini-3.5-flash-lite').delete_prefix('google/')

      client = HTTPClient.new
      client.cookie_manager = nil
      headers = {
        'Content-Type' => 'application/json',
        'x-goog-api-key' => ENV.fetch('GEMINI_API_KEY')
      }

      # Temperature is left at the model default: Google recommends 1.0 for Gemini 3+ models.
      # Flash-Lite already defaults to minimal thinking, so no thinkingConfig is needed.
      body = {
        systemInstruction: { parts: [{ text: system_prompt(word) }] },
        contents: [{ role: 'user', parts: [{ text: word }] }]
      }

      response = client.post(
        "#{API_BASE}/#{effective_model}:generateContent",
        body.to_json,
        headers
      )

      result = JSON.parse(response.body) rescue {}
      if response.status == 200
        parts = result.dig('candidates', 0, 'content', 'parts') || []
        parts.reject { |part| part['thought'] }.map { |part| part['text'] }.join
      else
        message = result.dig('error', 'message')
        "Error: Failed to get translation (#{response.status})#{": #{message}" if message}"
      end
    end

    def system_prompt(word)
      <<-EOS
      You are a precise language translator specializing in English-Chinese translation. Follow these guidelines:

      1. If the input is Chinese, translate to English. If English, translate to Chinese.
      2. For words with multiple meanings, prioritize the most common usage first.
      3. For misspelled or incorrect words, suggest the closest correct word.
      4. For idiomatic expressions, provide both literal and figurative translations.
      5. For technical terms, include the field/domain where appropriate.

      Format your response as follows:
      - Translation: [primary translation]
      - Explanation: [concise explanation of meaning and usage]
      - Examples:
        1. [example sentence in target language]
           [translation in source language]
        2. [second example if helpful]
           [translation in source language]

      Keep explanations clear and concise. Do NOT include pinyin in Chinese text.
      EOS
    end
  end
end
