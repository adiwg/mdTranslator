# ISO <<CodeLists>> gmd:CI_DateTypeCode

# from http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml
# History:
# 	Stan Smith 2013-08-09 original script

class CI_DateTypeCode

	def initialize(xml)
		@xml = xml
	end

	def writeXML(codeName)
		case(codeName)
			when 'creation' then codeID = '001'
			when 'publication' then codeID = '002'
			when 'revision' then codeID = '003'
			else
				codeName = 'INVALID DATE TYPE'
				codeID = '999'
		end

		# write xml
		@xml.tag!('gmd:CI_DateTypeCode',{:codeList=>'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_DateTypeCode',
										 :codeListValue=>"#{codeName}",
										 :codeSpace=>"#{codeID}"})
	end

end