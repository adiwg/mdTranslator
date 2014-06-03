# unpack line string
# line string is coded in GeoJSON
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-13 original script
#   Stan Smith 2014-04-30 reorganized for json schema 0.3.0

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_coordinates'

module AdiwgV1LineString

	def self.unpack(aCoords, geoType)
		intMetadataClass = InternalMetadata.new
		intLine = intMetadataClass.newGeometry

		intLine[:geoType] = geoType
		intLine[:geometry] = aCoords
		intLine[:dimension] = AdiwgV1Coordinates.getDimension(aCoords)

		return intLine
	end

end
