# unpack metadata
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-22 original script
#   Stan Smith 2013-09-23 added distributor info section
#   Stan Smith 2013-11-26 added metadata maintenance section
#   Stan Smith 2013-11-26 added hierarchy section
#   Stan Smith 2013-11-26 added data quality section
#   Stan Smith 2013-12-27 added parent identifier
#   Stan Smith 2014-04-24 reorganized for json schema 0.3.0
#   Stan Smith 2014-05-02 added associated resources
#   Stan Smith 2014-05-02 added additional documentation
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module

require ADIWG::Mdtranslator.reader_module('module_metadataInfo', $response[:readerVersionUsed])
require ADIWG::Mdtranslator.reader_module('module_resourceInfo', $response[:readerVersionUsed])
require ADIWG::Mdtranslator.reader_module('module_distributionInfo', $response[:readerVersionUsed])
require ADIWG::Mdtranslator.reader_module('module_associatedResource', $response[:readerVersionUsed])
require ADIWG::Mdtranslator.reader_module('module_citation', $response[:readerVersionUsed])

module Adiwg_Metadata

	def self.unpack(hMetadata)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intMetadata = intMetadataClass.newMetadata

		# metadata - metadataInfo
		# metadataInfo needs access to resourceInfo to check taxonomy
		if hMetadata.has_key?('metadataInfo')
			intMetadata[:metadataInfo] = Adiwg_MetadataInfo.unpack(hMetadata)
		end

		# metadata - resource identification info
		if hMetadata.has_key?('resourceInfo')
			hResourceInfo = hMetadata['resourceInfo']
			intMetadata[:resourceInfo] = Adiwg_ResourceInfo.unpack(hResourceInfo)
		end

		# metadata - distribution info
		if hMetadata.has_key?('distributionInfo')
			aDistributors = hMetadata['distributionInfo']
			unless aDistributors.empty?
				aDistributors.each do |hDistributor|
					intMetadata[:distributorInfo] << Adiwg_DistributionInfo.unpack(hDistributor)
				end
			end
		end

		# metadata - associated resources
		if hMetadata.has_key?('associatedResource')
			aAssocRes = hMetadata['associatedResource']
			unless aAssocRes.empty?
				aAssocRes.each do |hAssocRes|
					intMetadata[:associatedResources] << Adiwg_AssociatedResource.unpack(hAssocRes)
				end
			end
		end

		# metadata - additional documents
		if hMetadata.has_key?('additionalDocumentation')
			aCitation = hMetadata['additionalDocumentation']
			unless aCitation.empty?
				aCitation.each do |hCitation|
					intMetadata[:additionalDocuments] << Adiwg_Citation.unpack(hCitation)
				end
			end
		end

		return intMetadata

	end

end
