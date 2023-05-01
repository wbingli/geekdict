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
          temperature: 0.2,
        })
      return response.dig("choices", 0, "message", "content")
		end

    def system_prompt(word)
      <<-EOS
      You are helpful and enthusiastic language translator. If the word or sentense is Chinese, translate it into English. If it is English, translate into Chinese. If the word is incorrectly spelled or it's not a correct word in English or Chinese, try your best to find the closest word. In addition to the translation, offer a comprehensive explanation of the word along with one or two examples to illustrate its usage. Do NOT add Pinyin in the example sentences for Chinese.
      EOS
    end
	end
end
