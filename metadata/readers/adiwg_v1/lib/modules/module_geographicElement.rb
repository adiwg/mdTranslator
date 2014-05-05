# unpack geographic element
# Reader - ADIwg JSON V1 to internal data structure
# determine element type

# History:
# 	Stan Smith 2013-11-04 original script
# 	Stan Smith 2013-11-13 added line string
# 	Stan Smith 2013-11-13 added multi line string
# 	Stan Smith 2013-11-18 added polygon
#   Stan Smith 2014-04-30 complete redesign for json schema 0.3.0

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_geoCoordSystem'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_geoProperties'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_boundingBox'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_point'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_lineString'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_polygon'

module AdiwgV1GeographicElement

	def self.unpack(aGeoElements)

		# only one geometry is allowed per geographic element.
		# ... in GeoJSON each geometry is allowed a bounding box;
		# ... This code splits bounding boxes to separate elements

		# instance classes needed in script
		aIntGeoEle = Array.new

		aGeoElements.each do |hGeoElement|

			# instance classes needed in script
			intMetadataClass = InternalMetadata.new
			intElement = intMetadataClass.newGeoElement

			# find geographic element type
			if hGeoElement.has_key?('type')
				elementType = hGeoElement['type']
			else
				# invalid geographic element
				return nil
			end

			# set geographic element id
			if hGeoElement.has_key?('id')
				s = hGeoElement['id']
				if s != ''
					intElement[:elementId] = s
				end
			end

			# set geographic element coordinate reference system - CRS
			if hGeoElement.has_key?('crs')
				hGeoCrs = hGeoElement['crs']
				AdiwgV1GeoCoordSystem.unpack(hGeoCrs, intElement)
			end

			# set geographic element properties
			if hGeoElement.has_key?('properties')
				hGeoProps = hGeoElement['properties']
				AdiwgV1GeoProperties.unpack(hGeoProps, intElement)
			end

			# process geographic element bounding box
			if hGeoElement.has_key?('bbox')
				if hGeoElement['bbox'].length == 4
					aBBox = hGeoElement['bbox']

					boxElement = intElement
					boxElement[:elementType] = 'boundingBox'
					boxElement[:elementGeometry] << AdiwgV1BoundingBox.unpack(aBBox)

					aIntGeoEle << boxElement
				end
			end

			# unpack a feature geometry
			if elementType == 'Feature'
				if hGeoElement.has_key?('geometry')
					hGeometry = hGeoElement['geometry']
					unless hGeometry.empty?
						geoElement = intElement
						if hGeometry.has_key?('type')
							geometryType = hGeometry['type']
							aCoordinates = hGeometry['coordinates']
							unless aCoordinates.empty?
								case geometryType
									when 'Point'
										geoElement[:elementType] = 'point'
										geoElement[:elementGeometry] << AdiwgV1Point.unpack(aCoordinates)
									when 'MultiPoint'
										aCoordinates.each do |aPoint|
											geoElement[:elementType] = 'multiPoint'
											geoElement[:elementGeometry] << AdiwgV1Point.unpack(aPoint)
										end
									when 'LineString'
										geoElement[:elementType] = 'lineString'
										geoElement[:elementGeometry] << AdiwgV1LineString.unpack(aCoordinates)
									when 'MultiLineString'
										aCoordinates.each do |aLine|
											geoElement[:elementType] = 'multiLineString'
											geoElement[:elementGeometry] << AdiwgV1LineString.unpack(aLine)
										end
									when 'Polygon'
										geoElement[:elementType] = 'polygon'
										geoElement[:elementGeometry] << AdiwgV1Polygon.unpack(aCoordinates)
									else
										# log - the GeoJSON geometry type is not supported
								end
								aIntGeoEle << geoElement
							end
						end
					end
				end
			end

			# process a feature collection
			if elementType == 'FeatureCollection'
				if hGeoElement.has_key?('features')
					aFeatures = hGeoElement['features']
					unless aFeatures.empty?
						multiElement = intElement
						multiElement[:elementType] = 'multiGeometry'
						multiElement[:elementGeometry] = AdiwgV1GeographicElement.unpack(aFeatures)
						aIntGeoEle << multiElement
					end
				end
			end

		end

		return aIntGeoEle

	end

end
