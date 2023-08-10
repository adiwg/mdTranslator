# HTML writer
# bounding box

# History:
#  Stan Smith 2017-04-06 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_BoundingBox

               def initialize(html)
                  @html = html
               end

               def writeHtml(hBox)

                  # bounding box - edges
                  unless hBox[:westLongitude].nil?
                     @html.em('West Longitude:')
                     @html.text!(hBox[:westLongitude].to_s)
                     @html.br
                  end

                  unless hBox[:eastLongitude].nil?
                     @html.em('East Longitude:')
                     @html.text!(hBox[:eastLongitude].to_s)
                     @html.br
                  end

                  unless hBox[:southLatitude].nil?
                     @html.em('South Latitude:')
                     @html.text!(hBox[:southLatitude].to_s)
                     @html.br
                  end

                  unless hBox[:northLatitude].nil?
                     @html.em('North Latitude:')
                     @html.text!(hBox[:northLatitude].to_s)
                     @html.br
                  end

                  unless hBox[:minimumAltitude].nil?
                     @html.em('Minimum Altitude:')
                     @html.text!(hBox[:minimumAltitude].to_s)
                     @html.br
                  end

                  unless hBox[:maximumAltitude].nil?
                     @html.em('Maximum Altitude:')
                     @html.text!(hBox[:maximumAltitude].to_s)
                     @html.br
                  end

                  unless hBox[:unitsOfAltitude].nil?
                     @html.em('Altitude Units of Measure:')
                     @html.text!(hBox[:unitsOfAltitude].to_s)
                     @html.br
                  end

               end # writeHtml
            end # Html_BoundingBox

         end
      end
   end
end
