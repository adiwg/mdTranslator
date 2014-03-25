# ISO <<Class>> EX_BoundingPolygon
# writer output in XML

# History:
# 	Stan Smith 2013-11-01 original script
# 	Stan Smith 2013-11-12 added multi geometry
# 	Stan Smith 2013-11-13 added line string
# 	Stan Smith 2013-11-18 added polygon

require 'builder'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_point'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_lineString'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_multiGeometry'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_polygon'

class EX_BoundingPolygon

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hElement)

		# classes used by MD_Metadata
		pointClass = Point.new(@xml)
		lineClass = LineString.new(@xml)
		multiGeoClass = MultiGeometry.new(@xml)
		polygonClass = Polygon.new(@xml)

		polyType = hElement[:elementType]
		extentType = hElement[:elementExtent]
		hBPolygon = hElement[:element]

		@xml.tag!('gmd:EX_BoundingPolygon') do

			# bounding polygon - extent type - required
			if extentType.nil?
				@xml.tag!('gmd:extentTypeCode',{'gco:nilReason'=>'missing'})
			elsif extentType == true || extentType == false
				@xml.tag!('gmd:extentTypeCode') do
					@xml.tag!('gco:Boolean',extentType)
				end
			else
				@xml.tag!('gmd:extentTypeCode',{'gco:nilReason'=>extentType})
			end

			# bounding polygon - polygon - required
			if hBPolygon.empty?
				@xml.tag!('gmd:polygon', {'gco:nilReason' => 'missing'})
			else
				@xml.tag!('gmd:polygon') do
					case polyType
						when 'point'
							pointClass.writeXML(hBPolygon)
						when 'lineString'
							lineClass.writeXML(hBPolygon)
						when 'polygon'
							polygonClass.writeXML(hBPolygon)
						when 'multiGeo'
							multiGeoClass.writeXML(hBPolygon)
						else
							# log - the bounding polygon type is not supported
					end
				end
			end

		end

	end

end