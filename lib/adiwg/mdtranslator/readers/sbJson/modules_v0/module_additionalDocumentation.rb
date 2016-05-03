require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_citation')

module ADIWG
    module Mdtranslator
        module Readers
            module SbJson

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
