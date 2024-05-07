require 'jbuilder'
require_relative 'mdJson_identifier'
require_relative 'mdJson_extent'
require_relative 'mdJson_event'

module ADIWG
    module Mdtranslator
        module Writers
            module MdJson

                module Pass

                    @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                    def self.build(hPass)

                        Jbuilder.new do |json|
                            json.passId hPass[:passId]
                            json.identifier Identifier.build(hPass[:identifier])
                            json.extent Extent.build(hPass[:extent]) unless hPass[:extent].empty?
                            json.relatedEvent @Namespace.json_map(hPass[:relatedEvents], Event) unless hPass[:relatedEvents].empty?
                        end

                    end
                end # Pass

            end
        end
    end
end
