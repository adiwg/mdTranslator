# sbJson 1.0 writer geographic extent

# History:
#  Stan Smith 2017-06-06 original script

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module GeographicExtent

               def self.build(aExtents)

                  aGeoExtents = []

                  # gather geographicExtents geoJson blocks
                  aExtents.each do |hExtent|
                     hExtent[:geographicExtents].each do |hGeoExtent|
                        aGeoExtents << hGeoExtent[:nativeGeoJson]
                     end
                  end

                  aGeoExtents

               end

            end

         end
      end
   end
end
