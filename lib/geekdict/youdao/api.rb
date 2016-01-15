require 'httpclient'
require 'json'

require 'geekdict/youdao/config'

module GeekDict
	module Youdao

		#Youdao API version

		module_function

    def url(word)
      "http://dict.youdao.com/search?q=#{word}"
    end

		def translate(word)
			@debugger = GeekDict.debugger
			client = HTTPClient.new
			query = { keyfrom: APIKEYFROM, key: APIKEY, type: 'data', doctype: 'json',version: APIVERSION, q: word }
			res = client.get(APIURL, query)
			@debugger.debug "Response status: #{res.status_code}"
			@debugger.debug "Response Content-Type: #{res.content_type}"
			@debugger.debug "Response Body:  #{res.body}"
			res = JSON.parse res.body
			error_code = res['errorCode']
			if error_code == 0 && res['basic'] && res['basic']['explains']
				res['basic']['explains']
			else
				[]
			end
		end
	end
end
