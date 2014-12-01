# unpack responsible party
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-26 original script
#   Stan Smith 2014-05-28 modified to support JSON schema 0.5.0
#   ... removed resource IDs associated with contact

module Md_ResponsibleParty

	def self.unpack(hRParty)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intResById = intMetadataClass.newRespParty

		# responsible party - contact
		if hRParty.has_key?('contactId')
			s = hRParty['contactId']
			if s != ''
				intResById[:contactID] = s
			end
		end

		# responsible party - role - required
		if hRParty.has_key?('role')
			s = hRParty['role']
			if s != ''
				intResById[:roleName] = s
			end
		end

		return intResById

	end

end
