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
#   Stan Smith 2015-03-04 moved addFinalMessages into this module from rails app

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

        class ResponseHash

            # the reader and writer specified in the translate parameter string should load and
            #     return this hash ...
            # ---------------------------
            # readerFormat: the anticipated format of the input file, parsing by the reader will
            #     proceed assuming this format, set by reader
            # readerStructurePass: 'true' if input file structure is determined to be valid.
            #    Set by the reader.
            # readerStructureMessages: an array of quoted string messages. If readerStructurePass
            #    is false, set one or more messages to assist the user in fixing file structure
            #    problems.  Set by reader.
            # readerRequested: name of the reader requested by the user, set from  the translate
            #    parameter list
            # readerFound: name of the reader used by the reader, set by reader.  Will be same as
            #    readerRequested if readerRequested name is valid
            # readerVersionFound: version of the reader requested by the input file, set by reader
            # readerVersionUsed: version of the reader the reader method decided to use in processing
            #    the input file.  Set by the reader.  Default 'normal'.
            # readerValidationLevel: validation level requested to be applied to the input file, set
            #    from the parameter list
            # readerValidationPass: true if the input file passes the level of validation requested,
            #    set by reader
            # readerValidationMessages: an array of quoted string messages. If readerValidationPass
            #    is 'false', set one or more messages to assist user fixing file schema validation
            #    problems.  Set by reader.
            # readerExecutionPass: 'true' if the reader completes the import of the input file into
            #    the internal object without errors. set by reader.
            # readerExecutionMessages: an array of quoted string messages. If readerExecutionPass is
            #    'false', set one or more messages to assist user in fixing file data problems.
            #    Set by reader.
            # writerName: name of the writer requested by the user, set from the translate parameter
            #    list.  if nil no write was requested and only validation of the input file will
            #    be performed.
            # writerVersion: current version of the writer requested, set by writer
            # writerFormat: format of the output from the writer. Set by writer.
            # writerPass: true if the writer completes the creation of the output file without errors,
            #    set by writer
            # writerMessages: an array of quoted string messages.  If writerPass is 'false', set one
            #    or more messages to assist user in fixing file data problems.  Set by writer.
            # writerOutput: output file returned from the writer, set by writer
            # writerShowTags: include tags in XML output for empty elements

            def response
                {
                    readerFormat: nil,
                    readerStructurePass: nil,
                    readerStructureMessages: [],
                    readerRequested: nil,
                    readerFound: nil,
                    readerVersionFound: nil,
                    readerVersionUsed: nil,
                    readerValidationLevel: nil,
                    readerValidationPass: nil,
                    readerValidationMessages: [],
                    readerExecutionPass: nil,
                    readerExecutionMessages: [],
                    writerName: nil,
                    writerVersion: nil,
                    writerFormat: nil,
                    writerPass: nil,
                    writerMessages: [],
                    writerOutput: nil,
                    writerShowTags: false
                }
            end

        end

        def self.translate(file:, reader:, validate: 'normal', writer: nil, showAllTags: false)

            # create a new instance of the response hash for this translation run
            responseClass = ResponseHash.new
            responseObj = responseClass.response

            # add the passed in parameters to the response hash
            responseObj[:readerRequested] = reader
            responseObj[:readerValidationLevel] = validate
            responseObj[:writerName] = writer
            responseObj[:writerShowTags] = showAllTags

            # handle readers
            if reader.nil? || reader == ''
                responseObj[:readerExecutionPass] = false
                responseObj[:readerExecutionMessages] << 'Reader name was not provided'
                return responseObj
            else
                require File.join(File.dirname(__FILE__), 'mdtranslator/readers/mdReaders')
                intObj = ADIWG::Mdtranslator::Readers.handleReader(file, responseObj)

                # if readerExecutionPass is nil no error messages were set while
                # reading  the input file into the internal object.
                # the read operation is assumed to have been successful and pass is set to true.
                if responseObj[:readerExecutionPass].nil?
                    responseObj[:readerExecutionPass] = true
                elsif !responseObj[:readerExecutionPass]
                    return responseObj
                end

            end

            # handle writers
            if writer.nil? || writer == ''
                responseObj[:writerMessages] << 'Writer name was not provided.'
            else
                require File.join(File.dirname(__FILE__), 'mdtranslator/writers/mdWriters')
                ADIWG::Mdtranslator::Writers.handleWriter(intObj)
            end

            return responseObj

        end

    end

end
