# sbJson 1.0 writer spatial

# History:
#  Stan Smith 2017-06-01 original script

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Spatial

               def self.build(aExtents)

                  spatial = {}
                  aBoxObjects = []

                  aExtents.each do |hExtent|
                     hExtent[:geographicExtents].each do |hGeoExtent|
                        hBbox = hGeoExtent[:computedBbox]
                        sw = [ hBbox[:westLongitude], hBbox[:southLatitude] ]
                        nw = [ hBbox[:westLongitude], hBbox[:northLatitude] ]
                        ne = [ hBbox[:eastLongitude], hBbox[:northLatitude] ]
                        se = [ hBbox[:eastLongitude], hBbox[:southLatitude] ]
                        aPoly = [ sw, nw, ne, se ]
                        geoJson = {
                           type: 'Polygon',
                           coordinates: [
                              aPoly
                           ]
                        }
                        aBoxObjects << geoJson
                     end
                  end

                  unless aBoxObjects.empty?
                     hBox = AdiwgCoordinates.computeBbox(aBoxObjects)
                     sbBox = {}
                     sbBox[:maxY] = hBox[:northLatitude]
                     sbBox[:minY] = hBox[:southLatitude]
                     sbBox[:maxX] = hBox[:eastLongitude]
                     sbBox[:minX] = hBox[:westLongitude]
                     spatial[:boundingBox] = sbBox
                  end

                  # representational point is not computed

                  spatial

               end

            end

         end
      end
   end
end
