# HTML writer
# geographic resolution

# History:
#  Stan Smith 2017-10-20 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_GeographicResolution

               def initialize(html)
                  @html = html
               end

               def writeHtml(hGeoRes)

                  # geographic resolution - latitude resolution
                  unless hGeoRes[:latitudeResolution].nil?
                     @html.em('Latitude Resolution: ')
                     @html.text!(hGeoRes[:latitudeResolution].to_s)
                     @html.br
                  end

                  # geographic resolution - longitude resolution
                  unless hGeoRes[:longitudeResolution].nil?
                     @html.em('Longitude Resolution: ')
                     @html.text!(hGeoRes[:longitudeResolution].to_s)
                     @html.br
                  end

                  # geographic resolution - unit of measure
                  unless hGeoRes[:unitOfMeasure].nil?
                     @html.em('Units of Measure: ')
                     @html.text!(hGeoRes[:unitOfMeasure])
                     @html.br
                  end

               end # writeHtml
            end # Html_GeographicResolution

         end
      end
   end
end
