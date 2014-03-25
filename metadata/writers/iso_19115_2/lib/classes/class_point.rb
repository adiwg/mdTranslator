# ISO <<Class>> Point
# writer output in XML

# History:
# 	Stan Smith 2013-11-01 original script

require 'builder'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_genericMetaData'

class Point

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hPoint)

		# classes used
		metaDataClass = GenericMetaData.new(@xml)

		pointID = hPoint[:pointID]
		if pointID.nil?
			$idCount = $idCount.succ
			pointID = $idCount
		end

		attributes = {}
		attributes[:srsName] = hPoint[:srsName]
		attributes[:srsDimension] = hPoint[:srsDim]
		attributes['gml:id'] = pointID

		@xml.tag!('gml:Point',attributes) do

			# point - metadataxx property
			aTempEle = hPoint[:temporalElements]
			if !aTempEle.empty?
				@xml.tag!('gml:metaDataProperty') do
					metaDataClass.writeXML(aTempEle)
				end
			elsif $showEmpty
				@xml.tag!('gml:metaDataProperty')
			end

			# point - description
			s = hPoint[:pointDescription]
			if !s.nil?
				@xml.tag!('gml:description',s)
			elsif $showEmpty
				@xml.tag!('gml:description')
			end

			# point - identifier
			# gml:identifier cannot be shown empty
			s = hPoint[:identifier]
			unless s.nil?
				codeSpace = hPoint[:identCodeSpace]
				if codeSpace.nil?
					codeSpace = 'MISSING'
				end
				attributes = {}
				attributes[:codeSpace] = codeSpace
				attributes['xsi:type'] = 'gml:CodeWithAuthorityType'

				@xml.tag!('gml:identifier', attributes, s)
			end

			# point - name
			s = hPoint[:pointName]
			if !s.nil?
				@xml.tag!('gml:name',s)
			elsif $showEmpty
				@xml.tag!('gml:name')
			end

			# point - coordinates - required
			# gml does not support nilReason
			# coordinates are converted to string in reader
			s = hPoint[:pointRing]
			if !s.nil?
				@xml.tag!('gml:coordinates',s)
			else
				@xml.tag!('gml:coordinates')
			end
		end

	end

end