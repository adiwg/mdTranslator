# unpack feature collection
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-08 original script

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_geographicElement'

module AdiwgV1FeatureCollection


	def self.unpack(hGeoElement)
		intMetadataClass = InternalMetadata.new
		intElement = intMetadataClass.newGeoElement
		intMultiGeo = intMetadataClass.newMultiGeo

		# get features ...
		# existence of features and validated in module_geographicElement
		aFeatures = hGeoElement['features']

		# get id
		if hGeoElement.has_key?('id')

			# multi geometry - ID - required
			# null ids will be substituted in writer
			intMultiGeo[:mGeoID] = hGeoElement['id']

		end

		# multi geometry - srs dimension - not supported

		# get crs
		srsName = nil
		if hGeoElement.has_key?('crs')
			hCRS = hGeoElement['crs']

			# multi geometry - srs name - not supported
			# srsName will be propagated to all features
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

			# multi geometry  - description
			if hProps.has_key?('description')
				s = hProps['description']
				if s != ''
					intMultiGeo[:mGeoDescription] = s
				end

			end

			# multi geometry - name
			if hProps.has_key?('name')
				s = hProps['name']
				if s != ''
					intMultiGeo[:mGeoName] = s
				end
			end

		end

		# process features array
		aMultiGeos = AdiwgV1GeographicElement.unpack(aFeatures)

		# add srsName to each geometry element
		aMultiGeos.each do |hElement|
			hElement[:element][:srsName] = srsName
		end

		# load the internal data structure
		intMultiGeo[:mGeos] = aMultiGeos

		# build internal geo element
		intElement[:elementType] = 'multiGeo'
		intElement[:elementExtent] = 'inapplicable'
		intElement[:element] = intMultiGeo

		return intElement
	end

end
