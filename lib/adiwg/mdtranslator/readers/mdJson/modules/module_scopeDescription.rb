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
                        attributeCount = 0

                        # scope description - dataset description
                        if hScopeDes.has_key?('datasetDescription')
                            if hScopeDes['datasetDescription'] != ''
                                intScopeDes[:datasetDescription] = hScopeDes['datasetDescription']
                                attributeCount += 1
                            end
                        end

                        # scope description - attribute description
                        if hScopeDes.has_key?('attributeDescription')
                            if hScopeDes['attributeDescription'] != ''
                                intScopeDes[:attributeDescription] = hScopeDes['attributeDescription']
                                attributeCount += 1
                            end
                        end

                        # scope description - feature description
                        if hScopeDes.has_key?('featureDescription')
                            if hScopeDes['featureDescription'] != ''
                                intScopeDes[:featureDescription] = hScopeDes['featureDescription']
                                attributeCount += 1
                            end
                        end

                        # scope description - other description
                        if hScopeDes.has_key?('otherDescription')
                            if hScopeDes['issuePage'] != ''
                                intScopeDes[:otherDescription] = hScopeDes['otherDescription']
                                attributeCount += 1
                            end
                        end

                        if attributeCount > 1
                            responseObj[:readerExecutionMessages] << 'Scope Description described multiple object types'
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
