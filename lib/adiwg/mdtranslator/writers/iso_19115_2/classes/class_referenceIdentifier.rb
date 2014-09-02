# ISO <<Class>> RS_Identifier
# writer
# output for ISO 19115-2 XML

# History:
# 	Stan Smith 2014-09-03 original script

class RS_Identifier

	def initialize(xml)
		@xml = xml
	end

	def writeXML(refId, refType)

		@xml.tag!('gmd:RS_Identifier') do

			# identity - code - required
			# identifiers can be name, epsg number, wkt
			case refType
				when 'name'
					@xml.tag!('gmd:code') do
						@xml.tag!('gco:CharacterString', refId)
					end

				when 'epsg'
					@xml.tag!('gmd:code') do
						s = 'urn:ocg:def:crs:EPSG::' + refId.to_s
						@xml.tag!('gco:CharacterString', s)
					end

				when 'wkt'
					@xml.tag!('gmd:code') do
						s = 'WKT::' + refId
						@xml.tag!('gco:CharacterString', s)
					end
			end
		end

	end

end