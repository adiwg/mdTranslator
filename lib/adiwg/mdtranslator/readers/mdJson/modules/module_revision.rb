require_relative 'module_responsibleParty'
require_relative 'module_date'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module Revision
                    def self.unpack(hRevision, responseObj, inContext = nil)
                        @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                        intRevision = intMetadataClass.newRevision

                        if hRevision.has_key('description')
                            intRevision[:description] = hRevision['description']
                        else
                            @MessagePath.issueWarning(40, responseObj, inContext, 'revision description')
                        end

                        if hRevision.has_key('responsibleParty')
                            intRevision[:responsibleParty] = responsibleParty.unpack(hRevision['responsibleParty'], responseObj, inContext)
                        else
                            @MessagePath.issueWarning(41, responseObj, inContext, 'revision responsible party')
                        end

                        if hRevision.has_key('dateInfo')
                            intRevision[:dateInfo].each do |item|
                                hReturn = Date.unpack(item, responseObj, inContext)
                            unless hReturn.nil?
                                intRevision[:dateInfo] << hReturn
                            end
                        else
                            @MessagePath.issueWarning(41, responseObj, inContext, 'revision date info')
                        end

                        intRevision
                    end
                end

            end
        end
    end
end