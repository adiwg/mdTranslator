# ISO <<Class>> LineString
# writer output in XML

# History:
# 	Stan Smith 2013-11-13 original script

require 'builder'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_genericMetaData'

class LineString

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hLine)

		# classes used
		metaDataClass = GenericMetaData.new(@xml)

		lineID = hLine[:lineID]
		if lineID.nil?
			$idCount = $idCount.succ
			lineID = $idCount
		end

		attributes = {}
		attributes[:srsName] = hLine[:srsName]
		attributes[:srsDimension] = hLine[:srsDim]
		attributes['gml:id'] = lineID

		@xml.tag!('gml:LineString',attributes) do

			# line string - metadata property
			aTempEle = hLine[:temporalElements]
			if !aTempEle.empty?
				@xml.tag!('gml:metaDataProperty') do
					metaDataClass.writeXML(aTempEle)
				end
			elsif $showEmpty
				@xml.tag!('gml:metaDataProperty')
			end

			# line string - description
			s = hLine[:lineDescription]
			if !s.nil?
				@xml.tag!('gml:description',s)
			elsif $showEmpty
				@xml.tag!('gml:description')
			end

			# line string - name
			s = hLine[:lineName]
			if !s.nil?
				@xml.tag!('gml:name',s)
			elsif $showEmpty
				@xml.tag!('gml:name')
			end

			# line string - coordinates - required
			# gml does not support nilReason
			# coordinates are converted to string in reader
			s = hLine[:lineRing]
			if !s.nil?
				@xml.tag!('gml:coordinates',s)
			else
				@xml.tag!('gml:coordinates')
			end
		end

	end

end