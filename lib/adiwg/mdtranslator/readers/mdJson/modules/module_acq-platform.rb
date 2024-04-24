require_relative 'module_citation'
require_relative 'module_identifier'
require_relative 'module_responsibileParty'
require_relative 'module_acq-instrument'
require_relative 'module_acq-instrumentationEventList'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module AcqPlatform
                    def self.unpack(hAcqPlatform, responseObj, inContext = nil)
                        @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                        intAcqPlatform = intMetadataClass.newPlatform

                        if hAcqPlatform.has_key('platformId')
                            intAcqPlatform[:platformId] = hAcqPlatform['platformId']
                        else
                            @MessagePath.issueError(460, responseObj, inContext)
                        end

                        if hAcqPlatform.has_key?('citation')
                            hReturn = Citation.unpack(hAcqPlatform['citation'], responseObj, inContext)
                            unless hReturn.nil?
                                intAcqPlatform[:citation] = hReturn
                            end
                        end

                        if hAcqPlatform.has_key?('identifier')
                            hReturn = Identifier.unpack(hAcqPlatform['identifier'], responseObj, inContext)
                            unless hReturn.nil?
                                intAcqPlatform[:identifier] = hReturn
                            else
                                @MessagePath.issueError(461, responseObj, inContext)
                            end
                        end
                        
                        if hAcqPlatform.has_key('description')
                            intAcqPlatform[:description] = hAcqPlatform['description']
                        else
                            @MessagePath.issueError(460, responseObj, inContext)
                        end
                        
                        if hAcqPlatform.has_key?('sponsor')
                            hReturn = ResponsibileParty.unpack(hAcqPlatform['sponsor'], responseObj, inContext)
                            unless hReturn.nil?
                                intAcqPlatform[:sponsors] = hReturn
                            end
                        end

                        if hAcqPlatform.has_key('instrument')
                            hReturn = AcqInstrument.unpack(hAcqPlatform['instrument'], responseObj, inContext)
                            unless hReturn.nil?
                                intAcqPlatform[:instruments] = hReturn
                            else
                                @MessagePath.issueError(461, responseObj, inContext)
                            end
                        end

                        if hAcqPlatform.has_key('history')
                            hReturn = AcqInstrumentationEventList.unpack(hAcqPlatform['history'], responseObj, inContext)
                            unless hReturn.nil?
                                intAcqPlatform[:history] = hReturn
                        end

                        intAcqPlatform

                    end
                end

            end
        end
    end
end