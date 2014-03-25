# unpack bounding box
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-07 original script

require Rails.root + 'metadata/internal/internal_metadata_obj'

module AdiwgV1BoundingBox


	def self.unpack(hGeoElement)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		aBbox = hGeoElement['bbox']

		# set extentType to same as geometry properties (default true)
		extentType = true
		if hGeoElement.has_key?('properties')
			hProp = hGeoElement['properties']
			if hProp.has_key?('includesData')
				extentType = hProp['includesData']
			end
		end

		# assuming only 2 coordinates of any number of dimensions
		coords = aBbox.length
		west = aBbox[0]
		south = aBbox[1]
		east = aBbox[coords/2]
		north = aBbox[((coords/2) + 1)]

		# assuming WGS84 (or close enough) if easting +-180 and northing +-90
		wgs84 = false
		if (180 >= west) && (west >= -180)
			if (90 >= south) && (south >= -90)
				if (180 >= east) && (east >= -180)
					if (90 >= north) &&(north >= -90)
						wgs84 = true
					end
				end
			end
		end

		# build internal geo element
		if wgs84
			intElement = intMetadataClass.newGeoElement
			intBBox = intMetadataClass.newBoundingBox

			intBBox[:westLong] = west
			intBBox[:eastLong] = east
			intBBox[:southLat] = south
			intBBox[:northLat] = north

			intElement[:elementType] = 'bbox'
			intElement[:elementExtent] = extentType
			intElement[:element] = intBBox

			return intElement
		else
			return nil
		end
	end

end
