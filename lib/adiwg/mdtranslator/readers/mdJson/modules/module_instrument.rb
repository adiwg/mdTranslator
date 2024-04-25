require_relative 'module_citation'
require_relative 'module_platform'
require_relative 'module_instrumentationEventList'
require_relative 'module_identifier'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module Instrument
                    def self.unpack(hInstrument, responseObj, inContext = nil)
                        @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                        intInstrument = intMetadataClass.newInstrument

                        if hInstrument.has_key('instrumentId')
                            intInstrument[:instrumentId] = hInstrument['instrumentId']
                        else
                            @MessagePath.issueWarning(40, responseObj, inContext, 'Instrument instrumentId')
                        end

                        if hInstrument.has_key('citation')
                            intInstrument[:citation] = Citation.unpack(hInstrument['citation'], responseObj, inContext)
                        end

                        if hInstrument.has_key('identifier')
                            intInstrument[:identifier] = hInstrument['identifier']
                        else
                            @MessagePath.issueWarning(40, responseObj, inContext, 'Instrument identifier')
                        end

                        if hInstrument.has_key('instrumentType')
                            intInstrument[:instrumentType] = hInstrument['instrumentType']
                        else
                            @MessagePath.issueWarning(40, responseObj, inContext, 'Instrument instrumentType')
                        end

                        if hInstrument.has_key('description')
                            intInstrument[:description] = hInstrument['description']
                        end

                        if hInstrument.has_key('mountedOn')
                            intInstrument[:mountedOn] = Platform.unpack(hInstrument['mountedOn'], responseObj, inContext)
                        end

                        if hInstrument.has_key('history')
                            intInstrument[:history].each do |item|
                                hReturn = InstrumentationEventList.unpack(item, responseObj, inContext)
                            unless hReturn.nil?
                                intInstrument[:history] << hReturn
                            end
                        end

                        if hInstrument.has_key('hostId')
                            intInstrument[:hostId] = Identifier.unpack(hInstrument['hostId'], responseObj, inContext)
                        end

                        intInstrument
                    end
                end

            end
        end
    end
end