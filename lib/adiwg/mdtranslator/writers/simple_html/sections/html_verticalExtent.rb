# HTML writer
# vertical extent

# History:
#  Stan Smith 2017-04-04 refactored for mdTranslator 2.0
# 	Stan Smith 2015-04-03 original script

require_relative 'html_spatialReference'

module ADIWG
   module Mdtranslator
      module Writers
         module SimpleHtml

            class Html_VerticalExtent

               def initialize(html)
                  @html = html
               end

               def writeHtml(hExtent)

                  # classes used
                  referenceClass = Html_SpatialReference.new(@html)

                  # vertical extent - description
                  unless hExtent[:description].nil?
                     @html.em('Description: ')
                     @html.div(:class => 'block') do
                        @html.text!(hExtent[:description])
                     end
                  end

                  # vertical extent - min value
                  unless hExtent[:minValue].nil?
                     @html.em('Minimum Value: ')
                     @html.text!(hExtent[:minValue].to_s)
                     @html.br
                  end

                  # vertical extent - max value
                  unless hExtent[:maxValue].nil?
                     @html.em('Maximum Value: ')
                     @html.text!(hExtent[:maxValue].to_s)
                     @html.br
                  end

                  # vertical extent - CRS ID {spatialReference}
                  unless hExtent[:crsId].empty?
                     @html.em('Reference System: ')
                     @html.div(:class => 'block') do
                        referenceClass.writeHtml(hExtent[:crsId])
                     end
                  end

               end # writeHtml
            end # Html_VerticalExtent

         end
      end
   end
end
