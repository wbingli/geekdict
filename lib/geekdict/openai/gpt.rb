require 'json'
require 'openai'

module GeekDict
	module OpenAI

		#Youdao API version

		module_function

    # Update translate method to accept model
		def translate(word, model: nil) # Add model keyword argument
			@debugger = GeekDict.debugger
      # Use the provided model, or fallback to a default if nil
      effective_model = model || "gpt-3.5-turbo" # Fallback model for OpenAI

			client = ::OpenAI::Client.new(access_token: ENV.fetch('OPENAI_API_KEY'))
      response = client.chat(
        parameters: {
          model: effective_model, # Use the determined model
          messages: [
            { role: "system", content: system_prompt(word)},
            { role: "user", content: word}
          ], 
          temperature: 0.2,
        })
      return response.dig("choices", 0, "message", "content")
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
