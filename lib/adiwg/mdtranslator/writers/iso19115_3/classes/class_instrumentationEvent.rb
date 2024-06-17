require_relative 'class_citation'
require_relative 'class_extent'
require_relative 'class_revision'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_3

                class MI_InstrumentationEvent
                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hInstrumentationEvent)

                        citationClass = CI_Citation.new(@xml, @hResponseObj)
                        extentClass = EX_Extent.new(@xml, @hResponseObj)
                        revisionClass = MI_Revision.new(@xml, @hResponseObj)
                        codeListClass = MD_Codelist.new(@xml, @hResponseObj)

                        @xml.tag!('mac:MI_InstrumentationEvent') do
                            unless hInstrumentationEvent[:citations].empty?
                                hInstrumentationEvent[:citations].each do |hCitation|
                                    @xml.tag!('mac:citation') do
                                        citationClass.writeXML(hCitation)
                                    end
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:citation')
                                end
                            end

                            unless hInstrumentationEvent[:description].nil?
                                @xml.tag!('mac:description') do
                                    @xml.tag!('gco:CharacterString', hInstrumentationEvent[:description])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:description')
                                end
                            end

                            unless hInstrumentationEvent[:extent].empty?
                                @xml.tag!('mac:extent') do
                                    extentClass.writeXML(hInstrumentationEvent[:extent])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:extent')
                                end
                            end

                            unless hInstrumentationEvent[:eventType].nil?
                                @xml.tag!('mac:type') do
                                    codeListClass.writeXML('mac', 'iso_eventTypeCode', hInstrumentationEvent[:eventType])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:type')
                                end
                            end

                            unless hInstrumentationEvent[:revisionHistories].empty?
                                hInstrumentationEvent[:revisionHistories].each do |hRevision|
                                    @xml.tag!('mac:revisionHistory') do
                                        revisionClass.writeXML(hRevision)
                                    end
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:revisionHistory')
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
