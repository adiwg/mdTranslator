require_relative 'class_citation'
require_relative 'class_locale'
require_relative 'class_constraint'
require_relative 'class_instrumentationEvent'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_3

                class MI_InstrumentationEventList
                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hInstrumentationEventList)

                        citationClass = CI_Citation.new(@xml, @hResponseObj)
                        localeClass = PT_Locale.new(@xml, @hResponseObj)
                        constraintClass = Constraint.new(@xml, @hResponseObj)
                        instrumentationEventClass = MI_InstrumentationEvent.new(@xml, @hResponseObj)

                        @xml.tag!('mac:MI_InstrumentationEventList') do
                            unless hInstrumentationEventList[:citation].empty?
                                @xml.tag!('mac:citation') do
                                    citationClass.writeXML(hInstrumentationEventList[:citation])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:citation')
                                end
                            end

                            unless hInstrumentationEventList[:description].nil?
                                @xml.tag!('mac:description') do
                                    @xml.tag!('gco:CharacterString', hInstrumentationEventList[:description])
                                end
                            else
                                @xml.tag!('mac:description')
                            end

                            unless hInstrumentationEventList[:locale].empty?
                                @xml.tag!('mac:locale') do
                                    localeClass.writeXML(hInstrumentationEventList[:locale])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:locale')
                                end
                            end

                            unless hInstrumentationEventList[:instrumentationEvents].empty?
                                hInstrumentationEventList[:instrumentationEvents].each do |hEvent|
                                    @xml.tag!('mac:instrumentationEvent') do
                                        instrumentationEventClass.writeXML(hEvent)
                                    end
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:instrumentationEvent')
                                end
                            end
                        end

                    end

                end

            end
        end
    end
end
