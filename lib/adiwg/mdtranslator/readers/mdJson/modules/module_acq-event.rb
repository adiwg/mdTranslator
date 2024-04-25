require_relative 'module_identifier'
require_relative 'module_date'
require_relative 'module_objective'
require_relative 'module_pass'
require_relative 'module_instrument'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module AcqEvent
                    def self.unpack(hAcqEvent, responseObj, inContext = nil)
                        @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                        intEvent = intMetadataClass.newEvent

                        if hEvent.has_key('EventId')
                            intEvent[:EventId] = hEvent['EventId']
                        else
                            @MessagePath.issueWarning(40, responseObj, inContext, 'Event EventId')
                        end

                        if hEvent.has_key('identifier')
                            intEvent[:identifier] = Identifier.unpack(hEvent['identifier'], responseObj, inContext)
                        else
                            @MessagePath.issueWarning(40, responseObj, inContext, 'Event identifier')
                        end

                        if hEvent.has_key('trigger')
                            intEvent[:trigger] = hEvent['trigger']
                        else
                            @MessagePath.issueWarning(40, responseObj, inContext, 'Event trigger')
                        end

                        if hEvent.has_key('context')
                            intEvent[:context] = hEvent['context']
                        else
                            @MessagePath.issueWarning(40, responseObj, inContext, 'Event context')
                        end

                        if hEvent.has_key('sequence')
                            intEvent[:sequence] = hEvent['sequence']
                        else
                            @MessagePath.issueWarning(40, responseObj, inContext, 'Event sequence')
                        end

                        if hEvent.has_key('time')
                            intEvent[:time] = Date.unpack(hEvent['time'], responseObj, inContext)
                        else
                            @MessagePath.issueWarning(40, responseObj, inContext, 'Event time')
                        end

                        if hEvent.has_key('expectedObjective')
                            intEvent[:expectedObjective].each do |item|
                                hReturn = Objective.unpack(item, responseObj, inContext)
                            unless hReturn.nil?
                                intEvent[:expectedObjectives] << hReturn
                            end
                        end

                        if hEvent.has_key('relatedPass')
                            intEvent[:relatedPass] = Pass.unpack(hEvent['relatedPass'], response)
                        end

                        if hEvent.has_key('relatedSensor')
                            intEvent[:relatedSensor].each do |item|
                                hReturn = Instrument.unpack(item, responseObj, inContext)
                            unless hReturn.nil?
                                intEvent[:relatedSensors] << hReturn
                            end
                        end
                    end
                end

            end
        end
    end
end