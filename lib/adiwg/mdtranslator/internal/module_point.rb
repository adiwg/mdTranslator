# unpack point
# point is coded in GeoJSON
module ADIWG
    module Mdtranslator
        module Point
            def self.unpack(aCoords, geoType, _responseObj)
                intMetadataClass = InternalMetadata.new
                intPoint = intMetadataClass.newGeometry

                intPoint[:geoType] = geoType
                intPoint[:geometry] = aCoords
                intPoint[:dimension] = AdiwgCoordinates.getDimension(aCoords)

                intPoint
            end
        end
    end
end
