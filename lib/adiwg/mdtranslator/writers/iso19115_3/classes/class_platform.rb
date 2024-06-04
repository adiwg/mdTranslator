require_relative 'class_citation'
require_relative 'class_identifier'
require_relative 'class_responsibility'
require_relative 'class_instrument'
require_relative 'class_instrumentationEventList'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_3

                class MI_Platform
                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hPlatform)

                        codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                        citationClass = CI_Citation.new(@xml, @hResponseObj)
                        identifierClass = MD_Identifier.new(@xml, @hResponseObj)
                        responsibilityClass = CI_Responsibility.new(@xml, @hResponseObj)
                        instrumentClass = MI_Instrument.new(@xml, @hResponseObj)
                        instrumentationEventListClass = MI_InstrumentationEventList.new(@xml, @hResponseObj)

                        @xml.tag!('mac:MI_Platform', id: hPlatform[:platformId]) do

                            unless hPlatform[:citation].empty?
                                @xml.tag!('mac:citation') do
                                    citationClass.writeXML(hPlatform[:citation])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:citation')
                                end
                            end

                            unless hPlatform[:identifier].empty?
                                @xml.tag!('mac:identifier') do
                                    identifierClass.writeXML(hPlatform[:identifier])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:identifier')
                                end
                            end

                            unless hPlatform[:description].nil?
                                @xml.tag!('mac:description') do
                                    @xml.tag!('gco:CharacterString', hPlatform[:description])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:description')
                                end
                            end

                            unless hPlatform[:sponsors].empty?
                                hPlatform[:sponsors].each do |hResponsibility|
                                    @xml.tag!('mac:sponsor') do
                                        responsibilityClass.writeXML(hResponsibility)
                                    end
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:sponsor')
                                end
                            end

                            unless hPlatform[:instruments].empty?
                                hPlatform[:instruments].each do |hInstrument|
                                    @xml.tag!('mac:instrument') do
                                        instrumentClass.writeXML(hInstrument)
                                    end
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:instrument')
                                end
                            end

                            unless hPlatform[:history].empty?
                                @xml.tag!('mac:history') do
                                    hPlatform[:history].each do |history|
                                        instrumentationEventListClass.writeXML(history)
                                    end
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:history')
                                end
                            end

                        end
                    end

                end
            end
        end
    end
end