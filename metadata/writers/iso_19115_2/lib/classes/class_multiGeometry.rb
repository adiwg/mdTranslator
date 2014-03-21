# ISO <<Class>> Multi Geometry
# writer output in XML

# History:
# 	Stan Smith 2013-11-12 original script
# 	Stan Smith 2013-11-13 add line string

require 'builder'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_point'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_lineString'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_polygon'

class MultiGeometry

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hMultiGeo)

		# classes used
		pointClass = Point.new(@xml)
		lineClass = LineString.new(@xml)
		polygonClass = Polygon.new(@xml)

		mGeoID = hMultiGeo[:mGeoID]
		if mGeoID.nil?
			$idCount = $idCount.succ
			mGeoID = $idCount
		end
		attributes = {}
		attributes['gml:id'] = mGeoID

		@xml.tag!('gml:MultiGeometry',attributes) do

			# multi geometry - description
			s = hMultiGeo[:mGeoDescription]
			if !s.nil?
				@xml.tag!('gml:description',s)
			elsif $showEmpty
				@xml.tag!('gml:description')
			end

			# multi geometry - name
			s = hMultiGeo[:mGeoName]
			if !s.nil?
				@xml.tag!('gml:name',s)
			elsif $showEmpty
				@xml.tag!('gml:name')
			end

			# multi geometry - geometry members
			aGeoMembers = hMultiGeo[:mGeos]
			if !aGeoMembers.empty?
				@xml.tag!('gml:geometryMembers') do
					aGeoMembers.each do |hGeoMember|
						geoType = hGeoMember[:elementType]
						hGeoElement = hGeoMember[:element]

						case geoType
							when 'point'
								pointClass.writeXML(hGeoElement)
							when 'lineString'
								lineClass.writeXML(hGeoElement)
							when 'polygon'
								polygonClass.writeXML(hGeoElement)
							else
								# log - the geometry type is not supported as geometry member
						end

					end
				end
			elsif $showEmpty
				@xml.tag!('gml:geometryMembers')
			end

		end

	end

end