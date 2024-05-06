require_relative 'module_identifier'
require_relative 'module_extent'
require_relative 'module_event'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module Pass
                    def self.unpack(hPass, responseObj, inContext = nil)
                        @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                        intMetadataClass = InternalMetadata.new
                        intPass = intMetadataClass.newPass

                        outContext = 'pass'
                        outContext = inContext + ' > ' + outContext unless inContext.nil?

                        if hPass.has_key?('passId')
                            intPass[:passId] = hPass['passId']
                        else
                            @MessagePath.issueWarning(40, responseObj, outContext)
                        end

                        if hPass.has_key?('identifier')
                            intPass[:identifier] = Identifier.unpack(hPass['identifier'], responseObj, outContext)
                        else
                            @MessagePath.issueWarning(40, responseObj, outContext)
                        end

                        if hPass.has_key?('extent')
                            intPass[:extent] = Extent.unpack(hPass['extent'], responseObj, outContext)
                        end

                        if hPass.has_key?('relatedEvent')
                            hPass['relatedEvent'].each do |item|
                                hReturn = Event.unpack(item, responseObj, outContext)
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