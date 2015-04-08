# HTML writer
# time instant

# History:
# 	Stan Smith 2015-04-03 original script

require 'html_dateTime'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlTimeInstant
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hTimeInstant)

                        # classes used
                        htmlDT = $HtmlNS::MdHtmlDateTime.new(@html)

                        # time instant - id
                        s = hTimeInstant[:timeId]
                        if !s.nil?
                            @html.em('Time ID: ')
                            @html.text!(s)
                            @html.br
                        end

                        # time instant - description
                        s = hTimeInstant[:description]
                        if !s.nil?
                            @html.em('Description: ')
                            @html.section(:class=>'block') do
                                @html.text!(s)
                            end
                        end

                        # time instant - time instant - dateTime - required
                        hDatetime = hTimeInstant[:timePosition]
                        if !hDatetime.empty?
                            @html.em('DateTime: ')
                            htmlDT.writeHtml(hDatetime)
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
