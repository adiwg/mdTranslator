# unpack additional documentation
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-11-06 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-30 added return if empty input
#   ... found & fixed error of method using associatedResource object instead of
#   ... additionalDocumentation object
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to remove global namespace constants

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_citation')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module AdditionalDocumentation

                    def self.unpack(hAddDoc, responseObj)

                        # return nil object if input is empty
                        intAddDoc = nil
                        return if hAddDoc.empty?

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intAddDoc = intMetadataClass.newAdditionalDocumentation

                        # additional documentation - resource type
                        if hAddDoc.has_key?('resourceType')
                            s = hAddDoc['resourceType']
                            if s != ''
                                intAddDoc[:resourceType] = s
                            end
                        end

                        # additional documentation - resource citation
                        if hAddDoc.has_key?('citation')
                            hCitation = hAddDoc['citation']
                            unless hCitation.empty?
                                intAddDoc[:citation] = Citation.unpack(hCitation, responseObj)
                            else
                                responseObj[:readerExecutionMessages] << 'Additional documentation citation is empty'
                                responseObj[:readerExecutionPass] = false
                                return nil
                            end
                        else
                            responseObj[:readerExecutionMessages] << 'Additional documentation citation is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intAddDoc
                    end

                end

            end
        end
    end
end
