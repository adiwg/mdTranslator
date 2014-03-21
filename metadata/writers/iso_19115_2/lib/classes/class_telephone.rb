# ISO <<Class>> CI_Telephone
# writer output in XML

# History:
# 	Stan Smith 2013-08-12 original script

require 'builder'

class CI_Telephone

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hPhoneBook)

		aVoiceLines = hPhoneBook[:voice]
		aFaxLines = hPhoneBook[:fax]
		voiceLines = aVoiceLines.length
		faxLines = aFaxLines.length

		if voiceLines + faxLines > 0
			@xml.tag!('gmd:CI_Telephone') do

				# telephone - voice
				if !aVoiceLines.empty?
					aVoiceLines.each do |phone|
						pName = phone[:phoneName]
						pNumber = phone[:phoneNumber]
						if pName.nil?
							s = pNumber
						else
							s = pName + ': ' + pNumber
						end
						@xml.tag!('gmd:voice') do
							@xml.tag!('gco:CharacterString',s)
						end
					end
				elsif $showEmpty
					@xml.tag!('gmd:voice')
				end

				# telephone - fax
				if !aFaxLines.empty?
					aFaxLines.each do |phone|
						pName = phone[:phoneName]
						pNumber = phone[:phoneNumber]
						if pName.nil?
							s = pNumber
						else
							s = pName + ': ' + pNumber
						end
						@xml.tag!('gmd:facsimile') do
							@xml.tag!('gco:CharacterString',s)
						end
					end
				elsif $showEmpty
					@xml.tag!('gmd:facsimile')
				end

			end

		end

	end

end