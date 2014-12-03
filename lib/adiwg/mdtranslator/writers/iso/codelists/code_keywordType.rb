# ISO <<CodeLists>> gmd:MD_KeywordTypeCode

# from http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml
# History:
# 	Stan Smith 2013-09-18 original script
#   Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered

class MD_KeywordTypeCode

	def initialize(xml)
		@xml = xml
	end

	def writeXML(codeName)
		case(codeName)
			when 'discipline' then codeID = '001'
			when 'place' then codeID = '002'
			when 'stratum' then codeID = '003'
			when 'temporal' then codeID = '004'
			when 'theme' then codeID = '005'
			when 'taxon' then codeID = '006'
			when 'instrument' then codeID = 'ADIwg-001'
			else
				codeID = 'non-ISO codeName'
		end

		# write xml
		@xml.tag!('gmd:MD_KeywordTypeCode',{:codeList=>'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_KeywordTypeCode',
										    :codeListValue=>"#{codeName}",
										    :codeSpace=>"#{codeID}"})
	end

end