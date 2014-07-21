# ISO <<CodeLists>> gmd:MD_ClassificationCode

# from http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml
# History:
# 	Stan Smith 2013-10-21 original script

class MD_ClassificationCode
	def initialize(xml)
		@xml = xml
	end

	def writeXML(codeName)
		case(codeName)
			when 'unclassified' then codeID = '001'
			when 'restricted' then codeID = '002'
			when 'confidential' then codeID = '003'
			when 'secret' then codeID = '004'
			when 'topSecret' then codeID = '005'
			else
				codeName = 'INVALID CLASSIFICATION CODE'
				codeID = '999'
		end

		# write xml
		@xml.tag!('gmd:MD_ClassificationCode',{:codeList=>'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_ClassificationCode',
											 :codeListValue=>"#{codeName}",
											 :codeSpace=>"#{codeID}"})
	end

end





