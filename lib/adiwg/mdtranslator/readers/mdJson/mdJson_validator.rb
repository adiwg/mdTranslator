# Get minor version of ADIwg JSON V1

# History:
# 	Stan Smith 2014-07-09 original script
#   Stan Smith 2014-07-21 added json structure validation method
#   Stan Smith 2014-08-21 parsed json-schema validation message to readable text
#   Stan Smith 2014-09-26 added processing of minor release numbers
#   Stan Smith 2014-12-01 changed adiwgJson to mdJson in version name check
#   Stan Smith 2014-12-03 changed class name to MdJsonValidation from AdiwgJsonValidation
#   Stan Smith 2014-12-11 added namespace

require 'json'
require 'json-schema'
require 'adiwg-mdjson_schemas'
# temporary json-schema patch
# waiting for rubygem json-schema patch
require 'adiwg/mdtranslator/readers/mdJson/validator.rb'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                # validate json against the adiwg-json_schemas
                # only one schema version is supported at this time
                def self.validate(file)
                    begin

                        schema = ADIWG::MdjsonSchemas::Utils.schema_path
                        aValErrs = Array.new
                        if $response[:readerValidationLevel] == 'strict'
                            aValErrs = JSON::Validator.fully_validate(schema, file, :strict => true, :errors_as_objects => true)
                        elsif $response[:readerValidationLevel] == 'normal'
                            aValErrs = JSON::Validator.fully_validate(schema, file, :errors_as_objects => true)
                        end

                        if aValErrs.length > 0
                            $response[:readerValidationPass] = false
                            $response[:readerValidationMessages] << 'mdJson schema validation Failed - see following message(s):\n'
                            $response[:readerValidationMessages] = aValErrs
                            return
                        end
                    rescue JSON::Schema::ValidationError
                        $response[:readerValidationPass] = false
                        $response[:readerValidationMessages] << 'mdJson schema validation Failed - see following message(s):\n'
                        $response[:readerValidationMessages] << $!.message
                        return
                    end

                    $response[:readerValidationPass] = true
                end

            end
        end
    end
end


