require 'logger'

module GeekDict
  class Debugger

    def initialize(enable=false)
      @enable = enable
      @logger    = new_logger if enable
    end

    def debug(msg)
       @logger.debug msg if @enable
    end


    private

    def new_logger()
      Logger.new(STDOUT).tap do |l|
        l.datetime_format = '%Y-%m-%dT%H:%M:%S%z'
        l.formatter = proc do |severity, datetime, progname, msg|
          "#{datetime} : #{msg}\n"
        end
      end
    end

  end
end
