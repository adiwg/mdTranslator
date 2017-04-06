# HTML writer
# temporal extent

# History:
#  Stan Smith 2017-03-25 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-04-03 original script

require_relative 'html_datetime'
require_relative 'html_timePeriod'
require_relative 'html_timeInstant'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_TemporalExtent

               def initialize(html)
                  @html = html
               end

               def writeHtml(hExtent)

                  # classes used
                  datetimeClass = Html_Datetime.new(@html)
                  periodClass = Html_TimePeriod.new(@html)
                  instantClass = Html_TimeInstant.new(@html)

                  # temporal element - time instant {timeInstant}
                  unless hExtent[:timeInstant].empty?
                     @html.details do
                        dateStr = datetimeClass.writeHtml(hExtent[:timeInstant][:timeInstant])
                        @html.summary('Time ' +  dateStr + ' ', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           instantClass.writeHtml(hExtent[:timeInstant])
                        end
                     end
                  end

                  # temporal element - time period {timePeriod}
                  unless hExtent[:timePeriod].empty?
                     startStr = datetimeClass.writeHtml(hExtent[:timePeriod][:startDateTime])
                     endStr = datetimeClass.writeHtml(hExtent[:timePeriod][:endDateTime])
                     @html.details do
                        if startStr == ''
                           @html.summary('Period Ending ' + endStr, 'class' => 'h5')
                        elsif endStr == ''
                           @html.summary('Period Beginning ' + startStr, 'class' => 'h5')
                        else
                           @html.summary('Period ' + startStr + ' to ' + endStr, 'class' => 'h5')
                        end
                        @html.section(:class => 'block') do
                           periodClass.writeHtml(hExtent[:timePeriod])
                        end
                     end
                  end

               end # writeHtml
            end # Html_TemporalExtent

         end
      end
   end
end
