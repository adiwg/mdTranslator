# Get minor version of ADIwg JSON V1

# History:
# 	Stan Smith 2014-07-09 original script
#   Stan Smith 2014-07-21 added json structure validation method
#   Stan Smith 2014-08-21 parsed json-schema validation message to readable text

require 'json'
require 'json-schema'
require 'adiwg-json_schemas'

$jsonVersionName = ''
$jsonVersionNum = ''

module Adiwg1JsonValidation

	def self.validate(file, valLevel)

		# validate json structure
		begin
			hashObj = JSON.parse(file)
		rescue JSON::JSONError => err
			parseErr = "JSON structure error... \nMessage received from parser: \n"
			parseErr = parseErr + err.to_s.slice(0,500)
			return false, parseErr
		end

		# set json name and version
		# get json schema name and version
		if hashObj.has_key?('version')
			hVersion = hashObj['version']
		else
			versionErr = "JSON schema error... \nJSON file is missing the version:{} block"
			return false, versionErr
		end

		# get the version name
		if hVersion.has_key?('name')
			s = hVersion['name']
			if !s.nil?
				$jsonVersionName = s
				if s != 'adiwgJSON'
					versionErr = "JSON schema error... \nJSON version name is '#{s}'\n"
					versionErr = versionErr + "JSON schema must be 'adiwgJSON' to use this reader"
					return false, versionErr
				end
			end
		else
			versionErr = "JSON schema error... \nJSON version:{} block is missing the name attribute"
			return false, versionErr
		end

		# get version number
		if hVersion.has_key?('version')
			s = hVersion['version']
			if !s.nil?
				$jsonVersionNum = s
			end
		else
			versionErr = "JSON schema error... \nJSON version:{} block is missing the version attribute"
			return false, versionErr
		end

		# validate json schema
		begin
			schema = ADIWG::JsonSchemas::Utils.schema_path
			aValErrs = []
			validationErr = ''
			errNum = 0
			if valLevel == 'strict'
				aValErrs = JSON::Validator.fully_validate(schema, file, :strict => true, :errors_as_objects => true)
			elsif valLevel == 'json'
				aValErrs = JSON::Validator.fully_validate(schema, file, :errors_as_objects => true)
			end

			if aValErrs.length > 0
				aValErrs.each do |valError|
					errNum += 1
					validationErr += "\nError: #{errNum}\n"
					validationErr += "JSON Path: #{valError[:fragment]}\n"
					validationErr += "Message: #{valError[:message]}\n"
				end
				return false, validationErr
			end

		rescue JSON::Schema::ValidationError
			return false, $!.message
		end

		return true, 'Passed all JSON validation tests'

	end

end