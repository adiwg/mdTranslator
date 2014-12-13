# unpack point
# point is coded in GeoJSON
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-07 original script
#   Stan Smith 2014-04-30 reorganized for json schema 0.3.0
#   Stan Smith 2014-07-07 resolve require statements using Mdtranslator.reader_module

require ADIWG::Mdtranslator.reader_module('module_coordinates', $response[:readerVersionUsed])

module Md_Point

	def self.unpack(aCoords,geoType)
		intMetadataClass = InternalMetadata.new
		intPoint = intMetadataClass.newGeometry

		intPoint[:geoType] = geoType
		intPoint[:geometry] = aCoords
		intPoint[:dimension] = Md_Coordinates.getDimension(aCoords)

		return intPoint
	end

end
