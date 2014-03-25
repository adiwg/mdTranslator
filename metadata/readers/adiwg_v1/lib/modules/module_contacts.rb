# unpack contacts
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-20 original script
# 	Stan Smith 2013-09-25 moved onlineResource to new module
# 	Stan Smith 2013-10-21 moved address to new module

require Rails.root + 'metadataxx/internal/internal_metadata_obj'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_address'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_onlineResource'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_phone'

module AdiwgV1Contacts

	def self.unpack(contacts)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		aContacts = Array.new

		# add default contacts
		# ... contacts to support metadataxx extensions
		intCont = intMetadataClass.newContact
		intCont[:contactID] = 'ADIwgBio'
		intCont[:orgName] = 'National Biological Information Infrastructure (NBII)'
		aContacts << intCont

		# step through each contact
		# ... and load each into an internal contact container
		contacts.each do |contact|

			# create a new contact container
			intCont = intMetadataClass.newContact

			# contact ID
			if contact.has_key?('contactId')
				s = contact['contactId']
				if s != ''
					intCont[:contactID] = s
				end
			end

			# individual name
			if contact.has_key?('individualName')
				s = contact['individualName']
				if s != ''
					intCont[:indName] = s
				end
			end

			# organization name
			if contact.has_key?('organizationName')
				s = contact['organizationName']
				if s != ''
					intCont[:orgName] = s
				end
			end

			# position name
			if contact.has_key?('positionName')
				s = contact['positionName']
				if s != ''
					intCont[:position] = s
				end
			end

			# phones - voice
			if contact.has_key?('voice')
				aVoicePhones = contact['voice']
				aVoicePhones.each do |hPhone|
					unless hPhone.empty?
						intCont[:voicePhones] << AdiwgV1Phone.unpack(hPhone)
					end
				end
			end

			# phones - fax
			if contact.has_key?('fax')
				aFaxPhones = contact['fax']
				aFaxPhones.each do |hPhone|
					unless hPhone.empty?
						intCont[:faxPhones] << AdiwgV1Phone.unpack(hPhone)
					end
				end
			end

			# phones - sms
			if contact.has_key?('sms')
				aSMSPhones = contact['sms']
				aSMSPhones.each do |hPhone|
					unless hPhone.empty?
						intCont[:smsPhones] << AdiwgV1Phone.unpack(hPhone)
					end
				end
			end

			# address
			if contact.has_key?('address')
				conAddress = contact['address']
				intCont[:address] = AdiwgV1Address.unpack(conAddress)
			end

			# online resources
			if contact.has_key?('onlineResource')
				olResource = contact['onlineResource']
				intCont[:onlineRes] = AdiwgV1OnlineResource.unpack(olResource)
			end

			# contact instructions
			if contact.has_key?('contactInstructions')
				s = contact['contactInstructions']
				if s != ''
					intCont[:contactInstructions] = s
				end
			end

			# add contact to contact array
			aContacts << intCont

		end # end contacts

		return aContacts
	end

end