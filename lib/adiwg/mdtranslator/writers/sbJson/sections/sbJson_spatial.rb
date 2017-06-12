# sbJson 1.0 writer spatial

# History:
#  Stan Smith 2017-06-01 original script

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Spatial

               def self.build(aExtents)

                  aBoxObjects = []

                  aExtents.each do |hExtent|
                     hExtent[:geographicExtents].each do |hGeoExtent|
                        # use computedBbox if exists
                        # ... this is always exists if geographic extent has objects
                        # otherwise use user provided boundingBox
                        hBbox = {}
                        if hGeoExtent[:computedBbox].empty?
                           unless hGeoExtent[:boundingBox].empty?
                              hBbox = hGeoExtent[:boundingBox]
                           end
                        else
                           hBbox = hGeoExtent[:computedBbox]
                        end

                        # turn the box into a polygon
                        unless hBbox.empty?
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
                  end

                  spatial = {}

                  unless aBoxObjects.empty?
                     hBox = AdiwgCoordinates.computeBbox(aBoxObjects)
                     sbBox = {}

                     # transform to sbJson bbox format
                     sbBox[:maxY] = hBox[:northLatitude]
                     sbBox[:minY] = hBox[:southLatitude]
                     sbBox[:maxX] = hBox[:eastLongitude]
                     sbBox[:minX] = hBox[:westLongitude]
                     spatial[:boundingBox] = sbBox
                  end

                  # sbJson representational point is not provided

                  spatial

               end

            end

         end
      end
   end
end
