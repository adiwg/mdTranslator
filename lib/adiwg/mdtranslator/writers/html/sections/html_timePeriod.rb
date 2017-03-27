# HTML writer
# time period

# History:
#  Stan Smith 2017-03-26 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-23 original script

require_relative 'html_datetime'
require_relative 'html_identifier'

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

                  # time period - id
                  unless hPeriod[:timeId].nil?
                     @html.em('Period ID: ')
                     @html.text!(hPeriod[:timeId])
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

                  # time period - instant name []
                  hPeriod[:periodNames].each do |iName|
                     @html.em('Period Name: ')
                     @html.text!(iName)
                     @html.br
                  end

                  # time period - time interval
                  # TODO time interval

                  # time period - duration
                  # TODO duration

               end # writeHtml
            end # Html_TimePeriod

         end
      end
   end
end
