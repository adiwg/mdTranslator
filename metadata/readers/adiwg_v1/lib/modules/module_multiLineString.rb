# unpack multi line string
# line string is coded in GeoJSON
# convert to multiGeometry for ISO
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-13 original script

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_coordinates'

module AdiwgV1MultiLineString


	def self.unpack(hGeoElement)
		intMetadataClass = InternalMetadata.new
		intElement = intMetadataClass.newGeoElement
		intMGeo = intMetadataClass.newMultiGeo

		# get geometry ...
		# existence of geometry and type validated in module_geographicElement
		hGeometry = hGeoElement['geometry']

		# get id
		if hGeoElement.has_key?('id')

			# multi line string => multi geometry - ID - required
			# null ids will be substituted in writer
			intMGeo[:mGeoID] = hGeoElement['id']

		end

		# multi line string => multi geometry - not supported

		# get crs
		srsName = nil
		if hGeoElement.has_key?('crs')
			hCRS = hGeoElement['crs']

			# multi line string => multi geometry - srs name - not supported
			# srsName will be propagated to all line strings
			if hCRS.has_key?('type')
				crsType = hCRS['type']
				if crsType == 'name'
					if hCRS.has_key?('properties')
						hCRSProp = hCRS['properties']
						if hCRSProp.has_key?('name')
							srsName = hCRSProp['name']
						end
					end
				end
			end

		end

		# get properties
		if hGeoElement.has_key?('properties')
			hProps = hGeoElement['properties']

			# multi line string => multi geometry  - description
			if hProps.has_key?('description')
				s = hProps['description']
				if s != ''
					intMGeo[:mGeoDescription] = s
				end
			end

			# multi line string => multi geometry - name
			if hProps.has_key?('name')
				s = hProps['name']
				if s != ''
					intMGeo[:mGeoName] = s
				end
			end

		end

		# multi line string => multi geometry - coordinates
		# create separate geographic elements for each line string
		if hGeometry.has_key?('coordinates')
			aCoords = hGeometry['coordinates']
			unless aCoords.empty?
				aCoords.each do |aLSCoords|
					intMGeoEle = intMetadataClass.newGeoElement
					intMGeoEle[:elementType] = 'lineString'
					intMGeoEle[:elementExtent] = 'inapplicable'
					intLine = intMetadataClass.newLineString
					intLine[:lineID] = nil
					intLine[:srsName] = srsName
					intLine[:srsDim] = AdiwgV1Coordinates.getDimension(aLSCoords)
					intLine[:temporalExtents] = []
					intLine[:lineDescription] = nil
					intLine[:lineName] = nil
					intLine[:lineRing] = AdiwgV1Coordinates.unpack(aLSCoords)
					intMGeoEle[:element] = intLine
					intMGeo[:mGeos] << intMGeoEle
				end
			end

		end

		# load internal geo element
		intElement[:elementType] = 'multiGeo'
		intElement[:elementExtent] = 'inapplicable'
		intElement[:element] = intMGeo

		return intElement
	end

end
