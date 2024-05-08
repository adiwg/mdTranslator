require 'jbuilder'
require_relative 'mdJson_identifier'
require_relative 'mdJson_dateTime'
require_relative 'mdJson_objective'
require_relative 'mdJson_pass'
require_relative 'mdJson_instrument'


module ADIWG
    module Mdtranslator
        module Writers
            module MdJson

                module Event

                    @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                    def self.build(hEvent)
                        puts hEvent
                        Jbuilder.new do |json|
                            json.eventId hEvent[:eventId]
                            json.identifier Identifier.build(hEvent[:identifier])
                            json.trigger hEvent[:trigger]
                            json.context hEvent[:context]
                            json.sequence hEvent[:sequence]
                            json.time DateTime.build(hEvent[:time])
                            json.expectedObjective @Namespace.json_map(hEvent[:expectedObjectives], Objective)
                            json.relatedPass Pass.build(hEvent[:relatedPass])
                            json.relatedSensor @Namespace.json_map(hEvent[:relatedSensors], Instrument)
                        end

                    end 
                end # Event
            end
        end
    end
end
