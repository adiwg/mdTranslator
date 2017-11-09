# HTML writer
# temporal extent

# History:
#  Stan Smith 2017-11-09 remove subheadings
#  Stan Smith 2017-11-09 add geologic age
#  Stan Smith 2017-03-25 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-04-03 original script

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
                  periodClass = Html_TimePeriod.new(@html)
                  instantClass = Html_TimeInstant.new(@html)

                  # temporal element - time instant {timeInstant}
                  unless hExtent[:timeInstant].empty?
                     hInstant = hExtent[:timeInstant][:timeInstant]
                     hGeoAge = hExtent[:timeInstant][:geologicAge]
                     unless hInstant.empty?
                        @html.h5('Time Instant')
                     end
                     unless hGeoAge.empty?
                        @html.h5('Geologic Age')
                     end
                     instantClass.writeHtml(hExtent[:timeInstant])
                  end

                  # temporal element - time period {timePeriod}
                  unless hExtent[:timePeriod].empty?
                     hStartDate = hExtent[:timePeriod][:startDateTime]
                     hEndDate = hExtent[:timePeriod][:endDateTime]
                     hStartAge = hExtent[:timePeriod][:startGeologicAge]
                     hEndAge = hExtent[:timePeriod][:endGeologicAge]
                     unless hStartDate.empty? && hEndDate.empty?
                        @html.h5('Time Period')
                     end
                     unless hStartAge.empty? && hEndAge.empty?
                        @html.h5('Geologic Period')
                     end
                     periodClass.writeHtml(hExtent[:timePeriod])
                  end

               end # writeHtml
            end # Html_TemporalExtent

         end
      end
   end
end
