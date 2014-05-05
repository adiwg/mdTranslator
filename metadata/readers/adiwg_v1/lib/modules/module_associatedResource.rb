# unpack associated resource
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-05-02 original script

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_citation'

module AdiwgV1AssociatedResource

	def self.unpack(hAssocRes)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intAssocRes = intMetadataClass.newAssociatedResource

		# associated resource - resource type - initiativeTypeCode
		if hAssocRes.has_key?('associationType')
			s = hAssocRes['associationType']
			if s != ''
				intAssocRes[:associationType] = s
			end
		end

		# associated resource - association type - associationTypeCode
		if hAssocRes.has_key?('resourceType')
			s = hAssocRes['resourceType']
			if s != ''
				intAssocRes[:resourceType] = s
			end
		end

		# associated resource - resource citation
		if hAssocRes.has_key?('resourceCitation')
			hCitation = hAssocRes['resourceCitation']
			unless hCitation.empty?
				intAssocRes[:resourceCitation] = AdiwgV1Citation.unpack(hCitation)
			end
		end

		return intAssocRes
	end

end
