# unpack polygon
# point is coded in GeoJSON
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-18 original script
#   Stan Smith 2014-04-30 reorganized for json schema 0.3.0
#   Stan Smith 2014-05-23 modified to handle MultiPolygon objects
#   Stan Smith 2014-07-07 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers

require $ReaderNS.readerModule('module_coordinates')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Polygon

                    def self.unpack(aCoords, geoType)
                        intMetadataClass = InternalMetadata.new
                        intGeometry = intMetadataClass.newGeometry
                        intGeometry[:geoType] = geoType

                        # polygon - coordinate(s)
                        if geoType == 'Polygon'
                            intGeometry[:geometry] = splitPolygons(aCoords)
                            intGeometry[:dimension] = $ReaderNS::Coordinates.getDimension(intGeometry[:geometry][:exteriorRing])
                        elsif geoType == 'MultiPolygon'
                            aPolySets = Array.new
                            aCoords.each do |aPolygonSet|
                                aPolySets << splitPolygons(aPolygonSet)
                            end
                            intGeometry[:geometry] = aPolySets
                        end

                        return intGeometry
                    end

                    def self.splitPolygons(aPolySet)
                        intMetadataClass = InternalMetadata.new
                        intPolygonSet = intMetadataClass.newPolygonSet

                        # first polygon in set is a bounding exterior ring
                        # all subsequent polygons are exclusion rings
                        i = 0
                        aPolySet.each do |aPolygon|
                            i += 1
                            if i == 1
                                intPolygonSet[:exteriorRing] = aPolygon
                            else
                                intPolygonSet[:exclusionRings] << aPolygon
                            end

                        end

                        return intPolygonSet
                    end

                end

            end
        end
    end
end
