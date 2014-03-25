# unpack responsible party
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-26 original script

require Rails.root + 'metadataxx/internal/internal_metadata_obj'

module AdiwgV1ResponsibleParty

	def self.unpack(hRParty)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intContactById = intMetadataClass.newContactById

		# responsible party - contact
		if hRParty.has_key?('contactId')
			s = hRParty['contactId']
			if s != ''
				intContactById[:contactID] = s
			end
		end

		# responsible party - role - required
		if hRParty.has_key?('role')
			s = hRParty['role']
			if s != ''
				intContactById[:roleName] = s
			end
		end
		intContactById

		return intContactById
	end

end
