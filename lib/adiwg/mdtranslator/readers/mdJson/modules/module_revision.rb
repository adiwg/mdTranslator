require_relative 'module_responsibleParty'
require_relative 'module_dateTime'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module Revision
                    def self.unpack(hRevision, responseObj, inContext = nil)
                        @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                        intMetadataClass = InternalMetadata.new
                        intRevision = intMetadataClass.newRevision

                        outContext = 'revision'
                        outContext = inContext + ' > ' + outContext unless inContext.nil?

                        if hRevision.has_key?('description')
                            intRevision[:description] = hRevision['description']
                        else
                            @MessagePath.issueWarning(40, responseObj, outContext)
                        end

                        if hRevision.has_key?('responsibleParty')
                            intRevision[:responsibleParty] = ResponsibleParty.unpack(hRevision['responsibleParty'], responseObj, outContext)
                        else
                            @MessagePath.issueWarning(41, responseObj, outContext)
                        end

                        if hRevision.has_key?('dateInfo')
                            hRevision['dateInfo'].each do |item|
                                hReturn = DateTime.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intRevision[:dateInfo] << hReturn
                                end
                            end
                        else
                            @MessagePath.issueWarning(41, responseObj, outContext)
                        end

                        intRevision

                    end
                end

            end
        end
    end
end