# unpack point
# point is coded in GeoJSON
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-07 original script

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_coordinates'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_temporalElement'

module AdiwgV1Point

	def self.unpack(hGeoElement)
		intMetadataClass = InternalMetadata.new
		intElement = intMetadataClass.newGeoElement
		intPoint = intMetadataClass.newPoint

		# get geometry ...
		# existence of geometry and type validated in module_geographicElement
		hGeometry = hGeoElement['geometry']

		# get id
		if hGeoElement.has_key?('id')

			# point - ID - required
			# null ids will be substituted in writer
			intPoint[:pointID] = hGeoElement['id']

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
								intPoint[:srsName] = s
							end
						end
					end
				end
			end

		end

		# get properties
		if hGeoElement.has_key?('properties')
			hProps = hGeoElement['properties']

			# point  - description
			if hProps.has_key?('description')
				s = hProps['description']
				if s != ''
					intPoint[:pointDescription] = s
				end
			end

			# point - identifier / authority
			if hProps.has_key?('identifier')
				s = hProps['identifier']

				if s != ''
					intPoint[:identifier] = s
				end

				if hProps.has_key?('idAuthority')
					s = hProps['idAuthority']
					if s != ''
						intPoint[:identCodeSpace] = s
					end
				end

			end

			# point - name
			if hProps.has_key?('name')
				s = hProps['name']
				if s != ''
					intPoint[:pointName] = s
				end
			end

			# multiple temporal elements are allowed
			# each definition will create a new element
			# point - temporal elements
			if hProps.has_key?('temporalElement')
				aTempElements = hProps['temporalElement']
				unless aTempElements.empty?
					intPoint[:temporalElements] = AdiwgV1TemporalElement.unpack(aTempElements)
				end
			end

		end

		# point - coordinate(s)
		# point - srs dimension
		if hGeometry.has_key?('coordinates')
			aCoords = hGeometry['coordinates']
			intPoint[:srsDim] = AdiwgV1Coordinates.getDimension(aCoords)
			intPoint[:pointRing] = AdiwgV1Coordinates.unpack(aCoords)
		end


		# build internal geo element
		intElement[:elementType] = 'point'
		intElement[:elementExtent] = 'inapplicable'
		intElement[:element] = intPoint

		return intElement
	end

end
