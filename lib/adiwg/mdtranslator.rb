# MdTranslator - ADIwg MdTranslator RubyGem entry point
# ... pass input file to appropriate reader and writer;
# ... assign module path names for require statements

# History:
# 	Stan Smith 2014-07-02 original script
#   Stan Smith 2014-07-21 added ADIWG namespace
#   Stan Smith 2014-07-21 added validation of json structure
#   Stan Smith 2014-07-23 moved all validations to readers/adiwg/adiwg_validator.rb
#   ... each reader will have it's own validator

# add main directories to load_path
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/internal'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/readers'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/writers'))

require 'mdtranslator/version'
require 'internal_metadata_obj'

module ADIWG

	module Mdtranslator

		def self.translate(file, reader='adiwg', writer='iso19115_2', showEmpty=true, valLevel='none')

			@reader = reader
			@writer = writer

			case @reader
				when 'adiwg'
					require 'adiwg/adiwg_validator'

					# validate adiwg json file
					success, retMessage = Adiwg1JsonValidation.validate(file, valLevel)
					if !success
						err = "ADIwg JSON did not validate... see message below for more information: \n"
						return err + retMessage
					end

					# initiate the reader
					require 'adiwg/adiwg_reader'
					readerClass = Adiwg1Reader.new
					internalObj = readerClass.unpack(file)

			end

			case @writer
				when 'iso19115_2'

					$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/writers/iso_19115_2/codelists'))
					$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/writers/iso_19115_2/classes'))

					require 'iso_19115_2/iso_19115_2_writer'

					$showEmpty = showEmpty

					writerClass = Iso191152Writer.new

					# initiate the writer
					metadata = writerClass.writeXML(internalObj)
			end

			return metadata

		end

		def self.reader_module(moduleName, version)
			dir = File.join(@reader, 'modules_' + version)
			file = File.join(dir, moduleName)
			return file
		end

	end

end

