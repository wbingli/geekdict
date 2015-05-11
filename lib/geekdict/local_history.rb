module LocalHistory
    module_function

    def save(word)
        open("#{Dir.home}/.geekdict", 'a') { |f|
            f.puts "#{Time.now.utc.iso8601} #{word}"
        }
    end
end
