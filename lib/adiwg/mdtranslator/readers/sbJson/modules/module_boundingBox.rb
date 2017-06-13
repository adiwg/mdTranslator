module ADIWG
    module Mdtranslator
        module Readers
            module SbJson

                module BoundingBox

                    def self.unpack(aBBox, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intGeometry = intMetadataClass.newGeometry
                        intGeometry[:geoType] = 'BoundingBox'

                        # unpack GeoJSON bounding box elements
                        intBBox = intMetadataClass.newBoundingBox
                        west = aBBox[0]
                        south = aBBox[1]
                        east = aBBox[2]
                        north = aBBox[3]

                        # validate coordinates if easting +/-180 and northing +/-90
                        valid = false
                        if (180 >= west) && (west >= -180)
                            if (90 >= south) && (south >= -90)
                                if (180 >= east) && (east >= -180)
                                    if (90 >= north) &&(north >= -90)
                                        valid = true
                                    end
                                end
                            end
                        end

                        # build internal geo element if valid
                        if valid
                            intBBox[:westLong] = west
                            intBBox[:eastLong] = east
                            intBBox[:southLat] = south
                            intBBox[:northLat] = north
                            intGeometry[:geometry] = intBBox

                            return intGeometry
                        else
                            return nil
                        end

                    end

                end

            end
        end
    end
end
