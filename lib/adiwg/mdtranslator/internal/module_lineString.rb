# unpack line string
# line string is coded in GeoJSON
module ADIWG
    module Mdtranslator
        module LineString
            def self.unpack(aCoords, geoType, _responseObj)
                intMetadataClass = InternalMetadata.new
                intLine = intMetadataClass.newGeometry

                intLine[:geoType] = geoType
                intLine[:geometry] = aCoords
                intLine[:dimension] = AdiwgCoordinates.getDimension(aCoords)

                intLine
            end
        end
    end
end
