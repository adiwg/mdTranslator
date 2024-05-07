require 'jbuilder'
require_relative 'mdJson_citation'
# require_relative 'mdJson_operation'
require_relative 'mdJson_requirement'

module ADIWG
    module Mdtranslator
        module Writers
            module MdJson

                module Plan

                    @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                    def self.build(hPlan)

                        Jbuilder.new do |json|
                            json.planId hPlan[:planId]
                            json.planType hPlan[:planType] unless hPlan[:planType].nil?
                            json.status hPlan[:status]
                            json.citation Citation.build(hPlan[:citation])
                            # json.planOperation @Namespace.json_map(hPlan[:operations], Operation)
                            json.satisfiedRequirement @Namespace.json_map(hPlan[:satisfiedRequirements], Requirement)

                        end

                    end
                end # Requirement
            end
        end
    end
end
