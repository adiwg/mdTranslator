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

                        if hInstrumentationEventList.has_key?('citation')
                            citations = hInstrumentationEventList['citation']
                            citations.each do |citation|
                                hReturn = Citation.unpack(hInstrumentationEventList['citation'], responseObj, inContext)
                                unless hReturn.nil?
                                    intInstrumentationEventList[:citations] << hReturn
                                end
                            end
                        end

                        if hInstrumentationEventList.has_key?('description')
                            intInstrumentationEventList[:description] = hInstrumentationEventList['description']
                        else
                            @MessagePath.issueWarning(40, responseObj, inContext, 'instrumentation event description')
                        end

                        if hInstrumentationEventList.has_key?('locale')
                            hReturn = Locale.unpack(hInstrumentationEventList['locale'], responseObj, inContext)
                            
                        end

                        if hInstrumentationEventList.has_key?('constraint')
                            constraints = hInstrumentationEventList['constraint']
                            constraints.each do |constraint|
                                hReturn = Constraint.unpack(hInstrumentationEventList['constraint'], responseObj, inContext)
                                unless hReturn.nil?
                                    intInstrumentationEventList[:constraints] << hReturn
                                end
                            end
                        end

                        if hInstrumentationEventList.has_key?('instrumentationEvent')
                            hInstrumentationEventList['instrumentationEvent'].each do |item|
                                hReturn = InstrumentationEvent.unpack(item, responseObj, inContext)
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