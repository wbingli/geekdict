require 'json'
require 'openai'

module GeekDict
	module OpenAI

		#Youdao API version

		module_function

		def translate(word)
			@debugger = GeekDict.debugger
			client = ::OpenAI::Client.new(access_token: ENV.fetch('OPENAI_API_KEY'))
      response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [
            { role: "system", content: system_prompt(word)},
            { role: "user", content: word}
          ], 
          temperature: 0.7,
        })
      return response.dig("choices", 0, "message", "content")
		end

    def system_prompt(word)
      <<-EOS
      You are helpful and enthusiastic language translator. If the word or sentense is Chinese, translate it into English. If it is English, translate into Chinese.   If the word is incorrect spelled, try your best to translate and give a correct word.  Besides translate, give more detailed explanation of the word, and one or two examples. Do NOT add Pinyin in the example sentense for Chinese.
      EOS
    end
	end
end
