require_relative 'class_citation'
require_relative 'class_identifier'
require_relative 'class_platform'
require_relative 'class_instrumentationEventList'


module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_3

                class MI_Instrument
                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hInstrument)

                        citationClass = CI_Citation.new(@xml, @hResponseObj)
                        identifierClass = MD_Identifier.new(@xml, @hResponseObj)
                        platformClass = MI_Platform.new(@xml, @hResponseObj)
                        instrumentationEventListClass = MI_InstrumentationEventList.new(@xml, @hResponseObj)

                        @xml.tag!('mac:MI_Instrument', id: hInstrument[:instrumentId]) do
                            unless hInstrument[:citation].empty?
                                @xml.tag!('mac:citation') do
                                    citationClass.writeXML(hInstrument[:citation])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:citation')
                                end
                            end

                            unless hInstrument[:identifier].empty?
                                @xml.tag!('mac:identifier') do
                                    identifierClass.writeXML(hInstrument[:identifier])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:identifier')
                                end
                            end

                            unless hInstrument[:instrumentType].empty?
                                @xml.tag!('mac:type') do
                                    @xml.tag!('gco:CharacterString', hInstrument[:instrumentType])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:type')
                                end
                            end

                            unless hInstrument[:description].nil?
                                @xml.tag!('mac:description') do
                                    @xml.tag!('gco:CharacterString', hInstrument[:description])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:description')
                                end
                            end

                            unless hInstrument[:mountedOn].empty?
                                @xml.tag!('mac:mountedOn') do
                                    platformClass.writeXML(hInstrument[:mountedOn])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:mountedOn')
                                end
                            end

                            unless hInstrument[:histories].empty?
                                @xml.tag!('mac:history') do
                                    hInstrument[:histories].each do |history|
                                        instrumentationEventListClass.writeXML(history)
                                    end
                                end
                            end

                        end
                        
                    end
                end
            end
        end
    end
end

