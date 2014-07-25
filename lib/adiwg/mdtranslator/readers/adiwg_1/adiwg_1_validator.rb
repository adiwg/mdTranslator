# Get minor version of ADIwg JSON V1

# History:
# 	Stan Smith 2014-07-09 original script
#   Stan Smith 2014-07-21 added json structure validation method

require 'json'
require 'json-schema'
require 'adiwg-json_schemas'

module Adiwg1JsonValidation

	def self.validate(file, valLevel)

		# validate json structure
		begin
			hashObj = JSON.parse(file)
		rescue JSON::JSONError => err
			errMessage = "JSON structure error... \nMessage received from parser: \n"
			errMessage = errMessage + err.to_s.slice(0,500)
			return false, errMessage
		end

		# validate json version
		$jsonVersionName = ''
		$jsonVersionNum = ''

		# get json schema name and version
		if hashObj.has_key?('version')
			hVersion = hashObj['version']
		else
			errMessage = "JSON schema error... \nJSON file is missing the version:{} block"
			return false, errMessage
		end

		# get the version name
		if hVersion.has_key?('name')
			s = hVersion['name']
			if !s.nil?
				$jsonVersionName = s
				if s != 'adiwgJSON'
					errMessage = "JSON schema error... \nJSON version name is '#{s}'\n"
					errMessage = errMessage + "JSON schema must be 'adiwgJSON' for this reader"
					return false, errMessage
				end
			end
		else
			errMessage = "JSON schema error... \nJSON version:{} block is missing the name attribute"
			return false, errMessage
		end

		# get version number
		if hVersion.has_key?('version')
			s = hVersion['version']
			if !s.nil?
				$jsonVersionNum = s
			end
		else
			errMessage = "JSON schema error... \nJSON version:{} block is missing the version attribute"
			return false, errMessage
		end

		# validate json schema
		begin
			schema = ADIWG::JsonSchemas::Utils.schema_path
			if valLevel == 'strict'
				errors = JSON::Validator.fully_validate(schema, file, :strict => true)
			else
				errors = JSON::Validator.fully_validate(schema, file)
			end
			if errors
				return false, errors.to_s
			end
		rescue JSON::Schema::ValidationError
			return false, $!.message
		end

		return true, 'Passed all JSON validation tests'

	end

end