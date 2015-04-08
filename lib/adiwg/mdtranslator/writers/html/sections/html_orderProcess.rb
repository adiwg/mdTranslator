# HTML writer
# order process

# History:
# 	Stan Smith 2015-03-27 original script

require 'html_dateTime'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlOrderProcess
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hOrder)

                        # classes used
                        htmlDateTime = $HtmlNS::MdHtmlDateTime.new(@html)

                        # order process - order instructions
                        s = hOrder[:orderInstructions]
                        if !s.nil?
                            @html.em('Order instructions: ')
                            @html.section(:class=>'block') do
                                @html.text!(s)
                            end
                        end

                        # order process - fees
                        s = hOrder[:fees]
                        if !s.nil?
                            @html.em('Fees: ')
                            @html.text!(s)
                            @html.br
                        end

                        # order process - turnaround
                        s = hOrder[:turnaround]
                        if !s.nil?
                            @html.em('Turnaround: ')
                            @html.text!(s)
                            @html.br
                        end

                        # order process - planned dateTime
                        hDatetime = hOrder[:plannedDateTime]
                        if !hDatetime.empty?
                            @html.em('Planned Availability: ')
                            htmlDateTime.writeHtml(hDatetime)
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
