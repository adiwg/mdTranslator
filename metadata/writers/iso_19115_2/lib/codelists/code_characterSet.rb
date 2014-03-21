# ISO <<CodeLists>> gmd:MD_CharacterSetCode

# from http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml
# History:
# 	Stan Smith 2013-08-09 original script

require 'builder'

class MD_CharacterSetCode
	def initialize(xml)
		@xml = xml
	end

	def writeXML(codeName)
		case(codeName)
			when 'ucs2' then codeID = '001'
			when 'ucs4' then codeID = '002'
			when 'utf7' then codeID = '003'
			when 'utf8' then codeID = '004'
			when 'utf16' then codeID = '005'
			when '8859part1' then codeID = '006'
			when '8859part2' then codeID = '007'
			when '8859part3' then codeID = '008'
			when '8895part4' then codeID = '009'
			when '8859part5' then codeID = '010'
			when '8859part6' then codeID = '011'
			when '8859part7' then codeID = '012'
			when '8859part8' then codeID = '013'
			when '8859part9' then codeID = '014'
			when '8859part10' then codeID = '015'
			when '8859part11' then codeID = '016'
			when '8859part13' then codeID = '018'
			when '8859part14' then codeID = '019'
			when '8859part15' then codeID = '020'
			when '8859part16' then codeID = '021'
			when 'jis' then codeID = '022'
			when 'shiftJIS' then codeID = '023'
			when 'eusJP' then codeID = '024'
			when 'usAscii' then codeID = '025'
			when 'ebcdic' then codeID = '026'
			when 'ecuKR' then codeID = '027'
			when 'big5' then codeID = '028'
			when 'GB2312' then codeID = '029'
			else
				codeName = 'INVALID CHARACTER SET'
				codeID = '999'
		end

		# write xml
		@xml.tag!('gmd:MD_CharacterSetCode',{:codeList=>'http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_CharacterSetCode',
											 :codeListValue=>"#{codeName}",
											 :codeSpace=>"#{codeID}"})
	end

end





