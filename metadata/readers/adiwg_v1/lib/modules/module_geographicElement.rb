# unpack geographic element
# Reader - ADIwg JSON V1 to internal data structure
# determine element type

# History:
# 	Stan Smith 2013-11-04 original script
# 	Stan Smith 2013-11-13 added line string
# 	Stan Smith 2013-11-13 added multi line string
# 	Stan Smith 2013-11-18 added polygon

require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_boundingBox'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_point'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_featureCollection'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_lineString'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_multiLineString'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_polygon'

module AdiwgV1GeographicElement

	def self.unpack(aGeoElements)

		# instance classes needed in script
		aIntGeoEle = Array.new

		aGeoElements.each do |hGeoElement|

			# find geoElement type
			if hGeoElement.has_key?('type')
				elementType = hGeoElement['type']
			else
				# invalid geographic element
				return nil
			end

			# unpack a feature
			if elementType == 'Feature'

				if hGeoElement.has_key?('bbox')

					# process bounding box
					aBbox = hGeoElement['bbox']
					if aBbox.length >= 4
						aIntGeoEle << AdiwgV1BoundingBox.unpack(hGeoElement)
					end

				end

				if hGeoElement.has_key?('geometry')
					hGeometry = hGeoElement['geometry']
					unless hGeometry.nil?
						if hGeometry.has_key?('type')
							geometryType = hGeometry['type']

							case geometryType
								when 'Point', 'MultiPoint'
									aIntGeoEle << AdiwgV1Point.unpack(hGeoElement)
								when 'LineString'
									aIntGeoEle << AdiwgV1LineString.unpack(hGeoElement)
								when 'MultiLineString'
									aIntGeoEle << AdiwgV1MultiLineString.unpack(hGeoElement)
								when 'Polygon'
									aIntGeoEle << AdiwgV1Polygon.unpack(hGeoElement)
								else
									# log - the GeoJSON geometry type is not supported
							end

						end
					end
				end

			end

			# process a feature collection
			if elementType == 'FeatureCollection'

				if hGeoElement.has_key?('bbox')

					# process bounding box
					aBbox = hGeoElement['bbox']
					if aBbox.length >= 4
						aIntGeoEle << AdiwgV1BoundingBox.unpack(hGeoElement)
					end

				end

				if hGeoElement.has_key?('features')

					# process features
					aFeatures = hGeoElement['features']
					unless aFeatures.empty?
						aIntGeoEle << AdiwgV1FeatureCollection.unpack(hGeoElement)
					end

				end

			end

		end

		return aIntGeoEle
	end

end
