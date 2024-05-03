require 'jbuilder'
require_relative 'mdJson_citation'
require_relative 'mdJson_identifier'
require_relative 'mdJson_requestedDate'

module ADIWG
    module Mdtranslator
        module Writers
            module MdJson

                module Requirement

                    @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                    def self.build(hRequirement)

                        Jbuilder.new do |json|
                            json.requirementId hRequirement[:requirementId]
                            json.citation Citation.build(hRequirement[:citation])
                            json.identifier Identifier.build(hRequirement[:identifier])
                            json.requestor @Namespace.json_map(hRequirement[:requestors], Requestor)
                            json.recipient @Namespace.json_map(hRequirement[:recipients], Recipient)
                            json.priority hRequirement[:priority]
                            json.requestedDate RequestedDate.build(hRequirement[:requestedDate])
                            json.expiryDate hRequirement[:expiryDate]
                            json.satisfiedPlan @Namespace.json_map(hRequirement[:satisfiedPlans], Plan)
                        end

                    end
                end # Requirement
            end
        end
    end
end
