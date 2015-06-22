# unpack line string
# line string is coded in GeoJSON
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-13 original script
#   Stan Smith 2014-04-30 reorganized for json schema 0.3.0
#   Stan Smith 2014-07-07 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

require $ReaderNS.readerModule('module_coordinates')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module LineString

                    def self.unpack(aCoords, geoType, responseObj)
                        intMetadataClass = InternalMetadata.new
                        intLine = intMetadataClass.newGeometry

                        intLine[:geoType] = geoType
                        intLine[:geometry] = aCoords
                        intLine[:dimension] = $ReaderNS::Coordinates.getDimension(aCoords)

                        return intLine
                    end

                end

            end
        end
    end
end
