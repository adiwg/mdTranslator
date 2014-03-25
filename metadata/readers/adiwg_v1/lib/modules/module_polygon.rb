# unpack polygon
# point is coded in GeoJSON
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-18 original script

require Rails.root + 'metadataxx/internal/internal_metadata_obj'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_coordinates'

module AdiwgV1Polygon

	def self.unpack(hGeoElement)
		intMetadataClass = InternalMetadata.new
		intElement = intMetadataClass.newGeoElement
		intPolygon = intMetadataClass.newPolygon
		extType = nil

		# get geometry ...
		# existence of geometry and type validated in module_geographicElement
		hGeometry = hGeoElement['geometry']

		# get id
		if hGeoElement.has_key?('id')

			# polygon - ID - required
			# null ids will be substituted in writer
			intPolygon[:polygonID] = hGeoElement['id']

		end

		# get crs
		if hGeoElement.has_key?('crs')
			hCRS = hGeoElement['crs']

			# point - srs name
			# null crs will default to CRS84 in writer
			if hCRS.has_key?('type')
				crsType = hCRS['type']
				if crsType == 'name'
					if hCRS.has_key?('properties')
						hCRSProp = hCRS['properties']
						if hCRSProp.has_key?('name')
							s = hCRSProp['name']
							if s != ''
								intPolygon[:srsName] = s
							end
						end
					end
				end
			end

		end

		# get properties
		if hGeoElement.has_key?('properties')
			hProps = hGeoElement['properties']

			# polygon  - description
			if hProps.has_key?('description')
				s = hProps['description']
				if s != ''
					intPolygon[:polygonDescription] = s
				end
			end

			# polygon - name
			if hProps.has_key?('name')
				s = hProps['name']
				if s != ''
					intPolygon[:polygonName] = s
				end
			end

			# polygon - extentType
			if hProps.has_key?('includesData')
				s = hProps['includesData']
				if !!s == s
					extType = s
				end
			end

		end

		# polygon - coordinate(s)
		# polygon - srs dimension
		if hGeometry.has_key?('coordinates')
			aCoords = hGeometry['coordinates']
			intPolygon[:srsDim] = AdiwgV1Coordinates.getDimension(aCoords)
			i = 0
			aCoords.each do |aPolygon|
				sCoords = AdiwgV1Coordinates.unpack(aPolygon)
				i += 1
				if i == 1
					intPolygon[:exteriorRing] = sCoords
				else
					intPolygon[:interiorRings] << sCoords
				end
			end
		end

		# build internal geo element
		intElement[:elementType] = 'polygon'
		intElement[:elementExtent] = extType
		intElement[:element] = intPolygon

		return intElement
	end

end
