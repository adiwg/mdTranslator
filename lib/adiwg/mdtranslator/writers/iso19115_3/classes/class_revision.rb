require_relative 'class_responsibility'
require_relative 'class_gcoDateTime'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_3

                class MI_Revision
                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hRevision)

                        responsibilityClass = CI_Responsibility.new(@xml, @hResponseObj)
                        gcoDateTimeClass = GcoDateTime.new(@xml, @hResponseObj)

                        @xml.tag!('mac:MI_Revision') do
                            unless hRevision[:description].nil?
                                @xml.tag!('mac:description') do
                                    @xml.tag!('gco:CharacterString', hRevision[:description])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:description')
                                end
                            end

                            unless hRevision[:responsibleParty].empty?
                                @xml.tag!('mac:author') do
                                    responsibilityClass.writeXML(hRevision[:responsibleParty])
                                end
                            else
                                @xml.tag!('mac:author')
                            end

                            unless hRevision[:dateInfo].empty?
                                @xml.tag!('mac:dateInfo') do
                                    hRevision[:dateInfo].each do |hDate|
                                        gcoDateTimeClass.writeXML(hDate)
                                    end
                                end
                            else
                                @xml.tag!('mac:dateInfo')
                            end
                        end
                    end
                end

            end
        end
    end
end
