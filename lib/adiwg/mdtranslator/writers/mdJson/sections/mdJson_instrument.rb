require 'jbuilder'
require_relative 'mdJson_citation'
require_relative 'mdJson_identifier'
require_relative 'mdJson_platform'
require_relative 'mdJson_instrumentationEventList'

module ADIWG
    module Mdtranslator
        module Writers
            module MdJson

                module Instrument

                    @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                    def self.build(hInstrument)
                        
                        Jbuilder.new do |json|
                            json.instrumentId hInstrument[:instrumentId]
                            json.citation Citation.build(hInstrument[:citation]) unless hInstrument[:citation].empty?
                            json.identifier Identifier.build(hInstrument[:identifier])
                            json.instrumentType hInstrument[:instrumentType]
                            json.description hInstrument[:description] unless hInstrument[:description].nil?
                            json.mountedOn Platform.build(hInstrument[:mountedOn]) unless hInstrument[:mountedOn].empty?
                            json.history @Namespace.json_map(hInstrument[:histories], InstrumentationEventList) unless hInstrument[:histories].empty?
                            json.hostId Identifier.build(hInstrument[:hostId]) unless hInstrument[:hostId].empty?
                        end

                    end
                end # Instrument

            end
        end
    end
end
