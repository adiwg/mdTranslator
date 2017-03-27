# HTML writer
# time instant

# History:
#  Stan Smith 2017-03-26 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-04-03 original script

require_relative 'html_identifier'
require_relative 'html_datetime'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_TimeInstant

               def initialize(html)
                  @html = html
               end

               def writeHtml(hInstant)

                  # classes used
                  identifierClass = Html_Identifier.new(@html)
                  datetimeClass = Html_Datetime.new(@html)

                  # time instant - id
                  unless hInstant[:timeId].nil?
                     @html.em('Instant ID: ')
                     @html.text!(hInstant[:timeId])
                     @html.br
                  end

                  # time instant - dateTime
                  unless hInstant[:timeInstant].empty?
                     @html.em('DateTime: ')
                     @html.text!(datetimeClass.writeHtml(hInstant[:timeInstant]))
                     @html.br
                  end

                  # time instant - description
                  unless hInstant[:description].nil?
                     @html.em('Description: ')
                     @html.section(:class => 'block') do
                        @html.text!(hInstant[:description])
                     end
                  end

                  # time instant - identifier {identifier}
                  unless hInstant[:identifier].empty?
                     @html.details do
                        @html.summary('Identifier', 'class' => 'h5')
                        @html.section(:class => 'block') do
                           identifierClass.writeHtml(hInstant[:identifier])
                        end
                     end
                  end

                  # time instant - instant name []
                  hInstant[:instantNames].each do |iName|
                     @html.em('Instant Name: ')
                     @html.text!(iName)
                     @html.br
                  end

               end # writeHtml
            end # Html_TimeInstant

         end
      end
   end
end
