# unpack line string
# line string is coded in GeoJSON
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-13 original script

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_coordinates'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_temporalElement'

module AdiwgV1LineString


	def self.unpack(hGeoElement)
		intMetadataClass = InternalMetadata.new
		intElement = intMetadataClass.newGeoElement
		intLine = intMetadataClass.newLineString

		# get geometry ...
		# existence of geometry and type validated in module_geographicElement
		hGeometry = hGeoElement['geometry']

		# get id
		if hGeoElement.has_key?('id')

			# line string - ID - required
			# null ids will be substituted in writer
			intLine[:lineID] = hGeoElement['id']

		end

		# get crs
		if hGeoElement.has_key?('crs')
			hCRS = hGeoElement['crs']

			# line string - srs name
			# null crs will default to CRS84 in writer
			if hCRS.has_key?('type')
				crsType = hCRS['type']
				if crsType == 'name'
					if hCRS.has_key?('properties')
						hCRSProp = hCRS['properties']
						if hCRSProp.has_key?('name')
							s = hCRSProp['name']
							if s != ''
								intLine[:srsName] = s
							end
						end
					end
				end
			end

		end

		# get properties
		if hGeoElement.has_key?('properties')
			hProps = hGeoElement['properties']

			# line string  - description
			if hProps.has_key?('description')
				s = hProps['description']
				if s != ''
					intLine[:lineDescription] = s
				end
			end

			# line string - name
			if hProps.has_key?('name')
				s = hProps['name']
				if s != ''
					intLine[:lineName] = s
				end
			end

			# multiple temporal elements are allowed
			# each definition will create a new element
			# line string - temporal elements
			if hProps.has_key?('temporalElement')
				aTempElements = hProps['temporalElement']
				unless aTempElements.empty?
					intLine[:temporalElements] = AdiwgV1TemporalElement.unpack(aTempElements)
				end
			end

		end

		# line string - coordinate(s)
		# line string - srs dimension
		if hGeometry.has_key?('coordinates')
			aCoords = hGeometry['coordinates']
			intLine[:srsDim] = AdiwgV1Coordinates.getDimension(aCoords)
			intLine[:lineRing] = AdiwgV1Coordinates.unpack(aCoords)
		end


		# load internal geo element
		intElement[:elementType] = 'lineString'
		intElement[:elementExtent] = 'inapplicable'
		intElement[:element] = intLine

		return intElement
	end

end
