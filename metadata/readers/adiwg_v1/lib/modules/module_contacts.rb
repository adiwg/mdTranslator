# unpack contacts
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-20 original script
# 	Stan Smith 2013-09-25 moved onlineResource to new module
# 	Stan Smith 2013-10-21 moved address to new module
#	Stan Smith 2014-04-23 modify for json schema version 0.3.0
#   Stan Smith 2014-04-24 split default contacts to a separate method
#   Stan Smith 2014-05-14 combine phone service types

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_address'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_onlineResource'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_phone'

module AdiwgV1Contact

	def self.unpack(hContact)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intCont = intMetadataClass.newContact

		# contact ID
		if hContact.has_key?('contactId')
			s = hContact['contactId']
			if s != ''
				intCont[:contactID] = s
			end
		end

		# individual name
		if hContact.has_key?('individualName')
			s = hContact['individualName']
			if s != ''
				intCont[:indName] = s
			end
		end

		# organization name
		if hContact.has_key?('organizationName')
			s = hContact['organizationName']
			if s != ''
				intCont[:orgName] = s
			end
		end

		# position name
		if hContact.has_key?('positionName')
			s = hContact['positionName']
			if s != ''
				intCont[:position] = s
			end
		end

		# online resources
		if hContact.has_key?('onlineResource')
			aOlRes = hContact['onlineResource']
			aOlRes.each do |hOlRes|
				unless hOlRes.empty?
					intCont[:onlineRes] << AdiwgV1OnlineResource.unpack(hOlRes)
				end
			end
		end

		# contact instructions
		if hContact.has_key?('contactInstructions')
			s = hContact['contactInstructions']
			if s != ''
				intCont[:contactInstructions] = s
			end
		end

		# phones - all service types
		if hContact.has_key?('phoneBook')
			aPhones = hContact['phoneBook']
			aPhones.each do |hPhone|
				intCont[:phones].concat(AdiwgV1Phone.unpack(hPhone))
			end
		end

		# address
		if hContact.has_key?('address')
			conAddress = hContact['address']
			intCont[:address] = AdiwgV1Address.unpack(conAddress)
		end

		return intCont

	end

	def self.setDefaultContacts()

		# add default contacts
		intMetadataClass = InternalMetadata.new
		aDefContacts = Array.new

		# contact to support biological extensions
		intCont = intMetadataClass.newContact
		intCont[:contactID] = 'ADIwgBio'
		intCont[:orgName] = 'National Biological Information Infrastructure (NBII)'
		aDefContacts << intCont

		# contact to support doi (digital object identifier)
		intCont = intMetadataClass.newContact
		intCont[:contactID] = 'ADIwgDOI'
		intCont[:orgName] = 'International DOI Foundation (IDF)'

		intOlRes = intMetadataClass.newOnlineResource
		intOlRes[:olResLink] = 'http://www.doi.org'
		intCont[:onlineRes] << intOlRes

		aDefContacts << intCont

		return aDefContacts

	end


end