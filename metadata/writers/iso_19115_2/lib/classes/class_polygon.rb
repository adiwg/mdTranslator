# ISO <<Class>> Polygon
# writer output in XML

# History:
# 	Stan Smith 2013-11-18 original script
#   Stan Smith 2014-05-30 modified for version 0.5.0

require 'builder'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_coordinates'

class Polygon

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hGeoElement)

		# gml:Polygon attributes
		attributes = {}

		# gml:Polygon attributes - gml:id - required
		lineID = hGeoElement[:elementId]
		if lineID.nil?
			$idCount = $idCount.succ
			lineID = 'polygon' + $idCount
		end
		attributes['gml:id'] = lineID

		# gml:Polygon attributes - srsDimension
		s = hGeoElement[:elementGeometry][:dimension]
		if !s.nil?
			attributes[:srsDimension] = s
		end

		# gml:Polygon attributes - srsName
		s = hGeoElement[:elementSrs][:srsName]
		if !s.nil?
			attributes[:srsName] = s
		end

		@xml.tag!('gml:Polygon',attributes) do

			# polygon - description
			s = hGeoElement[:elementDescription]
			if !s.nil?
				@xml.tag!('gml:description',s)
			elsif $showEmpty
				@xml.tag!('gml:description')
			end

			# polygon - name
			s = hGeoElement[:elementName]
			if !s.nil?
				@xml.tag!('gml:name',s)
			elsif $showEmpty
				@xml.tag!('gml:name')
			end


			# polygon - exterior ring
			# convert coordinate string from geoJSON to gml
			aCoords = hGeoElement[:elementGeometry][:geometry][:exteriorRing]
			if !aCoords.empty?
				s = Adiwg_Coordinates.unpack(aCoords)
				@xml.tag!('gml:exterior') do
					@xml.tag!('gml:LinearRing') do
						@xml.tag!('gml:coordinates',s)
					end
				end
			else
				@xml.tag!('gml:exterior')
			end

			# polygon - interior ring
			# convert coordinate string from geoJSON to gml
			# XSDs do not all gml:interior to be displayed empty
			aRings = hGeoElement[:elementGeometry][:geometry][:exclusionRings]
			unless aRings.empty?
				aRings.each do |aRing|
					s = Adiwg_Coordinates.unpack(aRing)
					@xml.tag!('gml:interior') do
						@xml.tag!('gml:LinearRing') do
							@xml.tag!('gml:coordinates', s)
						end
					end
				end
			end

		end

	end

end