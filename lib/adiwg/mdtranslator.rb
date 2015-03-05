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
#   Stan Smith 2014-12-01 changed adiwgJson to mdJson
#   Stan Smith 2014-12-01 added writer iso19110 (feature catalogue)
#   Stan Smith 2014-12-01 added translator version to $response
#   Stan Smith 2014-12-02 organized shared class/code/units folders for 19115-2, 19110
#   Stan Smith 2014-12-11 refactored to handle namespacing readers and writers
#   Stan Smith 2015-01-15 changed translate() to keyword parameter list

# add main directories to load_path
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'mdtranslator/internal'))

require 'adiwg/mdtranslator/version'

# additional require statements to support rails
# ... these modules contain methods called by rails endpoints
# ... by default rails does not resolve namespaces beyond this point
require 'adiwg/mdtranslator/readers/mdReaders'
require 'adiwg/mdtranslator/writers/mdWriters'

module ADIWG
    module Mdtranslator

        def self.translate(file:, reader:, validate: 'normal', writer: nil, showAllTags: false)

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
                readerExecutionPass: nil,
                readerExecutionMessages: [],
                writerName: writer,
                writerVersion: nil,
                writerFormat: nil,
                writerPass: nil,
                writerMessages: [],
                writerOutput: nil
            }

            # handle readers
            if reader.nil? || reader == ''
                $response[:readerValidationPass] = false
                $response[:readerValidationMessages] << 'Reader name is missing.'
                $response[:readerExecutionPass] = false
                $response[:readerExecutionMessages] << 'Reader failed to initiate.'
                return $response
            else
                require File.join(File.dirname(__FILE__), 'mdtranslator/readers/mdReaders')
                intObj = ADIWG::Mdtranslator::Readers.handleReader(file)

                if intObj
                    $response[:readerExecutionPass] = true
                else
                    return $response
                end
            end

            # handle writers
            if writer.nil? || writer == ''
                $response[:writerPass] = false
                $response[:writerMessages] << 'Writer name is missing.'
            else
                require File.join(File.dirname(__FILE__), 'mdtranslator/writers/mdWriters')
                ADIWG::Mdtranslator::Writers.handleWriter(intObj)
            end
            return $response

        end

    end

end
