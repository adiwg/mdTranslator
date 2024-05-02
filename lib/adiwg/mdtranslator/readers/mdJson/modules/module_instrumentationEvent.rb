require_relative 'module_citation'
require_relative 'module_extent'
require_relative 'module_revision'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module InstrumentationEvent
                    def self.unpack(hInstrumentationEvent, responseObj, inContext = nil)
                        @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                        intMetadataClass = InternalMetadata.new
                        intInstrumentationEvent = intMetadataClass.newInstrumentationEvent

                        outContext = 'instrumentation event'
                        outContext = inContext + ' > ' + outContext unless inContext.nil?

                        eventTypeArray = [
                            "announcement",
                            "calibration",
                            "calibrationCoefficientUpdate",
                            "dataLoss",
                            "fatal",
                            "manoeuvre",
                            "missingData",
                            "notice",
                            "prelaunch",
                            "severe",
                            "switchOff",
                            "switchOn",
                            "clean"
                        ]

                        if hInstrumentationEvent.has_key?('citation')
                            intInstrumentationEvent[:citation] = Citation.unpack(hInstrumentationEvent['citation'], responseObj, outContext)
                        end

                        if hInstrumentationEvent.has_key?('description')
                            intInstrumentationEvent[:description] = hInstrumentationEvent['description']
                        else
                            @MessagePath.issueWarning(40, responseObj, outContext)
                        end

                        if hInstrumentationEvent.has_key?('extent')
                            intInstrumentationEvent[:extent] = Extent.unpack(hInstrumentationEvent['extent'], responseObj, outContext)
                        end

                        if hInstrumentationEvent.has_key?('eventType') && eventTypeArray.include?(hInstrumentationEvent['eventType'])
                            intInstrumentationEvent[:eventType] = hInstrumentationEvent['eventType']
                        else
                            @MessagePath.issueWarning(41, responseObj, outContext)
                        end

                        if hInstrumentationEvent.has_key?('revisionHistory')
                            hInstrumentationEvent['revisionHistory'].each do |item|
                                hReturn = Revision.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intInstrumentationEvent[:revisionHistories] << hReturn
                                end
                            end
                        end

                        intInstrumentationEvent
                    end
                end

            end
        end
    end
end