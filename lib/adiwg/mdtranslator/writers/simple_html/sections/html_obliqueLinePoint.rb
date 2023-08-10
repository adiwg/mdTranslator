# HTML writer
# spatial reference system oblique line point

# History:
#  Stan Smith 2017-10-24 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_ObliqueLinePoint

               def writeHtml(hLinePoint)

                  long = 'missing'
                  lat = 'missing'

                  # oblique line point - point latitude
                  unless hLinePoint[:obliqueLineLatitude].nil?
                     long = hLinePoint[:obliqueLineLatitude].to_s
                  end

                  # oblique line point - point longitude
                  unless hLinePoint[:obliqueLineLongitude].nil?
                     lat = hLinePoint[:obliqueLineLongitude].to_s
                  end

                  return '( Longitude: ' + long + ', Latitude: ' + lat + ' )'

               end # writeHtml
            end # Html_ObliqueLinePoint

         end
      end
   end
end
