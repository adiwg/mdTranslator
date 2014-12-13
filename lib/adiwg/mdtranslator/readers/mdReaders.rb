# MdTranslator - controller for evaluating and directing readers

# History:
# 	Stan Smith 2014-12-11 original script

module ADIWG
	module Mdtranslator
		module Readers

			def self.handleReader(file)
				case $response[:readerRequested]
					# ADIwg mdJson JSON schema
					when 'mdJson'

						require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
						intObj = ADIWG::Mdtranslator::Readers::MdJson.inspectFile(file)
						return intObj

					# reader name not provided or not supported
					else
						$response[:readerValidationPass] = false
						$response[:readerValidationMessages] << 'Reader name is missing or not supported.'
						return false
				end
			end

		end
	end
end

