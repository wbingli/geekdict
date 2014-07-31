require 'geekdict'

describe GeekDict::Youdao do
  
  describe 'translate good' do
    
    it 'should output translate result as json' do
    	result  = GeekDict::Youdao.translate 'good'
    	expect(result.length).to be > 0  
   	end
  end
end