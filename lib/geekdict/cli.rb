require "thor"
require_relative 'local_history'
require_relative 'version'

module GeekDict

    class CLI < Thor

        desc "t", "Translate a word"
        option :debug, :aliases=>'-d', :type=>:boolean,:default=>false
        option :open, :aliases => '-o', :type => :boolean, :default=> false
        def t(word)
            GeekDict.debugger options[:debug]
            LocalHistory.save word
            if options[:open]
              page = GeekDict::Youdao.url word
              puts "Open Web page : #{page}"
              `open #{page}`
            else
              result = GeekDict::Youdao.translate word
              output = result.join "\n"
              puts output
              output
            end
        end

        desc "v", "version"
        def v()
          puts GeekDict::VERSION
        end

    end
end
