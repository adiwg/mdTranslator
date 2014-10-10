# MdTranslator - ADIwg MdTranslator RubyGem entry point
# ... pass input file to appropriate reader and writer;
# ... assign module path names for require statements

# History:
# 	Stan Smith 2014-07-02 original script
#   Stan Smith 2014-07-21 added ADIWG namespace
#   Stan Smith 2014-07-21 added validation of json structure
#   Stan Smith 2014-07-23 moved all validations to readers/adiwg/adiwg_validator.rb
#   ... each reader will have it's own validator
#   Stan Smith 2014-09-26 added processing of minor release numbers
#   Stan Smith 2014-10-10 added method to return path to readers and writers

# add main directories to load_path
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/internal'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/readers'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/writers'))

require 'version'
require 'internal_metadata_obj'

module ADIWG

	module Mdtranslator

		def self.translate(file, reader, writer, validate, showAllTags)

			$showAllTags = showAllTags
			$response = {
				readerFormat: nil,
				readerStructurePass: nil,
				readerStructureMessages: [],
				readerName: reader,
				readerNameFound: nil,
				readerVersionFound: nil,
				readerVersionUsed: nil,
				readerValidationLevel: validate,
				readerValidationPass: nil,
				readerValidationMessages: [],
				writerName: writer,
				writerFormat: nil,
				writerPass: nil,
				writerMessages: [],
				writerOutput: nil
			}

			# the mdtranslator gem loads and returns the above hash

			case reader
				when 'adiwgJson'
					require 'adiwgJson/adiwgJson_validator'

					# validate adiwgJson file
					AdiwgJsonValidation.validate(file)
					if $response[:readerStructurePass] && $response[:readerValidationPass]
						# initiate the reader
						require 'adiwgJson/adiwgJson_reader'
						readerClass = AdiwgJsonReader.new
						internalObj = readerClass.unpack(file)
					else
						return $response
					end
			end

			case writer
				when 'iso19115_2'
					$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/writers/iso19115_2/codelists'))
					$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/writers/iso19115_2/classes'))
					require 'iso19115_2/iso19115_2_writer'

					# set the format of the output file based on the writer specified
					$response[:writerFormat] = 'xml'

					writerClass = Iso191152Writer.new

					# initiate the writer
					$response[:writerOutput] = writerClass.writeXML(internalObj)
					if $response[:writerMessages].length > 0
						$response[:writerPass] = false
					else
						$response[:writerPass] = true
					end
			end

			return $response

		end

		def self.reader_module(moduleName, version)
			dir = File.join($response[:readerName], 'modules_' + version)
			file = File.join(dir, moduleName)
			return file
		end

		# return path to readers and writers
		def self.path_to_resources
			File.join(File.dirname(File.expand_path(__FILE__)),'mdtranslator')
		end

	end

end
