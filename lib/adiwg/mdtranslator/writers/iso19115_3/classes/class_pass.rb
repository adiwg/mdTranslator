require_relative 'class_identifier'
require_relative 'class_extent'
require_relative 'class_event'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_3

                class MI_Pass
                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hPass)

                        identifierClass = MD_Identifier.new(@xml, @hResponseObj)                        
                        extentClass = EX_Extent.new(@xml, @hResponseObj)
                        eventClass = MI_Event.new(@xml, @hResponseObj)

                        @xml.tag!('mac:MI_Pass') do

                            unless hPass[:identifier].empty?
                                @xml.tag!('mac:identifier') do
                                    identifierClass.writeXML(hPass[:identifier])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:identifier')
                                end
                            end

                            unless hPass[:extent].empty?
                                @xml.tag!('mac:extent') do
                                    extentClass.writeXML(hPass[:extent])
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:extent')
                                end
                            end

                            unless hPass[:relatedEvents].empty?
                                hPass[:relatedEvents].each do |hEvent|
                                    @xml.tag!('mac:relatedEvent') do
                                        eventClass.writeXML(hEvent)
                                    end
                                end
                            else
                                if @hResponseObj[:writerShowTags]
                                    @xml.tag!('mac:related')
                                end
                            end
                        end

                    end
                end
            end

        end
    end
end
