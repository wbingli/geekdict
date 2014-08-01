require 'geekdict/cli'
require 'geekdict/debugger'
require 'geekdict/youdao/api'

module GeekDict

  module_function

  def debugger(enable=false)
    @debugger ||= GeekDict::Debugger.new enable
  end

end
