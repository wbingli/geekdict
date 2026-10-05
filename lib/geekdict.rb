require 'geekdict/cli'
require 'geekdict/debugger'
require 'geekdict/youdao/api'
require 'geekdict/openai/gpt'
require 'geekdict/openrouter/api'
require 'geekdict/gemini/api'

module GeekDict

  module_function

  def debugger(enable=false)
    @debugger ||= GeekDict::Debugger.new enable
  end

end
