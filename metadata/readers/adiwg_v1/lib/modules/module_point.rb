# unpack point
# point is coded in GeoJSON
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-07 original script
#   Stan Smith 2014-04-30 reorganized for json schema 0.3.0

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_coordinates'

module Adiwg_Point

	def self.unpack(aCoords,geoType)
		intMetadataClass = InternalMetadata.new
		intPoint = intMetadataClass.newGeometry

		intPoint[:geoType] = geoType
		intPoint[:geometry] = aCoords
		intPoint[:dimension] = Adiwg_Coordinates.getDimension(aCoords)

		return intPoint
	end

end
