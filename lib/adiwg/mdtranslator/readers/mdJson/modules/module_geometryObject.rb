# unpack geometry object
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-20 refactored error and warning messaging
#  Stan Smith 2016-10-24 original script

require_relative 'module_geometryCollection'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module GeometryObject

               def self.unpack(hGeoObject, responseObj)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hGeoObject.empty?
                     @MessagePath.issueWarning(380, responseObj)
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intGeoObject = intMetadataClass.newGeometryObject

                  # geometry object - type (required)
                  if hGeoObject.has_key?('type')
                     unless hGeoObject['type'] == ''
                        type = hGeoObject['type']
                        if %w{ Point LineString Polygon MultiPoint MultiLineString MultiPolygon }.one? {|word| word == type}
                           intGeoObject[:type] = hGeoObject['type']
                        else
                           @MessagePath.issueError(381, responseObj)
                        end
                     end
                  end
                  if intGeoObject[:type].nil? || intGeoObject[:type] == ''
                     @MessagePath.issueError(382, responseObj)
                  end

                  # geometry object - coordinates (required)
                  if hGeoObject.has_key?('coordinates')
                     intGeoObject[:coordinates] = hGeoObject['coordinates']
                  end
                  if intGeoObject[:coordinates].empty?
                     @MessagePath.issueError(383, responseObj)
                  end

                  # geometry object - save native GeoJSON
                  intGeoObject[:nativeGeoJson] = hGeoObject

                  return intGeoObject

               end

            end

         end
      end
   end
end
