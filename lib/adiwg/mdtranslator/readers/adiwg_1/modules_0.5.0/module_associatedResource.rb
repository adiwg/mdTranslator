# unpack associated resource
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-05-02 original script
# 	Stan Smith 2014-05-28 added resource identifier section
# 	Stan Smith 2014-06-02 added resource metadata citation section
#   Stan Smith 2014-07-08 resolve require statements using Mdtranslator.reader_module

require ADIWG::Mdtranslator.reader_module('module_citation', $jsonVersion)
require ADIWG::Mdtranslator.reader_module('module_resourceIdentifier', $jsonVersion)

module Adiwg_AssociatedResource

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
				intAssocRes[:resourceCitation] = Adiwg_Citation.unpack(hCitation)

				# associated resource - resource identifier
				# resource identifiers reference the citation,
				# ... they are only valid if there is a citation
				if hAssocRes.has_key?('resourceIdentifier')
					aResID = hAssocRes['resourceIdentifier']
					unless aResID.empty?
						aResID.each do |resID|
							intAssocRes[:resourceCitation][:citResourceIDs] << Adiwg_ResourceIdentifier.unpack(resID)
						end
					end
				end
			end
		end

		# associated resource - metadata citation
		if hAssocRes.has_key?('metadataCitation')
			hCitation = hAssocRes['metadataCitation']
			unless hCitation.empty?
				intAssocRes[:metadataCitation] = Adiwg_Citation.unpack(hCitation)
			end
		end

		return intAssocRes
	end

end
