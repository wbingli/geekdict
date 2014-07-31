require "thor"

module GeekDict

	class CLI < Thor

	  desc "t", "Translate a word"
	  option :lang, :aliases=>'-l'
	  def t(word)
	    result = GeekDict::Youdao.translate word
	    output = result.join "\n"
	    puts output
	    output
	  end

	end
end
 