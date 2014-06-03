# unpack resource identifier
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-05-28 original script

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_citation'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_responsibleParty'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_onlineResource'

module AdiwgV1ResourceIdentifier

	def self.unpack(hResID)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intResID = intMetadataClass.newResourceId

		# resource identifier - identifier
		if hResID.has_key?('identifier')
			s = hResID['identifier']
			if s != ''
				intResID[:identifier] = s
			end
		end

		# resource identifier - authority (expressed as a citation)
		intResID[:identifierCitation] =  AdiwgV1Citation.unpack(hResID)

		return intResID

	end

end