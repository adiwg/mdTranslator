# unpack geometry object
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-24 original script

require_relative 'module_geometryCollection'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module GeometryObject

                    def self.unpack(hGeoObject, responseObj)

                        # return nil object if input is empty
                        if hGeoObject.empty?
                            responseObj[:readerExecutionMessages] << 'Associated Resource object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intGeoObject = intMetadataClass.newGeometryObject

                        # geometry object - type (required)
                        if hGeoObject.has_key?('type')
                            if hGeoObject['type'] != ''
                                type = hGeoObject['type']
                                if %w{ Point LineString Polygon MultiPoint MultiLineString MultiPolygon }.one? { |word| word == type }
                                    intGeoObject[:type] = hGeoObject['type']
                                else
                                    responseObj[:readerExecutionMessages] << 'Geometry Object type must be Point, LineString, Polygon, MultiPoint, MultiLineString, or MultiPolygon'
                                    responseObj[:readerExecutionPass] = false
                                    return nil
                                end
                            end
                        end
                        if intGeoObject[:type].nil? || intGeoObject[:type] == ''
                            responseObj[:readerExecutionMessages] << 'Geometry Object is missing type'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # geometry object - coordinates (required)
                        if hGeoObject.has_key?('coordinates')
                            intGeoObject[:coordinates] = hGeoObject['coordinates']
                        end
                        if intGeoObject[:coordinates].empty?
                            responseObj[:readerExecutionMessages] << 'Geometry Object is missing coordinates'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intGeoObject

                    end

                end

            end
        end
    end
end
