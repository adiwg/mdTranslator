# ISO <<Class>> EX_Extent
# writer output in XML

# History:
# 	Stan Smith 2013-11-01 original script
# 	Stan Smith 2013-11-15 add temporal elements
# 	Stan Smith 2013-11-15 add vertical elements

require 'builder'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_geographicBoundingBox'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_boundingPolygon'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_temporalExtent'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_verticalExtent'

class EX_Extent

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hExtent)

		# classes used by MD_Metadata
		geoBBoxClass = EX_GeographicBoundingBox.new(@xml)
		geoBPolyClass = EX_BoundingPolygon.new(@xml)
		tempExtClass = EX_TemporalExtent.new(@xml)
		vertExtClass = EX_VerticalExtent.new(@xml)

		@xml.tag!('gmd:EX_Extent') do

			# extent - description
			s = hExtent[:extDesc]
			if !s.nil?
				@xml.tag!('gmd:description') do
					@xml.tag!('gco:CharacterString',s)
				end
			elsif $showEmpty
				@xml.tag!('gmd:description')
			end

			# extent - geographic element
			aGeoElements = hExtent[:extGeoElements]
			if !aGeoElements.empty?
				aGeoElements.each do |geoElement|
					eType = geoElement[:elementType]
					case eType
						when 'bbox'
							@xml.tag!('gmd:geographicElement') do
								geoBBoxClass.writeXML(geoElement)
							end
						when 'point', 'lineString' ,'polygon', 'multiGeo'
							@xml.tag!('gmd:geographicElement') do
								geoBPolyClass.writeXML(geoElement)
							end
						else
							@xml.tag!('gmd:geographicElement',{'gco:nilReason'=>'unknown'})
					end

				end
			elsif $showEmpty
				@xml.tag!('gmd:geographicElement')
			end

			# extent - temporal element
			aTempElements = hExtent[:extTempElements]
			if !aTempElements.empty?
				aTempElements.each do |hTempElement|
					@xml.tag!('gmd:temporalElement') do
						tempExtClass.writeXML(hTempElement)
					end
				end
			elsif $showEmpty
				@xml.tag!('gmd:temporalElement')
			end

			# extent - vertical element
			aVertElements = hExtent[:extVertElements]
			if !aVertElements.empty?
				aVertElements.each do |hVertElement|
					@xml.tag!('gmd:verticalElement') do
						vertExtClass.writeXML(hVertElement)
					end
				end
			elsif $showEmpty
				@xml.tag!('gmd:verticalElement')
			end
		end

	end

end