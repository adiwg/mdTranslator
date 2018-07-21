# unpack geometry collection
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-20 refactored error and warning messaging
#  Stan Smith 2016-11-11 added computedBbox computation
#  Stan Smith 2016-10-25 original script

require 'adiwg/mdtranslator/internal/module_coordinates'
require_relative 'module_geoJson'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module GeometryCollection

               def self.unpack(hGeoCol, responseObj)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hGeoCol.empty?
                     @MessagePath.issueWarning(360, responseObj)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intGeoCol = intMetadataClass.newGeometryCollection

                  # geometry collection - type (required)
                  if hGeoCol.has_key?('type')
                     if hGeoCol['type'] != ''
                        if hGeoCol['type'] == 'GeometryCollection'
                           intGeoCol[:type] = hGeoCol['type']
                        else
                           @MessagePath.issueError(361, responseObj)
                        end
                     end
                  end
                  if intGeoCol[:type].nil? || intGeoCol[:type] == ''
                     @MessagePath.issueError(362, responseObj)
                  end

                  # geometry collection - bounding box
                  if hGeoCol.has_key?('bbox')
                     unless hGeoCol['bbox'].empty?
                        intGeoCol[:bbox] = hGeoCol['bbox']
                     end
                  end

                  # geometry collection - geometries (required, but can be empty)
                  if hGeoCol.has_key?('geometries')
                     hGeoCol['geometries'].each do |hGeometry|
                        hReturn = GeoJson.unpack(hGeometry, responseObj)
                        unless hReturn.nil?
                           intGeoCol[:geometryObjects] << hReturn
                        end
                     end
                  else
                     @MessagePath.issueError(363, responseObj)
                  end

                  # geometry collection - compute bbox for geometry collection
                  unless intGeoCol[:geometryObjects].empty?
                     intGeoCol[:computedBbox] = AdiwgCoordinates.computeBbox(intGeoCol[:geometryObjects])
                  end

                  # geometry collection - save GeoJSON for the collection
                  intGeoCol[:nativeGeoJson] = hGeoCol

                  return intGeoCol

               end

            end

         end
      end
   end
end
