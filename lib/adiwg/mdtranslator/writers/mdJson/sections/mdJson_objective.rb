require 'jbuilder'
require_relative 'mdJson_identifier'
require_relative 'mdJson_objectiveType'
require_relative 'mdJson_extent'
require_relative 'mdJson_event'
require_relative 'mdJson_pass'
require_relative 'mdJson_instrument'

module ADIWG
    module Mdtranslator
        module Writers
            module MdJson

                module Objective

                    @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                    def self.build(hObjective)

                        Jbuilder.new do |json|
                            json.objectiveId hObjective[:objectiveId]
                            json.identifier @Namespace.json_map(hObjective[:identifiers], Identifier)
                            json.priority hObjective[:priority] unless hObjective[:priority].nil?
                            json.objectiveType hObjective[:objectiveTypes] unless hObjective[:types].empty?
                            json.function hObjective[:functions] unless hObjective[:functions].empty?
                            json.extent @Namespace.json_map(hObjective[:extents], Extent) unless hObjective[:extents].empty?
                            json.objectiveOccurence @Namespace.json_map(hObjective[:occurrences], Event) unless hObjective[:occurrences].empty?
                            json.pass @Namespace.json_map(hObjective[:passes], Pass) unless hObjective[:passes].empty?
                            json.sensingInstrument @Namespace.json_map(hObjective[:instruments], Instrument) unless hObjective[:instruments].empty?
                        end

                    end
                end # Objective

            end
        end
    end
end
