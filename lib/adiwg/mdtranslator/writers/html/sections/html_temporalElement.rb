# HTML writer
# temporal element

# History:
# 	Stan Smith 2015-04-03 original script

require 'html_dateTime'
require 'html_timePeriod'
require 'html_timeInstant'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlTemporalElement
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hTempEle)

                        # classes used
                        htmlDT = $HtmlNS::MdHtmlDateTime.new(@html)
                        htmlTimeP = $HtmlNS::MdHtmlTimePeriod.new(@html)
                        htmlTimeI = $HtmlNS::MdHtmlTimeInstant.new(@html)

                        # temporal element - date
                        hDatetime = hTempEle[:date]
                        if !hDatetime.empty?
                            @html.em('Date: ')
                            htmlDT.writeHtml(hDatetime)
                        end

                        # temporal element - time instant
                        hTimeInstant = hTempEle[:timeInstant]
                        if !hTimeInstant.empty?
                            @html.em('Time instant: ')
                            @html.blockquote do
                                htmlTimeI.writeHtml(hTimeInstant)
                            end
                        end

                        # temporal element - time period
                        hTimePeriod = hTempEle[:timePeriod]
                        if !hTimePeriod.empty?
                            @html.em('Time period: ')
                            @html.blockquote do
                                htmlTimeP.writeHtml(hTimePeriod)
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
