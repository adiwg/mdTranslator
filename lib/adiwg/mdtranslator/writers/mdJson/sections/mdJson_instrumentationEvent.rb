require 'jbuilder'
require_relative 'mdJson_citation'
require_relative 'mdJson_revision'

module ADIWG
    module Mdtranslator
        module Writers
            module MdJson

                module InstrumentationEvent

                    @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                    def self.build(hInstrumentationEvent)
                        # "required": ["description","eventType"],
                        Jbuilder.new do |json|
                            json.citation Citation.build(hInstrumentationEvent[:citation]) unless hInstrumentationEvent[:citation].empty?
                            json.description hInstrumentationEvent[:description]
                            json.extent hInstrumentationEvent[:extent] unless hInstrumentationEvent[:extent].empty?
                            json.eventType hInstrumentationEvent[:eventType]
                            json.revisionHistory @Namespace.json_map(hInstrumentationEvent[:revisionHistories], Revision) unless hInstrumentationEvent[:revisionHistories].empty?
                        end

                    end
                end # InstrumentationEvent

            end
        end
    end
end
