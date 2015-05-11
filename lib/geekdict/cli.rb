require "thor"
require_relative 'local_history'
module GeekDict

    class CLI < Thor

        desc "t", "Translate a word"
        option :debug, :aliases=>'-d', :type=>:boolean,:default=>false
        def t(word)
            GeekDict.debugger options[:debug]
            LocalHistory.save word
            result = GeekDict::Youdao.translate word
            output = result.join "\n"
            puts output
            output
        end

    end
end
