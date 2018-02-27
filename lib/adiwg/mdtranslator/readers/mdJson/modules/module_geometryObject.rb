# unpack geometry object
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-18 refactored error and warning messaging
#  Stan Smith 2016-10-24 original script

require_relative 'module_geometryCollection'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module GeometryObject

               def self.unpack(hGeoObject, responseObj)

                  # return nil object if input is empty
                  if hGeoObject.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: GeoJSON geometry object is empty'
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
                           responseObj[:readerExecutionMessages] <<
                              'ERROR: mdJson GeoJSON geometry object type must be Point, LineString, Polygon, MultiPoint, MultiLineString, or MultiPolygon'
                           responseObj[:readerExecutionPass] = false
                           return nil
                        end
                     end
                  end
                  if intGeoObject[:type].nil? || intGeoObject[:type] == ''
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson GeoJSON geometry object type is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # geometry object - coordinates (required)
                  if hGeoObject.has_key?('coordinates')
                     intGeoObject[:coordinates] = hGeoObject['coordinates']
                  end
                  if intGeoObject[:coordinates].empty?
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson GeoJSON geometry object coordinates are missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
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
