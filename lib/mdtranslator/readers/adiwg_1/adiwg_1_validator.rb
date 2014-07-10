# Get minor version of ADIwg JSON V1

# History:
# 	Stan Smith 2014-07-09 original script

module Adiwg1JsonValidation

	def self.getVersion(jsonObj)

		$jsonVersion = 'unknown'

		# convert the received JSON to a Ruby hash
		hashObj = JSON.parse(jsonObj)

		# jsonVersion
		# get json schema name and version
		if hashObj.has_key?('version')
			hVersion = hashObj['version']
			if hVersion.has_key?('version')
				s = hVersion['version']
				$jsonVersion = s
			end
		end

	end

end