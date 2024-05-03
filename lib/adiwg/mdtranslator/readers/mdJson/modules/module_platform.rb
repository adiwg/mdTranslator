require_relative 'module_citation'
require_relative 'module_identifier'
require_relative 'module_responsibleParty'
require_relative 'module_acq-instrument'
require_relative 'module_acq-instrumentationEventList'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module Platform
                    def self.unpack(hPlatform, responseObj, inContext = nil)
                        @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                        intMetadataClass = InternalMetadata.new
                        intPlatform = intMetadataClass.newPlatform

                        if hPlatform.has_key?('platformId')
                            intPlatform[:platformId] = hPlatform['platformId']
                        else
                            @MessagePath.issueError(460, responseObj, inContext)
                        end

                        if hPlatform.has_key?('citation')
                            hReturn = Citation.unpack(hPlatform['citation'], responseObj, inContext)
                            unless hReturn.nil?
                                intPlatform[:citation] = hReturn
                            end
                        end

                        if hPlatform.has_key?('identifier')
                            hReturn = Identifier.unpack(hPlatform['identifier'], responseObj, inContext)
                            unless hReturn.nil?
                                intPlatform[:identifier] = hReturn
                            else
                                @MessagePath.issueError(461, responseObj, inContext)
                            end
                        end
                        
                        if hPlatform.has_key?('description')
                            intPlatform[:description] = hPlatform['description']
                        else
                            @MessagePath.issueError(460, responseObj, inContext)
                        end
                        
                        if hPlatform.has_key?('sponsor')
                            hPlatform['sponsor'].each do |sponsor|
                                hReturn = ResponsibleParty.unpack(sponsor, responseObj, inContext)
                                unless hReturn.nil?
                                    intPlatform[:sponsors] = hReturn
                                end
                            end
                        end

                        if hPlatform.has_key?('instrument')
                            hReturn = AcqInstrument.unpack(hPlatform['instrument'], responseObj, inContext)
                            unless hReturn.nil?
                                intPlatform[:instruments] = hReturn
                            else
                                @MessagePath.issueError(461, responseObj, inContext)
                            end
                        end

                        if hPlatform.has_key?('history')
                            hReturn = AcqInstrumentationEventList.unpack(hPlatform['history'], responseObj, inContext)
                            unless hReturn.nil?
                                intPlatform[:history] = hReturn
                            end
                        end

                        intPlatform

                    end
                end

            end
        end
    end
end