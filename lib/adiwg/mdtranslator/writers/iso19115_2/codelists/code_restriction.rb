# ISO <<CodeLists>> gmd:MD_RestrictionCode

# from http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml
# History:
# 	Stan Smith 2013-10-21 original script

class MD_RestrictionCode
	def initialize(xml)
		@xml = xml
	end

	def writeXML(codeName)
		case(codeName)
			when 'copyright' then codeID = '001'
			when 'patent' then codeID = '002'
			when 'patentPending' then codeID = '003'
			when 'trademark' then codeID = '004'
			when 'license' then codeID = '005'
			when 'intellectualPropertyRights' then codeID = '006'
			when 'restricted' then codeID = '007'
			when 'otherRestrictions' then codeID = '008'
			else
				codeName = 'INVALID RESTRICTION'
				codeID = '999'
		end

		# write xml
		@xml.tag!('gmd:MD_RestrictionCode',{:codeList=>'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_RestrictionCode',
											 :codeListValue=>"#{codeName}",
											 :codeSpace=>"#{codeID}"})
	end

end





