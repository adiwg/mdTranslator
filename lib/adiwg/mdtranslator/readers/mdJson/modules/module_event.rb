require_relative 'module_identifier'
require_relative 'module_dateTime'
# require_relative 'module_objective'
# require_relative 'module_pass'
# require_relative 'module_instrument'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module Event
                    def self.unpack(hEvent, responseObj, inContext = nil)
                        @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                        intMetadataClass = InternalMetadata.new
                        intEvent = intMetadataClass.newEvent

                        outContext = 'Event'
                        outContext = inContext + ' > ' + outContext unless inContext.nil?

                        if hEvent.has_key?('eventId')
                            intEvent[:eventId] = hEvent['eventId']
                        else
                            @MessagePath.issueWarning(40, responseObj, outContext)
                        end

                        if hEvent.has_key?('identifier')
                            intEvent[:identifier] = Identifier.unpack(hEvent['identifier'], responseObj, outContext)
                        else
                            @MessagePath.issueWarning(40, responseObj, outContext)
                        end

                        if hEvent.has_key?('trigger')
                            intEvent[:trigger] = hEvent['trigger']
                        else
                            @MessagePath.issueWarning(40, responseObj, outContext)
                        end

                        if hEvent.has_key?('context')
                            intEvent[:context] = hEvent['context']
                        else
                            @MessagePath.issueWarning(40, responseObj, outContext)
                        end

                        if hEvent.has_key?('sequence')
                            intEvent[:sequence] = hEvent['sequence']
                        else
                            @MessagePath.issueWarning(40, responseObj, outContext,)
                        end

                        if hEvent.has_key?('time')
                            intEvent[:time] = DateTime.unpack(hEvent['time'], responseObj, outContext)
                        else
                            @MessagePath.issueWarning(40, responseObj, outContext)
                        end

                        if hEvent.has_key?('expectedObjective')
                            intEvent['expectedObjective'].each do |item|
                                hReturn = Objective.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intEvent[:expectedObjectives] << hReturn
                                end
                            end
                        end

                        if hEvent.has_key?('relatedPass')
                            intEvent[:relatedPass] = Pass.unpack(hEvent['relatedPass'], response)
                        end

                        if hEvent.has_key?('relatedSensor')
                            hEvent['relatedSensor'].each do |item|
                                hReturn = Instrument.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intEvent[:relatedSensors] << hReturn
                                end
                            end
                        end

                        intEvent

                    end
                end

            end
        end
    end
end