module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module AcqPass
                    def self.unpack(hAcqPass, responseObj, inContext = nil)
                        @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                        intPass = intMetadataClass.newPass

                        if hPass.has_key('PassId')
                            intPass[:PassId] = hPass['PassId']
                        else
                            @MessagePath.issueWarning(40, responseObj, inContext, 'Pass PassId')
                        end

                        if hPass.has_key('identifier')
                            intPass[:identifier] = Identifier.unpack(hPass['identifier'], responseObj, inContext)
                        else
                            @MessagePath.issueWarning(40, responseObj, inContext, 'Pass identifier')
                        end

                        if hPass.has_key('extent')
                            intPass[:extent] = Extent.unpack(hPass['extent'], responseObj, inContext)
                        end

                        if hPass.has_key('relatedEvent')
                            intPass[:relatedEvent].each do |item|
                                hReturn = AcqEvent.unpack(item, responseObj, inContext)
                                unless hReturn.nil?
                                    intPass[:relatedEvents] << hReturn
                                end
                            end
                        end

                        intPass

                    end
                end

            end
        end
    end
end