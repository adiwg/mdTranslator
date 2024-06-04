module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_3

                class MI_RequestedDate
                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hRequestedDate)

                        gcoDateTimeClass = GcoDateTime.new(@xml, @hResponseObj)

                        unless hRequestedDate[:requestedDateOfCollection].empty?
                            @xml.tag!('mac:requestedDateOfCollection') do
                                gcoDateTimeClass.writeXML(hRequestedDate[:requestedDateOfCollection])
                            end
                        else
                            if @hResponseObj[:writerShowTags]
                                @xml.tag!('mac:requestedDateOfCollection')
                            end
                        end

                        unless hRequestedDate[:latestAcceptableDate].empty?
                            @xml.tag!('mac:latestAcceptableDate') do
                                gcoDateTimeClass.writeXML(hRequestedDate[:latestAcceptableDate])
                            end
                        else
                            if @hResponseObj[:writerShowTags]
                                @xml.tag!('mac:latestAcceptableDate')
                            end
                        end
                    end
                end
            end
        end
    end
end

                    