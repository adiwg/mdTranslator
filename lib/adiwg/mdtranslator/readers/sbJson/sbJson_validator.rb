require 'json'
require 'json-schema'
# temporary json-schema patch
# waiting for rubygem json-schema patch
#require 'adiwg/mdtranslator/readers/sbJson/validator.rb'

module ADIWG
    module Mdtranslator
        module Readers
            module SbJson

                # validate json against the schemas
                # only one schema version is supported at this time
                def self.validate(file, responseObj)

                    # begin
                    #     schema = ADIWG::SbJsonSchemas::Utils.schema_path
                    #     aValErrs = Array.new
                    #     if responseObj[:readerValidationLevel] == 'strict'
                    #         aValErrs = JSON::Validator.fully_validate(schema, file, :strict => true, :errors_as_objects => true)
                    #     elsif responseObj[:readerValidationLevel] == 'normal'
                    #         aValErrs = JSON::Validator.fully_validate(schema, file, :errors_as_objects => true)
                    #     end
                    #
                    #     if aValErrs.length > 0
                    #         responseObj[:readerValidationPass] = false
                    #         responseObj[:readerValidationMessages] << 'sbJson schema validation Failed - see following message(s):\n'
                    #         responseObj[:readerValidationMessages] << aValErrs
                    #         return
                    #     end
                    # rescue JSON::Schema::ValidationError
                    #     responseObj[:readerValidationPass] = false
                    #     responseObj[:readerValidationMessages] << 'sbJson schema validation Failed - see following message(s):\n'
                    #     responseObj[:readerValidationMessages] << $!.message
                    #     return
                    # end

                    responseObj[:readerValidationPass] = true
                end

            end
        end
    end
end
