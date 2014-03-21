# ISO <<CodeLists>> gmd:MD_MaintenanceFrequencyCode

# from http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml
# History:
# 	Stan Smith 2013-10-21 original script

require 'builder'

class MD_MaintenanceFrequencyCode
	def initialize(xml)
		@xml = xml
	end

	def writeXML(codeName)
		case(codeName)
			when 'continual' then codeID = '001'
			when 'daily' then codeID = '002'
			when 'weekly' then codeID = '003'
			when 'fortnightly' then codeID = '004'
			when 'monthly' then codeID = '005'
			when 'quarterly' then codeID = '006'
			when 'biannually' then codeID = '007'
			when 'annually' then codeID = '008'
			when 'asNeeded' then codeID = '009'
			when 'irregular' then codeID = '010'
			when 'notPlanned' then codeID = '011'
			when 'unknown' then codeID = '012'
			else
				codeName = 'INVALID MAINTENANCE FREQUENCY'
				codeID = '999'
		end

		# write xml
		@xml.tag!('gmd:MD_MaintenanceFrequencyCode',{:codeList=>'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_MaintenanceFrequencyCode',
											 :codeListValue=>"#{codeName}",
											 :codeSpace=>"#{codeID}"})
	end

end





