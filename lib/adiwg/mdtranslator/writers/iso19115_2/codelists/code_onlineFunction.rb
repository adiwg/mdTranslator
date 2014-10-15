# ISO <<CodeLists>> gmd:CI_OnLineFunctionCode

# from http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml
# History:
# 	Stan Smith 2013-09-26 original script
#   Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered

class CI_OnLineFunctionCode

	def initialize(xml)
		@xml = xml
	end

	def writeXML(codeName)
		case(codeName)
			when 'download' then codeID = '001'
			when 'information' then codeID = '002'
			when 'offlineAccess' then codeID = '003'
			when 'order' then codeID = '004'
			when 'search' then codeID = '005'
			else
				codeID = 'non-ISO codeName'
		end

		# write xml
		@xml.tag!('gmd:CI_OnLineFunctionCode',{:codeList=>'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_OnLineFunctionCode',
											   :codeListValue=>"#{codeName}",
											   :codeSpace=>"#{codeID}"})
	end

end