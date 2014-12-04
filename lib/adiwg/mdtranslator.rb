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
#   Stan Smith 2014-10-11 added methods to return content of readme files
#   Stan Smith 2014-12-01 changed adiwgJson ot mdJson
#   Stan Smith 2014-12-01 added writer iso19110 (feature catalogue)
#   Stan Smith 2014-12-01 added translator version to $response
#   Stan Smith 2014-12-02 organized shared class/code/units folders for 19115-2, 19110

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

			# load and return this hash
			$response = {
				readerFormat: nil,
				readerStructurePass: nil,
				readerStructureMessages: [],
				readerRequested: reader,
				readerFound: nil,
				readerVersionFound: nil,
				readerVersionUsed: nil,
				readerValidationLevel: validate,
				readerValidationPass: nil,
				readerValidationMessages: [],
				writerName: writer,
				writerVersion: ADIWG::Mdtranslator::VERSION,
				writerFormat: nil,
				writerPass: nil,
				writerMessages: [],
				writerOutput: nil
			}

			case reader

				# ADIwg mdJson JSON schema
				when 'mdJson'
					require 'mdJson/mdJson_validator'

					# validate adiwgJson file
					MdJsonValidation.validate(file)
					if $response[:readerStructurePass] && $response[:readerValidationPass]
						# initiate the reader
						require 'mdJson/mdJson_reader'
						readerClass = MdJsonReader.new
						internalObj = readerClass.unpack(file)
					else
						return $response
					end

				# reader name not provided or not supported
				else
					$response[:readerValidationPass] = false
					$response[:readerValidationMessages] << 'Reader name is missing or not supported.'
					return $response

			end

			case writer

				# ISO 19110 standard for feature catalogue used to describe tabular data dictionaries
				when 'iso19110'
					$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/writers/iso/codelists'))
					$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/writers/iso/classes'))
					$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/writers/iso/units'))
					require 'iso19110/iso19110_writer'

					# set the format of the output file based on the writer specified
					$response[:writerFormat] = 'xml'

					writerClass = Iso19110Writer.new

					# initiate the writer
					$response[:writerOutput] = writerClass.writeXML(internalObj)
					if $response[:writerMessages].length > 0
						$response[:writerPass] = false
					else
						$response[:writerPass] = true
					end

				# ISO 19115-2:2009 standard for geospatial metadata
				when 'iso19115_2'
					$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/writers/iso/codelists'))
					$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'mdtranslator/writers/iso/classes'))
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

				# writer name is missing or not supported
				else
					$response[:writerPass] = false
					$response[:writerMessages] << 'Writer name is missing or not supported.'

			end

			return $response

		end

		def self.reader_module(moduleName, version)
			dir = File.join($response[:readerFound], 'modules_' + version)
			file = File.join(dir, moduleName)
			return file
		end

		# return path to readers and writers
		def self.path_to_resources
			File.join(File.dirname(File.expand_path(__FILE__)),'mdtranslator')
		end

		# return reader readme text
		def self.get_reader_readme(reader)
			readmeText = 'No text found'
			path = File.join(path_to_resources, 'readers', reader, 'readme.md')
			if File.exist?(path)
				file = File.open(path, 'r')
				readmeText = file.read
				file.close
			end
			return readmeText
		end

		# return writer readme text
		def self.get_writer_readme(writer)
			readmeText = 'No text found'
			path = File.join(path_to_resources, 'writers', writer, 'readme.md')
			if File.exist?(path)
				file = File.open(path, 'r')
				readmeText = file.read
				file.close
			end
			return readmeText
		end

	end

end
