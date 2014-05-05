# unpack responsible party
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-26 original script

require Rails.root + 'metadata/internal/internal_metadata_obj'

module AdiwgV1ResponsibleParty

	def self.unpack(hRParty)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intContactById = intMetadataClass.newRespParty

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

		# responsible party - resource ids
		if hRParty.has_key?('resourceIdentifier')
			aResIds = hRParty['resourceIdentifier']
			unless aResIds.empty?
				aResIds.each do |hResId|
					unless hResId.empty?
						intResId = intMetadataClass.newResourceId
						if hResId.has_key?('identifierName')
							s = hResId['identifierName']
							if s != ''
								intResId[:identifierName] = s
							end
						end
						if hResId.has_key?('identifier')
							s = hResId['identifier']
							if s != ''
								intResId[:identifier] = s
							end
						end
						intContactById[:resourceId] << intResId
					end
				end
			end
		end

		return intContactById
	end

end
