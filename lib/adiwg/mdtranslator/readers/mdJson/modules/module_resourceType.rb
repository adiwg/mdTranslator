# unpack resourceType
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2017-02-15 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module ResourceType

                    def self.unpack(hType, responseObj)

                        # return nil object if input is empty
                        if hType.empty?
                            responseObj[:readerExecutionMessages] << 'Resource Type object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intType = intMetadataClass.newResourceType

                        # resource type - type (required) {MD_ScopeCode}
                        if hType.has_key?('type')
                            if hType['type'] != ''
                                intType[:type] = hType['type']
                            end
                        end
                        if intType[:type].nil?
                            responseObj[:readerExecutionMessages] << 'Resource Type object is missing type'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # resource type - name
                        if hType.has_key?('name')
                            if hType['name'] != ''
                                intType[:name] = hType['name']
                            end
                        end

                        return intType

                    end

                end

            end
        end
    end
end
