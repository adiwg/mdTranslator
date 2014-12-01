# unpack line string
# line string is coded in GeoJSON
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-13 original script
#   Stan Smith 2014-04-30 reorganized for json schema 0.3.0
#   Stan Smith 2014-07-07 resolve require statements using Mdtranslator.reader_module

require ADIWG::Mdtranslator.reader_module('module_coordinates', $response[:readerVersionUsed])

module Md_LineString

	def self.unpack(aCoords, geoType)
		intMetadataClass = InternalMetadata.new
		intLine = intMetadataClass.newGeometry

		intLine[:geoType] = geoType
		intLine[:geometry] = aCoords
		intLine[:dimension] = Md_Coordinates.getDimension(aCoords)

		return intLine
	end

end
