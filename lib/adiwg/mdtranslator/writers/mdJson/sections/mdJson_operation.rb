require 'jbuilder'

module ADIWG
    module Mdtranslator
        module Writers
            module MdJson

                module Operation

                    @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                    def self.build(hOperation)

                        Jbuilder.new do |json|
                            json.operationId hOperation[:operationId]
                            json.description hOperation[:description] unless hOperation[:description].nil?
                            json.citation Citation.build(hOperation[:citation]) unless hOperation[:citation].empty?
                            json.identifier Identifier.build(hOperation[:identifier])
                            json.status hOperation[:status]
                            json.operationType hOperation[:operationType] unless hOperation[:operationType].nil?
                            json.objective @Namespace.json_map(hOperation[:objectives], Objective) unless hOperation[:objectives].empty?
                            json.parentOperation Operation.build(hOperation[:parentOperation]) unless hOperation[:parentOperation].empty?
                            json.childOperation @Namespace.json_map(hOperation[:childOperations], Operation) unless hOperation[:childOperations].empty?
                            json.plan Plan.build(hOperation[:plan]) unless hOperation[:plan].empty?
                            json.platform @Namespace.json_map(hOperation[:platforms], Platform) unless hOperation[:platforms].empty?
                            json.significantEvent @Namespace.json_map(hOperation[:significantEvents], Event) unless hOperation[:significantEvents].empty?
                        end

                    end
                end # Operation
            end
        end
    end
end
