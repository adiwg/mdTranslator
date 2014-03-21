# ISO <<Class>> Polygon
# writer output in XML

# History:
# 	Stan Smith 2013-11-18 original script

require 'builder'

class Polygon

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hPolygon)

		polyID = hPolygon[:polygonID]
		if polyID.nil?
			$idCount = $idCount.succ
			polyID = $idCount
		end

		attributes = {}
		attributes[:srsName] = hPolygon[:srsName]
		attributes[:srsDimension] = hPolygon[:srsDim]
		attributes['gml:id'] = polyID

		@xml.tag!('gml:Polygon',attributes) do

			# polygon - description
			s = hPolygon[:polygonDescription]
			if !s.nil?
				@xml.tag!('gml:description',s)
			elsif $showEmpty
				@xml.tag!('gml:description')
			end

			# polygon - name
			s = hPolygon[:polygonName]
			if !s.nil?
				@xml.tag!('gml:name',s)
			elsif $showEmpty
				@xml.tag!('gml:name')
			end

			# polygon - exterior ring
			# coordinates are converted to string by reader
			s = hPolygon[:exteriorRing]
			if !s.nil?
				@xml.tag!('gml:exterior') do
					@xml.tag!('gml:LinearRing') do
						@xml.tag!('gml:coordinates',s)
					end
				end
			else
				@xml.tag!('gml:exterior')
			end

			# polygon - interior ring
			# coordinates are converted to string by reader
			aRings = hPolygon[:interiorRings]
			unless aRings.empty?
				aRings.each do |ring|
					@xml.tag!('gml:interior') do
						@xml.tag!('gml:LinearRing') do
							@xml.tag!('gml:coordinates', ring)
						end
					end
				end
			end

		end

	end

end