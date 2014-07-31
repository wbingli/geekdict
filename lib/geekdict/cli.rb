require "thor"

module GeekDict

	class CLI < Thor

	  desc "t", "Translate a word"
	  option :lang, :aliases=>'-l'
	  def t(word)
	    puts "Translating #{word} ..."
	    puts "Options : #{options[:lang]}"
	  end

	end
end
 