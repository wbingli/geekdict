require "thor"
require_relative 'local_history'
require_relative 'version'
require_relative 'openai/gpt.rb'
require_relative 'openrouter/api.rb'

module GeekDict

    class CLI < Thor

        desc "t", "Translate a word"
        option :debug, :aliases=>'-d', :type=>:boolean, :default=>false
        option :open, :aliases=>'-o', :type=>:boolean, :default=>false
        option :provider, :aliases=>'-p', :type=>:string, :default=>'openrouter', :enum=>['openai', 'openrouter', 'youdao'], :desc=>"Translation provider to use"
        def t(word)
            GeekDict.debugger options[:debug]
            LocalHistory.save word
            
            provider = options[:provider].downcase
            result = case provider
                     when 'openai'
                       GeekDict::OpenAI.translate(word)
                     when 'openrouter'
                       GeekDict::OpenRouter.translate(word)
                     when 'youdao'
                       GeekDict::Youdao.translate(word)
                     else
                       GeekDict::OpenRouter.translate(word)
                     end
            
            puts result
        end

        desc "v", "version"
        def v()
          puts GeekDict::VERSION
        end

    end
end
