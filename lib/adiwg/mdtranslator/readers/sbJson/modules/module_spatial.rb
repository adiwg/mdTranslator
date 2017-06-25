# unpack spatial
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-25 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Spatial

               def self.unpack(hSbJson, hResourceInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  if hSbJson.has_key?('spatial')
                     unless hSbJson['spatial'].empty?
                        # representational point is not mapped
                        # map bounding box
                        if hSbJson['spatial'].has_key?('boundingBox')
                           hSbBbox = hSbJson['spatial']['boundingBox']
                           unless hSbBbox.empty?

                              hExtent = intMetadataClass.newExtent
                              hGeoExtent = intMetadataClass.newGeographicExtent
                              hBbox = intMetadataClass.newBoundingBox

                              hBbox[:westLongitude] = hSbBbox['minX']
                              hBbox[:eastLongitude] = hSbBbox['maxX']
                              hBbox[:southLatitude] = hSbBbox['minY']
                              hBbox[:northLatitude] = hSbBbox['maxY']

                              hGeoExtent[:boundingBox] = hBbox
                              hExtent[:geographicExtents] << hGeoExtent
                              hResourceInfo[:extents] << hExtent

                           end
                        end
                     end
                  end

                  return hResourceInfo

               end

            end

         end
      end
   end
end
