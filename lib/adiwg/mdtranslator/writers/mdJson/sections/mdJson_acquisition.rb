require 'jbuilder'
require_relative 'mdJson_scope'
require_relative 'mdJson_plan'
require_relative 'mdJson_requirement'
require_relative 'mdJson_objective'
require_relative 'mdJson_platform'
require_relative 'mdJson_instrument'
# require_relative 'mdJson_operation'
require_relative 'mdJson_event'
require_relative 'mdJson_pass'
require_relative 'mdJson_environment'

module ADIWG
    module Mdtranslator
        module Writers
            module MdJson

                module Acquisition

                    @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                    def self.build(hAcquisition)

                        Jbuilder.new do |json|
                            json.scope Scope.build(hAcquisition[:scope])
                            json.plan @Namespace.json_map(hAcquisition[:plans], Plan)
                            json.requirement @Namespace.json_map(hAcquisition[:requirements], Requirement)
                            json.objective @Namespace.json_map(hAcquisition[:objectives], Objective)
                            json.platform @Namespace.json_map(hAcquisition[:platforms], Platform)
                            json.instrument @Namespace.json_map(hAcquisition[:instruments], Instrument)
                            # json.operation @Namespace.json_map(hAcquisition[:operations], Operation)
                            json.event @Namespace.json_map(hAcquisition[:events], Event)
                            json.pass @Namespace.json_map(hAcquisition[:passes], Pass)
                            json.environment Environment.build(hAcquisition[:environment])
                        end

                    end 
                end # Acquisition
            end # Event
        end
    end
end
