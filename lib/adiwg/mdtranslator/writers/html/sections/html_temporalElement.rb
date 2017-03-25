# HTML writer
# temporal element

# History:
# 	Stan Smith 2015-04-03 original script
#   Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS

require_relative 'html_date'
require_relative 'html_timePeriod'
require_relative 'html_timeInstant'

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
                        htmlDT = MdHtmlDateTime.new(@html)
                        htmlTimeP = MdHtmlTimePeriod.new(@html)
                        htmlTimeI = MdHtmlTimeInstant.new(@html)

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
                            @html.section(:class=>'block') do
                                htmlTimeI.writeHtml(hTimeInstant)
                            end
                        end

                        # temporal element - time period
                        hTimePeriod = hTempEle[:timePeriod]
                        if !hTimePeriod.empty?
                            @html.em('Time period: ')
                            @html.section(:class=>'block') do
                                htmlTimeP.writeHtml(hTimePeriod)
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
