# MdTranslator - ADIwg MdTranslator entry point

# History:
#   Stan Smith 2016-11-11 refactor for mdTranslator 2.0
#   Stan Smith 2015-07-17 added support for user supplied CSS for html writer
#   Stan Smith 2015-07-16 moved module_coordinates from mdJson reader to internal
#   Stan Smith 2015-07-14 renamed readerVersionFound to readerVersionRequested
#   Stan Smith 2015-07-14 deleted readerFound
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#   ... created as an instance of class ResponseHash
#   Stan Smith 2015-03-04 moved addFinalMessages into this module from rails app
#   Stan Smith 2015-01-15 changed translate() to keyword parameter list
#   Stan Smith 2014-12-11 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-02 organized shared class/code/units folders for 19115-2, 19110
#   Stan Smith 2014-12-01 added translator version to $response
#   Stan Smith 2014-12-01 added writer iso19110 (feature catalogue)
#   Stan Smith 2014-12-01 changed adiwgJson to mdJson
#   Stan Smith 2014-10-11 added methods to return content of readme files
#   Stan Smith 2014-10-10 added method to return path to readers and writers
#   Stan Smith 2014-09-26 added processing of minor release numbers
#   Stan Smith 2014-07-23 moved all validations to readers/adiwg/adiwg_validator.rb
#   ... each reader will have it's own validator
#   Stan Smith 2014-07-21 added validation of json structure
#   Stan Smith 2014-07-21 added ADIWG namespace
# 	Stan Smith 2014-07-02 original script

# required by readers and writers
require 'adiwg/mdtranslator/version'
require 'adiwg/mdtranslator/readers/mdReaders'
require 'adiwg/mdtranslator/writers/mdWriters'

module ADIWG
    module Mdtranslator

        def self.translate(file:, reader: 'mdJson', writer: nil, validate: 'normal', showAllTags: false, cssLink: nil)

            # the reader and writer specified in the translate module parameter string will load and
            #     return this hash ...
            # ====================================================================================
            # readerRequested: name of the reader requested by the user
            #   - set from the parameter list (reader) (default = 'mdJson')
            # ------------------------------------------------------------------------------------
            # readerVersionRequested: version of the reader requested in input file
            #   - set in reader
            # ------------------------------------------------------------------------------------
            # readerVersionUsed: actual reader version use in processing the input file
            #   - set by the reader
            # ------------------------------------------------------------------------------------
            # readerStructurePass: false if input file structure is determined to be invalid
            #   - set by the reader
            # ------------------------------------------------------------------------------------
            # readerStructureMessages: an array of parser warning and error messages
            #   - set by the reader
            # ------------------------------------------------------------------------------------
            # readerValidationLevel: validation level requested to be applied to the input file, set
            #   - set from the parameter list (reader)
            # ------------------------------------------------------------------------------------
            # readerValidationPass: false if fails requested level of validation
            #   - set by the reader
            # ------------------------------------------------------------------------------------
            # readerValidationMessages: an array of schema warning and error messages
            #   - set by the reader
            # ------------------------------------------------------------------------------------
            # readerExecutionPass: false if the reader finds fatal errors in input file
            #   - set by the reader
            # ------------------------------------------------------------------------------------
            # readerExecutionMessages: an array of reader warning and error messages
            #   - set by the reader
            # ------------------------------------------------------------------------------------
            # writerRequested: name of the writer requested by the user
            #   - set from the parameter list (writer)
            # ------------------------------------------------------------------------------------
            # writerVersion: current version of the requested writer
            #   - set by the writer
            # ------------------------------------------------------------------------------------
            # writerFormat: format of writer output
            #   - set by the writer
            # ------------------------------------------------------------------------------------
            # writerPass: false if the writer fails to complete creation of output file
            #   - set by the writer
            # ------------------------------------------------------------------------------------
            # writerMessages: an array of writer warning and error messages
            #   - set by the writer
            # ------------------------------------------------------------------------------------
            # writerOutput: the output file returned by the writer
            #   - set by the writer
            # ------------------------------------------------------------------------------------
            # writerShowTags: include tags in XML output for any empty elements
            #   - set from the parameter list (showAllTags)
            # ------------------------------------------------------------------------------------
            # writerCSSlink: CSS link to append to HTML writer output
            #   - set from the parameter list (showAllTags)
            # ------------------------------------------------------------------------------------
            # writerMissingIdCount: counter for creating unique element IDs as needed
            #   - set by the writer
            # ------------------------------------------------------------------------------------
            # translatorVersion: current version of the mdTranslator
            #   - set by the translator
            # ------------------------------------------------------------------------------------

            hResponseObj =  {
                readerRequested: nil,
                readerVersionRequested: nil,
                readerVersionUsed: nil,
                readerStructurePass: true,
                readerStructureMessages: [],
                readerValidationLevel: nil,
                readerValidationPass: true,
                readerValidationMessages: [],
                readerExecutionPass: true,
                readerExecutionMessages: [],
                writerRequested: nil,
                writerPass: true,
                writerMessages: [],
                writerOutputFormat: nil,
                writerOutput: nil,
                writerShowTags: false,
                writerCSSlink: nil,
                writerMissingIdCount: '_000',
                translatorVersion: nil
            }

            # parameter - file (required)
            if file.nil? || file == ''
                hResponseObj[:readerExecutionPass] = false
                hResponseObj[:readerExecutionMessages] << "Parameter 'file:' was not provided"
                return hResponseObj
            end

            # parameter - reader (required)
            if reader == ''
                hResponseObj[:readerExecutionPass] = false
                hResponseObj[:readerExecutionMessages] << "Parameter 'reader:' was not provided"
                return hResponseObj
            end

            # add passed in parameters to the response hash
            hResponseObj[:readerRequested] = reader
            hResponseObj[:readerValidationLevel] = validate
            hResponseObj[:writerRequested] = writer
            hResponseObj[:writerShowTags] = showAllTags
            hResponseObj[:writerCSSlink] = cssLink

            # add mdTranslator version to response hash
            hResponseObj[:translatorVersion] = ADIWG::Mdtranslator::VERSION

            # handle reader
            intObj = ADIWG::Mdtranslator::Readers.handleReader(file, hResponseObj)

            # if reader file structure failed - exit
            if hResponseObj[:readerStructurePass] === false
                return hResponseObj
            end

            # if reader file validation failed - exit
            if hResponseObj[:readerValidationPass] === false
                return hResponseObj
            end

            # if reader file execution failed - exit
            if hResponseObj[:readerExecutionPass] === false
                return hResponseObj
            end

            #handle writers
            if writer.nil? || writer == ''
                hResponseObj[:writerMessages] << "Parameter 'writer:' was not provided"
                hResponseObj[:writerPass] = false
                return hResponseObj
            end

            require File.join(File.dirname(__FILE__), 'mdtranslator/writers/mdWriters')
            ADIWG::Mdtranslator::Writers.handleWriter(intObj, hResponseObj)

            return hResponseObj

        end

    end

end
