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

                        intInstrumentationEvent = intMetadataClass.newInstrumentationEvent

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

                        if hInstrumentationEvent.has_key('citation')
                            intInstrumentationEvent[:citation] = Citation.unpack(hInstrumentationEvent['citation'], responseObj, inContext)
                        end

                        if hInstrumentationEvent.has_key('description')
                            intInstrumentationEvent[:description] = hInstrumentationEvent['description']
                        else
                            @MessagePath.issueWarning(40, responseObj, inContext, 'instrumentation event description')
                        end

                        if hInstrumentationEvent.has_key('extent')
                            intInstrumentationEvent[:extent] = Extent.unpack(hInstrumentationEvent['extent'], responseObj, inContext)
                        end

                        if hInstrumentationEvent.has_key('eventType') && eventTypeArray.include?(hInstrumentationEvent['eventType'])
                            intInstrumentationEvent[:eventType] = hInstrumentationEvent['eventType']
                        else
                            @MessagePath.issueWarning(41, responseObj, inContext, 'instrumentation event type')
                        end

                        if hInstrumentationEvent.has_key('revisionHistory')
                            hrevisionHistory['revisionHistory'].each do |item|
                                hReturn = Revision.unpack(item, responseObj, inContext)
                            unless hReturn.nil?
                                intrevisionHistory[:revisionHistories] << hReturn
                            end
                        end

                        intInstrumentationEvent
                    end
                end

            end
        end
    end
end