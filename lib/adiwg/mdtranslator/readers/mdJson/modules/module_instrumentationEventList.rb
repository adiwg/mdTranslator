require_relative 'module_citation'
require_relative 'module_locale'
require_relative 'module_constraint'
require_relative 'module_instrumentationEvent'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module InstrumentationEventList
                    def self.unpack(hInstrumentationEventList, responseObj, inContext = nil)
                        @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                        intMetadataClass = InternalMetadata.new
                        intInstrumentationEventList = intMetadataClass.newInstrumentationEventList

                        outContext = 'instrumentation event list'
                        outContext = inContext + ' > ' + outContext unless inContext.nil?

                        if hInstrumentationEventList.has_key?('citation')
                            intInstrumentationEventList[:citation] = Citation.unpack(hInstrumentationEventList['citation'], responseObj, outContext)
                        end

                        if hInstrumentationEventList.has_key?('description')
                            intInstrumentationEventList[:description] = hInstrumentationEventList['description']
                        else
                            @MessagePath.issueWarning(40, responseObj, outContext, 'instrumentation event description')
                        end

                        if hInstrumentationEventList.has_key?('locale')
                            hReturn = Locale.unpack(hInstrumentationEventList['locale'], responseObj, outContext)
                            
                        end

                        if hInstrumentationEventList.has_key?('constraint')
                            constraints = hInstrumentationEventList['constraint']
                            constraints.each do |constraint|
                                hReturn = Constraint.unpack(hInstrumentationEventList['constraint'], responseObj, outContext)
                                unless hReturn.nil?
                                    intInstrumentationEventList[:constraints] << hReturn
                                end
                            end
                        end

                        if hInstrumentationEventList.has_key?('instrumentationEvent')
                            hInstrumentationEventList['instrumentationEvent'].each do |item|
                                hReturn = InstrumentationEvent.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intInstrumentationEventList[:instrumentationEvents] << hReturn
                                end
                            end
                        end

                        intInstrumentationEventList
                    end
                end

            end
        end
    end
end