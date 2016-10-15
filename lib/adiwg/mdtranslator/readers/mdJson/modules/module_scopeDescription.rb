# unpack scope description
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-13 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module ScopeDescription

                    def self.unpack(hScopeDes, responseObj)

                        # return nil object if input is empty
                        if hScopeDes.empty?
                            responseObj[:readerExecutionMessages] << 'Scope Description object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intScopeDes = intMetadataClass.newScopeDescription

                        # scope description - type (required)
                        if hScopeDes.has_key?('type')
                            if hScopeDes['type'] != ''
                                type = hScopeDes['type']
                                if %w{ dataset attribute feature other}.one? { |word| word == type }
                                    intScopeDes[:type] = hScopeDes['type']
                                else
                                    responseObj[:readerExecutionMessages] << 'Scope Description type must be database, attribute, feature, or other'
                                    responseObj[:readerExecutionPass] = false
                                    return nil
                                end
                            end
                        end
                        if intScopeDes[:type].nil? || intScopeDes[:type] == ''
                            responseObj[:readerExecutionMessages] << 'Scope Description attribute type is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # scope description - description (required)
                        if hScopeDes.has_key?('description')
                            intScopeDes[:description] = hScopeDes['description']
                        end
                        if intScopeDes[:description].nil? || intScopeDes[:description] == ''
                            responseObj[:readerExecutionMessages] << 'Scope Description attribute description is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intScopeDes

                    end

                end

            end
        end
    end
end
