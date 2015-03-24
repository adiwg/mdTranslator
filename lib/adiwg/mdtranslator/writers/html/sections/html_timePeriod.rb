# HTML writer
# time period

# History:
# 	Stan Smith 2015-03-23 original script

require 'html_dateTime'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlTimePeriod
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hTimePeriod)

                        # classes used
                        htmlDateTime = $HtmlNS::MdHtmlDateTime.new(@html)

                        # timePeriod - id
                        s = hTimePeriod[:timeId]
                        if !s.nil?
                            @html.em('ID: ')
                            @html.text!(s)
                            @html.br
                        end

                        # timePeriod - description
                        s = hTimePeriod[:description]
                        if !s.nil?
                            @html.em('Description: ')
                            @html.text!(s)
                            @html.br
                        end

                        # timePeriod - begin time
                        if !hTimePeriod[:beginTime].empty?
                            @html.em('Begin dateTime: ')
                            htmlDateTime.writeHtml(hTimePeriod[:beginTime])
                        end

                        # timePeriod - end time
                        if !hTimePeriod[:endTime].empty?
                            @html.em('End dateTime: ')
                            htmlDateTime.writeHtml(hTimePeriod[:endTime])
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
