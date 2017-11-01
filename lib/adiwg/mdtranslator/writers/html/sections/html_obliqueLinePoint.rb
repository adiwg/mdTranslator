# HTML writer
# spatial reference system oblique line point

# History:
#  Stan Smith 2017-10-24 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_ObliqueLinePoint

               def writeHtml(hLinePoint)

                  long = 'missing'
                  lat = 'missing'

                  # oblique line point - point latitude
                  unless hLinePoint[:azimuthLineLatitude].nil?
                     long = hLinePoint[:azimuthLineLatitude].to_s
                  end

                  # oblique line point - point longitude
                  unless hLinePoint[:azimuthLineLongitude].nil?
                     lat = hLinePoint[:azimuthLineLongitude].to_s
                  end

                  return '( Longitude: ' + long + ', Latitude: ' + lat + ' )'

               end # writeHtml
            end # Html_ObliqueLinePoint

         end
      end
   end
end
