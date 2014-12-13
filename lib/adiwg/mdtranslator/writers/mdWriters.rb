# MdTranslator - controller for evaluating and directing writers

# History:
# 	Stan Smith 2014-12-11 original script

module ADIWG
	module Mdtranslator
		module Writers

			def self.handleWriter(intObj)
				case $response[:writerName]

					# ISO 19110 standard for feature catalogue used to describe tabular data dictionaries
					when 'iso19110'
						require 'adiwg/mdtranslator/writers/iso19110/iso19110_writer'
						writerClass = ADIWG::Mdtranslator::Writers::Iso19110::Iso19110Writer.new

						# initiate the writer
						$response[:writerOutput] = writerClass.writeXML(intObj)

					# ISO 19115-2:2009 standard for geospatial metadata
					when 'iso19115_2'
						require 'adiwg/mdtranslator/writers/iso19115_2/iso19115_2_writer'
						writerClass = ADIWG::Mdtranslator::Writers::Iso191152::Iso191152Writer.new

						# initiate the writer
						$response[:writerOutput] = writerClass.writeXML(intObj)

					# writer name not provided or not supported
					else
						$response[:writerValidationPass] = false
						$response[:readerValidationMessages] << "Writer name '#{$response[:writerName]}' is missing or not supported."
						return false

				end

			end

		end
	end
end

