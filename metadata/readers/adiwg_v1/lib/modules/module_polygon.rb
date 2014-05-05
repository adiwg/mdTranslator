# unpack polygon
# point is coded in GeoJSON
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-18 original script
#   Stan Smith 2014-04-30 reorganized for json schema 0.3.0

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_coordinates'

module AdiwgV1Polygon

	def self.unpack(aCoords)
		intMetadataClass = InternalMetadata.new
		intPolygonSet = intMetadataClass.newPolygonSet

		# polygon - coordinate(s)
		i = 0
		aCoords.each do |aPolygon|
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
