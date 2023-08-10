# HTML writer
# time instant

# History:
#  Stan Smith 2017-11-09 add geologic age
#  Stan Smith 2017-03-26 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-04-03 original script

require_relative 'html_identifier'
require_relative 'html_datetime'
require_relative 'html_geologicAge'

module ADIWG
   module Mdtranslator
      module Writers
         module SimpleHtml

            class Html_TimeInstant

               def initialize(html)
                  @html = html
               end

               def writeHtml(hInstant)

                  # classes used
                  identifierClass = Html_Identifier.new(@html)
                  datetimeClass = Html_Datetime.new(@html)
                  geoAgeClass = Html_GeologicAge.new(@html)

                  # time instant - id
                  unless hInstant[:timeId].nil?
                     @html.em('Instant ID: ')
                     @html.text!(hInstant[:timeId])
                     @html.br
                  end

                  # time instant - instant name []
                  hInstant[:instantNames].each do |iName|
                     @html.em('Instant Name: ')
                     @html.text!(iName)
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
                     @html.div(:class => 'block') do
                        @html.text!(hInstant[:description])
                     end
                  end

                  # time instant - geologic age
                  unless hInstant[:geologicAge].empty?
                     geoAgeClass.writeHtml(hInstant[:geologicAge])
                  end

                  # time instant - identifier {identifier}
                  unless hInstant[:identifier].empty?
                     @html.div do
                        @html.div('Identifier', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           identifierClass.writeHtml(hInstant[:identifier])
                        end
                     end
                  end

               end # writeHtml
            end # Html_TimeInstant

         end
      end
   end
end
