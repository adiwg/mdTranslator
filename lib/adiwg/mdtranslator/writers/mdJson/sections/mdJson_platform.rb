require 'jbuilder'
require_relative 'mdJson_citation'
require_relative 'mdJson_identifier'
require_relative 'mdJson_responsibleParty'
require_relative 'mdJson_instrument'
require_relative 'mdJson_instrumentationEventList'

module ADIWG
    module Mdtranslator
        module Writers
            module MdJson

                module Platform

                    @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                    def self.build(hPlatform)

                        Jbuilder.new do |json|
                            json.platformId hPlatform[:platformId]
                            json.citation Citation.build(hPlatform[:citation]) unless hPlatform[:citation].empty?
                            json.identifier Identifier.build(hPlatform[:identifier])
                            json.description hPlatform[:description]
                            json.sponsor @Namespace.json_map(hPlatform[:sponsors], ResponsibleParty) unless hPlatform[:sponsors].empty?
                            json.instrument @Namespace.json_map(hPlatform[:instruments], Instrument)
                            json.history @Namespace.json_map(hPlatform[:history], InstrumentationEventList) unless hPlatform[:history].empty?
                        end

                    end
                end # Platform

            end
        end
    end
end
