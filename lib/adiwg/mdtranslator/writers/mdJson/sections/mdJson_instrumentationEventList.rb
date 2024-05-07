require 'jbuilder'
require_relative 'mdJson_citation'
require_relative 'mdJson_locale'
require_relative 'mdJson_constraint'
require_relative 'mdJson_instrumentationEvent'

module ADIWG
    module Mdtranslator
        module Writers
            module MdJson

                module InstrumentationEventList

                    @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                    def self.build(hInstrumentationEventList)

                        Jbuilder.new do |json|
                            json.citation @Namespace.json_map(hInstrumentationEventList[:citations], Citation) unless hInstrumentationEventList[:citations].empty?
                            json.description hInstrumentationEventList[:description] 
                            json.locale Locale.build(hInstrumentationEventList[:locale]) unless hInstrumentationEventList[:locale].empty?
                            json.constraints @Namespace.json_map(hInstrumentationEventList[:constraints], Constraint) unless hInstrumentationEventList[:constraints].empty?
                            json.instrumentationEvent @Namespace.json_map(hInstrumentationEventList[:instrumentationEvents], InstrumentationEvent) unless hInstrumentationEventList[:instrumentationEvents].empty?
                        end

                    end
                end # InstrumentationEventList

            end
        end
    end
end
