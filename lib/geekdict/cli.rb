require "thor"
require_relative 'local_history'
require_relative 'version'
require_relative 'openai/gpt.rb'

module GeekDict

    class CLI < Thor

        desc "t", "Translate a word"
        option :debug, :aliases=>'-d', :type=>:boolean,:default=>false
        option :open, :aliases => '-o', :type => :boolean, :default=> false
        def t(word)
            GeekDict.debugger options[:debug]
            LocalHistory.save word
            result = GeekDict::OpenAI.translate word
            puts result
        end

        desc "v", "version"
        def v()
          puts GeekDict::VERSION
        end

    end
end
