# ISO <<Class>> LineString
# writer output in XML

# History:
# 	Stan Smith 2013-11-13 original script
#   Stan Smith 2014-05-30 modified for version 0.5.0
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure

require ADIWG::Mdtranslator.reader_module('module_coordinates', $response[:readerVersionUsed])

class LineString

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hGeoElement)

		# gml:LineString attributes
		attributes = {}

		# gml:LineString attributes - gml:id - required
		lineID = hGeoElement[:elementId]
		if lineID.nil?
			$idCount = $idCount.succ
			lineID = 'line' + $idCount
		end
		attributes['gml:id'] = lineID

		# gml:LineString attributes - srsDimension
		s = hGeoElement[:elementGeometry][:dimension]
		if !s.nil?
			attributes[:srsDimension] = s
		end

		# gml:LineString attributes - srsName
		s = hGeoElement[:elementSrs][:srsName]
		if !s.nil?
			attributes[:srsName] = s
		end

		@xml.tag!('gml:LineString',attributes) do

			# lineString - description
			s = hGeoElement[:elementDescription]
			if !s.nil?
				@xml.tag!('gml:description',s)
			elsif $showAllTags
				@xml.tag!('gml:description')
			end

			# lineString - name
			s = hGeoElement[:elementName]
			if !s.nil?
				@xml.tag!('gml:name',s)
			elsif $showAllTags
				@xml.tag!('gml:name')
			end

			# lineString - coordinates - required
			# gml does not support nilReason for coordinates
			# convert coordinate string from geoJSON to gml
			s = hGeoElement[:elementGeometry][:geometry]
			if !s.nil?
				s = Adiwg_Coordinates.unpack(s)
				@xml.tag!('gml:coordinates',s)
			else
				@xml.tag!('gml:coordinates')
			end
		end

	end

end