require 'httpclient'
require 'json'

require 'geekdict/youdao/config'

module GeekDict
	module Youdao

		#Youdao API version

		module_function

		def translate(word)
			client = HTTPClient.new
			query = { keyfrom: APIKEYFROM, key: APIKEY, type: 'data', doctype: 'json',version: APIVERSION, q: word }
			res = client.get(APIURL, query)
			res = JSON.parse res.body
			error_code = res['errorCode']
			if error_code == 0
				res['basic']['explains']
			else
				[]
			end
		end
	end
end