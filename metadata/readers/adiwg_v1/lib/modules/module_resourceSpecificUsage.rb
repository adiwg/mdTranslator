# unpack resource specific usage
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-25 original script
# 	Stan Smith 2013-11-27 modified to process a single resource usage

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_responsibleParty'

module AdiwgV1ResourceSpecificUsage

	def self.unpack(hUsage)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intUsage = intMetadataClass.newDataUsage

		# resource specific usage - specific usage
		if hUsage.has_key?('specificUsage')
			s = hUsage['specificUsage']
			if s != ''
				intUsage[:specificUsage] = s
			end
		end

		# resource specific usage - user determined limitations
		if hUsage.has_key?('userDeterminedLimitations')
			s = hUsage['userDeterminedLimitations']
			if s != ''
				intUsage[:userLimits] = s
			end
		end

		# taxonomy - repository - responsible party
		if hUsage.has_key?('userContactInfo')
			aContacts = hUsage['userContactInfo']
			unless aContacts.empty?
				aContacts.each do |hContact|
					intUsage[:userContacts] << AdiwgV1ResponsibleParty.unpack(hContact)
				end
			end
		end

		return intUsage

	end

end
