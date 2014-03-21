# ISO <<CodeLists>> gmd:MD_MediumFormatCode

# from http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml
# History:
# 	Stan Smith 2013-09-24 original script

require 'builder'

class MD_MediumFormatCode

	def initialize(xml)
		@xml = xml
	end

	def writeXML(codeName)
		case(codeName)
			when 'cpio' then codeID = '001'
			when 'tar' then codeID = '002'
			when 'highSierra' then codeID = '003'
			when 'iso9660' then codeID = '004'
			when 'iso9660RockRidge' then codeID = '005'
			when 'iso9660AppleHFS' then codeID = '006'
			else
				codeName = 'INVALID MEDIUM FORMAT TYPE'
				codeID = '999'
		end

		# write xml
		@xml.tag!('gmd:MD_MediumFormatCode',{:codeList=>'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_MediumFormatCode',
										    :codeListValue=>"#{codeName}",
										    :codeSpace=>"#{codeID}"})
	end

end