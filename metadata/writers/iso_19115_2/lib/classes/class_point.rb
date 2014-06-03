# ISO <<Class>> Point
# writer output in XML

# History:
# 	Stan Smith 2013-11-01 original script
#   Stan Smith 2014-05-30 modified for version 0.5.0

require 'builder'
require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_coordinates'

class Point

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hGeoElement)

		# gml:Point attributes
		attributes = {}

		# gml:Point attributes - gml:id - required
		pointID = hGeoElement[:elementId]
		if pointID.nil?
			$idCount = $idCount.succ
			pointID = 'point' + $idCount
		end
		attributes['gml:id'] = pointID

		# gml:Point attributes - srsDimension
		s = hGeoElement[:elementGeometry][:dimension]
		if !s.nil?
			attributes[:srsDimension] = s
		end

		# gml:Point attributes - srsName
		s = hGeoElement[:elementSrs][:srsName]
		if !s.nil?
			attributes[:srsName] = s
		end

		@xml.tag!('gml:Point',attributes) do

			# point - description
			s = hGeoElement[:elementDescription]
			if !s.nil?
				@xml.tag!('gml:description',s)
			elsif $showEmpty
				@xml.tag!('gml:description')
			end

			# point - name
			s = hGeoElement[:elementName]
			if !s.nil?
				@xml.tag!('gml:name',s)
			elsif $showEmpty
				@xml.tag!('gml:name')
			end

			# point - coordinates - required
			# gml does not support nilReason for coordinates
			# convert coordinate string from geoJSON to gml
			s = hGeoElement[:elementGeometry][:geometry]
			if !s.nil?
				s = AdiwgV1Coordinates.unpack(s)
				@xml.tag!('gml:coordinates',s)
			else
				@xml.tag!('gml:coordinates')
			end
		end

		# write new extent to portray supplemental information
		# pass the new extent back to MD_DataIdentification for writing to ISO
		if !hGeoElement[:temporalElement].empty? ||
			!hGeoElement[:verticalElement].empty? ||
			!hGeoElement[:elementIdentifiers].empty?

			intMetadataClass = InternalMetadata.new
			intExtent = intMetadataClass.newExtent
			intGeoEle = intMetadataClass.newGeoElement

			intGeoEle[:elementGeometry] = hGeoElement[:elementGeometry]

			intExtent[:extDesc] = 'Supplemental information for point ' + pointID
			intExtent[:extGeoElements] << intGeoEle
			intExtent[:extIdElements] = hGeoElement[:elementIdentifiers]
			intExtent[:extTempElements] = hGeoElement[:temporalElement]
			intExtent[:extVertElements] = hGeoElement[:verticalElement]

			$otherExtents << intExtent
		end

	end

end