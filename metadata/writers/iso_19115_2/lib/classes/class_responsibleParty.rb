# ISO <<Class>> CI_ResponsibleParty
# writer output in XML

# History:
# 	Stan Smith 2013-08-13 original script

require 'builder'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_contact'
require Rails.root + 'metadata/writers/iso_19115_2/lib/codelists/code_role'

class CI_ResponsibleParty

	def initialize(xml)
		@xml = xml
	end

	def writeXML(rParty)

		# classes used in MD_Metadata
		ciContactClass = CI_Contact.new(@xml)
		ciRoleCode = CI_RoleCode.new(@xml)

		# search array of responsible party for matches in contact object
		rpID = rParty[:contactID]
		unless rpID.nil?
			$intContactList.each do |contact|
				if contact[:contactID] == rpID
					@xml.tag!('gmd:CI_ResponsibleParty') do
						# responsible party - individual name
						s = contact[:indName]
						if !s.nil?
							@xml.tag!('gmd:individualName') do
								@xml.tag!('gco:CharacterString', contact[:indName])
							end
						elsif $showEmpty
							@xml.tag!('gmd:individualName')
						end

						# responsible party - organization name
						s = contact[:orgName]
						if !s.nil?
							@xml.tag!('gmd:organisationName') do
								@xml.tag!('gco:CharacterString', contact[:orgName])
							end
						elsif $showEmpty
							@xml.tag!('gmd:organisationName')
						end

						# responsible party - position name
						s = contact[:position]
						if !s.nil?
							@xml.tag!('gmd:positionName') do
								@xml.tag!('gco:CharacterString', contact[:position])
							end
						elsif $showEmpty
							@xml.tag!('gmd:positionName')
						end

						# responsible party - contact info
						# the remaining contact elements belong to CI_ResponsibleParty
						if !(contact[:voicePhones].empty? &&
						 	 contact[:faxPhones].empty? &&
						 	 contact[:smsPhones].empty? &&
						 	 contact[:address].empty? &&
							 contact[:onlineRes].empty? &&
							 contact[:contactInstructions].nil?)
							@xml.tag!('gmd:contactInfo') do
								ciContactClass.writeXML(contact)
							end
						elsif $showEmpty
							@xml.tag!('gmd:contactInfo')
						end


						# responsible party - role - required
						s = rParty[:roleName]
						if s.nil?
							xml.tag!('gmd:role', {'gco:nilReason' => 'missing'})
						else
							@xml.tag! 'gmd:role' do
								ciRoleCode.writeXML(s)
							end
						end

					end
				end
			end
		end

	end

end
