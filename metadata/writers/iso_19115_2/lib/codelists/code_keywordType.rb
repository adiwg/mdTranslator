# ISO <<CodeLists>> gmd:MD_KeywordTypeCode

# from http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml
# History:
# 	Stan Smith 2013-09-18 original script

require 'builder'

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
				codeName = 'INVALID KEYWORD TYPE'
				codeID = '999'
		end

		# write xml
		@xml.tag!('gmd:MD_KeywordTypeCode',{:codeList=>'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_KeywordTypeCode',
										    :codeListValue=>"#{codeName}",
										    :codeSpace=>"#{codeID}"})
	end

end