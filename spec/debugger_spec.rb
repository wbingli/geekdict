require 'geekdict'

describe GeekDict::Debugger do

  describe 'Debug msg' do

    it 'should output debug message' do
        debugger  = GeekDict::Debugger.new true
        debugger.debug "Test bug"
       end
  end
end
