# ISO <<CodeLists>> gmd:MD_ProgressCode

# from http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml
# History:
# 	Stan Smith 2013-08-26 original script
#   Stan Smith 2014-10-15 allow non-ISO codesNames to be rendered

class MD_ProgressCode
	def initialize(xml)
		@xml = xml
	end

	def writeXML(codeName)

		case(codeName)
			when 'completed' then codeID = '001'
			when 'historicalArchive' then codeID = '002'
			when 'obsolete' then codeID = '003'
			when 'onGoing' then codeID = '004'
			when 'planned' then codeID = '005'
			when 'required' then codeID = '006'
			when 'underDevelopment' then codeID = '007'
			else
				codeID = 'non-ISO codeName'
		end

		# write xml
		@xml.tag!('gmd:MD_ProgressCode',{:codeList=>'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#CI_ProgressCode',
									 :codeListValue=>"#{codeName}",
									 :codeSpace=>"#{codeID}"})
	end

end
