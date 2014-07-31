require 'geekdict'

describe GeekDict::CLI do
  
  describe 'translate good' do
    
    it 'should output translate result as string' do
    	cli  = GeekDict::CLI.new
    	result = cli.t 'good'
    	expect(result).to include("好")
   	end
  end
end