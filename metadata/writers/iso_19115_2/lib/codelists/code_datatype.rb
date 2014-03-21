# ISO <<CodeLists>> gmd:MD_DatatypeCode

# from http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml
# History:
# 	Stan Smith 2013-10-21 original script

require 'builder'

class MD_DatatypeCode
	def initialize(xml)
		@xml = xml
	end

	def writeXML(codeName)
		case(codeName)
			when 'class' then codeID = '001'
			when 'codelist' then codeID = '002'
			when 'enumeration' then codeID = '003'
			when 'codelistElement' then codeID = '004'
			when 'abstractClass' then codeID = '005'
			when 'aggregatedClass' then codeID = '006'
			when 'specifiedClass' then codeID = '007'
			when 'datatypeClass' then codeID = '008'
			when 'interfaceClass' then codeID = '009'
			when 'unionClass' then codeID = '010'
			when 'metaClass' then codeID = '011'
			when 'typeClass' then codeID = '012'
			when 'characterString' then codeID = '013'
			when 'integer' then codeID = '014'
			when 'association' then codeID = '015'
			else
				codeName = 'INVALID DATATYPE'
				codeID = '999'
		end

		# write xml
		@xml.tag!('gmd:MD_DatatypeCode',{:codeList=>'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_DatatypeCode',
											 :codeListValue=>"#{codeName}",
											 :codeSpace=>"#{codeID}"})
	end

end





