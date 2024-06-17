require_relative 'class_identifier'
require_relative 'class_codelist'
require_relative 'class_extent'
require_relative 'class_event'
require_relative 'class_pass'
require_relative 'class_instrument'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_3

                class MI_Objective
                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hObjective)

                        identifierClass = MD_Identifier.new(@xml, @hResponseObj)
                        codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                        extentClass = EX_Extent.new(@xml, @hResponseObj)
                        eventClass = MI_Event.new(@xml, @hResponseObj)
                        passClass = MI_Pass.new(@xml, @hResponseObj)
                        instrumentClass = MI_Instrument.new(@xml, @hResponseObj)

                        @xml.tag!('mac:MI_Objective', id: hObjective[:objectiveId]) do
                            unless hObjective[:identifiers].empty?
                                hObjective[:identifiers].each do |hIdentifier|
                                    @xml.tag!('mac:identifier') do
                                        identifierClass.writeXML(hIdentifier)
                                    end
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:identifier')
                                end
                            end

                            unless hObjective[:priority].nil?
                                @xml.tag!('mac:priority') do
                                    @xml.tag!('gco:CharacterString', hObjective[:priority])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:priority')
                                end
                            end

                            unless hObjective[:type].nil?
                                @xml.tag!('mac:type') do
                                    codelistClass.writeXML('mac', 'iso_objectiveTypeCode', hObjective[:type])
                                end
                            else
                                @xml.tag!('mac:type')
                            end

                            unless hObjective[:function].nil?
                                @xml.tag!('mac:function') do
                                    @xml.tag!('gco:CharacterString', hObjective[:function])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:function')
                                end
                            end

                            unless hObjective[:extent].nil?
                                @xml.tag!('mac:extent') do
                                    extentClass.writeXML(hObjective[:extent])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:extent')
                                end
                            end

                            unless hObjective[:occurrences].empty?
                                hObjective[:occurrences].each do |hOccurrence|
                                    @xml.tag!('mac:occurrence') do
                                        eventClass.writeXML(hOccurrence)
                                    end
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:occurrence')
                                end
                            end

                            unless hObjective[:passes].empty?
                                hObjective[:passes].each do |hPass|
                                    @xml.tag!('mac:pass') do
                                        passClass.writeXML(hPass)
                                    end
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:pass')
                                end
                            end

                            unless hObjective[:sensingInstruments].empty?
                                hObjective[:sensingInstruments].each do |hInstrument|
                                    @xml.tag!('mac:sensingInstrument') do
                                        instrumentClass.writeXML(hInstrument)
                                    end
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:sensingInstrument')
                                end
                            end
                        end
                    end

                end
            end
        end
    end
end
