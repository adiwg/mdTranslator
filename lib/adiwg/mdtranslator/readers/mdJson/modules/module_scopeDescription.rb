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

                        # scope description - dataset
                        if hScopeDes.has_key?('dataset')
                            if hScopeDes['dataset'] != ''
                                intScopeDes[:dataset] = hScopeDes['dataset']
                            end
                        end

                        # scope description - attributes
                        if hScopeDes.has_key?('attributes')
                            if hScopeDes['attributes'] != ''
                                intScopeDes[:attributes] = hScopeDes['attributes']
                            end
                        end

                        # scope description - features
                        if hScopeDes.has_key?('features')
                            if hScopeDes['features'] != ''
                                intScopeDes[:features] = hScopeDes['features']
                            end
                        end

                        # scope description - other
                        if hScopeDes.has_key?('other')
                            if hScopeDes['other'] != ''
                                intScopeDes[:other] = hScopeDes['other']
                            end
                        end

                        if intScopeDes[:dataset].nil? &&
                            intScopeDes[:attributes].nil? &&
                            intScopeDes[:features].nil? &&
                            intScopeDes[:other].nil?
                            responseObj[:readerExecutionMessages] << 'Scope Description needs at least one description'
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
