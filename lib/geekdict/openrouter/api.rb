require 'json'
require 'httpclient'

module GeekDict
  module OpenRouter
    module_function

    # Update translate method to accept model
    def translate(word, model: nil) # Add model keyword argument
      @debugger = GeekDict.debugger
      
      # Use the provided model, or fallback to a default if nil (though CLI should provide one)
      effective_model = model || 'google/gemini-2.5-flash-preview' # Fallback, though CLI provides default

      client = HTTPClient.new
      headers = {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{ENV.fetch('OPENROUTER_API_KEY')}",
        'HTTP-Referer' => 'https://github.com/wbingli/geekdict/', # Identify app
        'X-Title' => 'GeekDict' # Set app title
      }
      
      body = {
        model: effective_model, # Use the determined model
        messages: [
          { role: "system", content: system_prompt(word) },
          { role: "user", content: word }
        ],
        temperature: 0.2
      }
      
      response = client.post(
        'https://openrouter.ai/api/v1/chat/completions',
        body.to_json,
        headers
      )
      
      if response.status == 200
        result = JSON.parse(response.body)
        result.dig("choices", 0, "message", "content")
      else
        "Error: Failed to get translation (#{response.status})"
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
