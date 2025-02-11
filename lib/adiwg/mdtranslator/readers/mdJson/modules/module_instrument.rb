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

                        intMetadataClass = InternalMetadata.new
                        intInstrument = intMetadataClass.newInstrument

                        outContext = 'instrument'
                        outContext = inContext + ' > ' + outContext unless inContext.nil?

                        if hInstrument.has_key?('instrumentId')
                            intInstrument[:instrumentId] = hInstrument['instrumentId']
                        else
                            @MessagePath.issueWarning(40, responseObj, outContext)
                        end

                        if hInstrument.has_key?('citation')
                            intInstrument[:citation] = Citation.unpack(hInstrument['citation'], responseObj, outContext)
                        end

                        if hInstrument.has_key?('identifier')
                            intInstrument[:identifier] = Identifier.unpack(hInstrument['identifier'], responseObj, outContext)
                        else
                            @MessagePath.issueWarning(40, responseObj, outContext)
                        end

                        if hInstrument.has_key?('instrumentType')
                            intInstrument[:instrumentType] = hInstrument['instrumentType']
                        else
                            @MessagePath.issueWarning(40, responseObj, outContext)
                        end

                        if hInstrument.has_key?('description')
                            intInstrument[:description] = hInstrument['description']
                        end

                        if hInstrument.has_key?('mountedOn')
                            intInstrument[:mountedOn] = Platform.unpack(hInstrument['mountedOn'], responseObj, outContext)
                        end

                        if hInstrument.has_key?('history')
                            hInstrument['history'].each do |item|
                                hReturn = InstrumentationEventList.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intInstrument[:histories] << hReturn
                                end
                            end
                        end

                        if hInstrument.has_key?('hostId')
                            intInstrument[:hostId] = Identifier.unpack(hInstrument['hostId'], responseObj, outContext)
                        end

                        intInstrument

                    end
                end

            end
        end
    end
end