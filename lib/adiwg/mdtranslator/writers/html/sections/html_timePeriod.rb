# HTML writer
# time period

# History:
#  Stan Smith 2017-03-26 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-23 original script

require_relative 'html_datetime'
require_relative 'html_identifier'
require_relative 'html_timeInterval'
require_relative 'html_duration'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_TimePeriod

               def initialize(html)
                  @html = html
               end

               def writeHtml(hPeriod)

                  # classes used
                  datetimeClass = Html_Datetime.new(@html)
                  identifierClass = Html_Identifier.new(@html)
                  intervalClass = Html_TimeInterval.new(@html)
                  durationClass = Html_Duration.new(@html)

                  # time period - id
                  unless hPeriod[:timeId].nil?
                     @html.em('Period ID: ')
                     @html.text!(hPeriod[:timeId])
                     @html.br
                  end

                  # time period - name []
                  hPeriod[:periodNames].each do |iName|
                     @html.em('Period Name: ')
                     @html.text!(iName)
                     @html.br
                  end

                  # time period - start datetime
                  unless hPeriod[:startDateTime].empty?
                     @html.em('Start Datetime: ')
                     @html.text!(datetimeClass.writeHtml(hPeriod[:startDateTime]))
                     @html.br
                  end

                  # time period - end datetime
                  unless hPeriod[:endDateTime].empty?
                     @html.em('End Datetime: ')
                     @html.text!(datetimeClass.writeHtml(hPeriod[:endDateTime]))
                     @html.br
                  end

                  # time period - description
                  unless hPeriod[:description].nil?
                     @html.em('Description: ')
                     @html.section(:class => 'block') do
                        @html.text!(hPeriod[:description])
                     end
                  end

                  # time period - identifier {identifier}
                  unless hPeriod[:identifier].empty?
                     @html.details do
                        @html.summary('Identifier', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           identifierClass.writeHtml(hPeriod[:identifier])
                        end
                     end
                  end

                  # time period - time interval
                  unless hPeriod[:timeInterval].empty?
                     @html.details do
                        @html.summary('Time Interval', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           intervalClass.writeHtml(hPeriod[:timeInterval])
                        end
                     end
                  end

                  # time period - duration
                  unless hPeriod[:duration].empty?
                     @html.details do
                        @html.summary('Duration', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           durationClass.writeHtml(hPeriod[:duration])
                        end
                     end
                  end

               end # writeHtml
            end # Html_TimePeriod

         end
      end
   end
end
