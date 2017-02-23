# Get minor version of ADIwg mdJson 2.x

# History:
#   Stan Smith 2017-02-22 refactor for mdJson/mdTranslator 2.0
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2014-12-11 added namespace
#   Stan Smith 2014-12-03 changed class name to MdJsonValidation from AdiwgJsonValidation
#   Stan Smith 2014-12-01 changed adiwgJson to mdJson in version name check
#   Stan Smith 2014-09-26 added processing of minor release numbers
#   Stan Smith 2014-08-21 parsed json-schema validation message to readable text
#   Stan Smith 2014-07-21 added json structure validation method
# 	Stan Smith 2014-07-09 original script


require 'json'
require 'json-schema'
require 'adiwg-mdjson_schemas'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                # validate json against the adiwg-json_schemas
                # only a single schema version is supported at this time
                def self.validate(file, responseObj)

                    bStrict = false
                    if responseObj[:readerValidationLevel] == 'strict'
                        bStrict = true
                    end
                    ADIWG::MdjsonSchemas::Utils.load_schemas(false)

                    begin
                        aErrors = []
                        aErrors = JSON::Validator.fully_validate('schema.json', file, :strict=>bStrict)

                        if aErrors.length > 0
                            responseObj[:readerValidationPass] = false
                            responseObj[:readerValidationMessages] << 'mdJson schema validation Failed - see following message(s):\n'
                            responseObj[:readerValidationMessages] << aErrors
                            return
                        end

                    rescue JSON::Schema::ValidationError
                        responseObj[:readerValidationPass] = false
                        responseObj[:readerValidationMessages] << 'mdJson schema validation Failed - see following message(s):\n'
                        responseObj[:readerValidationMessages] << $!.message
                        return
                    end

                end

            end
        end
    end
end


