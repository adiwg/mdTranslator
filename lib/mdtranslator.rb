# MdTranslator - ADIwg MdTranslator RubyGem entry point
# ... pass input file to appropriate reader and writer;
# ... assign module path names for require statements

# History:
# 	Stan Smith 2014-07-02 original script

# add main directories to load_path
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/internal'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/readers'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/writers'))

require 'mdtranslator/version'
require 'internal_metadata_obj'

module Mdtranslator

	def self.translate(file, reader='adiwg_1', writer='iso19115_2')

		@reader = reader
		@writer = writer

		case @reader
			when 'adiwg_1'
				require 'json'
				require 'adiwg_1/adiwg_1_validator'

				# validate json file
				# ... tbd

				# set $jsonVersion
				Adiwg1JsonValidation.getVersion(file)

				# initiate the reader
				require 'adiwg_1/adiwg_1_reader'
				readerClass = Adiwg1Reader.new
				internalObj = readerClass.unpack(file)

		end

		case @writer
			when 'iso19115_2'
				$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/writers/iso_19115_2/codelists'))
				$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/writers/iso_19115_2/classes'))

				require 'builder'
				require 'date'
				require 'uuidtools'
				require 'iso_19115_2/iso_19115_2_writer'

				$showEmpty = true

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

