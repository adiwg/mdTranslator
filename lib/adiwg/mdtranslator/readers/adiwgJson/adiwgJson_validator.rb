# Get minor version of ADIwg JSON V1

# History:
# 	Stan Smith 2014-07-09 original script
#   Stan Smith 2014-07-21 added json structure validation method
#   Stan Smith 2014-08-21 parsed json-schema validation message to readable text
#   Stan Smith 2014-09-26 added processing of minor release numbers

require 'json'
require 'json-schema'
require 'adiwg-json_schemas'
#json-schema patch
require 'validator.rb'

module AdiwgJsonValidation

	def self.validate(file)

		# set the anticipated format of the input file based on the reader specified
		$response[:readerFormat] = 'json'

		# validate the input file structure
		# test for valid json syntax by attempting to parse the file
		begin
			hashObj = JSON.parse(file)
			$response[:readerStructurePass] = true
		rescue JSON::JSONError => err
			$response[:readerStructurePass] = false
			$response[:readerStructureMessages] << err
			return
		end

		# find name and version of input json file
		if hashObj.has_key?('version')
			hVersion = hashObj['version']
		else
			$response[:readerStructurePass] = false
			$response[:readerStructureMessages] << 'input file is missing the version:{} block'
			return
		end

		# get the version name
		if hVersion.has_key?('name')
			s = hVersion['name']
			if !s.nil?
				$response[:readerNameFound] = s
				if s != 'adiwgJson'
					$response[:readerStructurePass] = false
					$response[:readerStructureMessages] << "input file version name must be 'adiwgJson'"
					$response[:readerStructureMessages] << "found version name '#{s}'"
					return
				end
			end
		else
			$response[:readerStructurePass] = false
			$response[:readerStructureMessages] << "input file version:{} block is missing the 'name' attribute"
			return
		end

		# get version number
		if hVersion.has_key?('version')
			requestReaderVersion = hVersion['version']
			$response[:readerVersionFound] = requestReaderVersion
			# test if reader version is supported
			# remove minor release number
			# ...and look for a module folder name ending with the requested version
			# ...example: 'modules_1.2.0'
			if !requestReaderVersion.nil?
				aVersionParts = requestReaderVersion.split('.')
				readerVersion = aVersionParts[0] +'.' + aVersionParts[1] + '.0'
				dir = File.join(File.dirname(__FILE__),'modules_' + readerVersion)
				if !File.directory?(dir)
					$response[:readerStructurePass] = false
					$response[:readerStructureMessages] << 'input file version is not supported'
					$response[:readerStructureMessages] << "adiwgJson version requested was '#{requestReaderVersion}'"
					return
				end
				$response[:readerVersionUsed] = readerVersion
			end
		else
			$response[:readerStructurePass] = false
			$response[:readerStructureMessages] << "input file version:{} block is missing the 'version' attribute"
			return
		end

		# validate json against the adiwg-json_schemas
		# only one schema version is supported at this time
		begin

			schema = ADIWG::JsonSchemas::Utils.schema_path
			aValErrs = Array.new
			if $response[:readerValidationLevel] == 'strict'
				aValErrs = JSON::Validator.fully_validate(schema, file, :strict => true, :errors_as_objects => true)
			elsif $response[:readerValidationLevel] == 'normal'
				aValErrs = JSON::Validator.fully_validate(schema, file, :errors_as_objects => true)
			end

			if aValErrs.length > 0
				$response[:readerValidationPass] = false
				$response[:readerValidationMessages] = aValErrs
				return
			end

		rescue JSON::Schema::ValidationError
			$response[:readerValidationPass] = false
			$response[:readerValidationMessages] << $!.message
			return
		end

		$response[:readerValidationPass] = true
		return

	end

end