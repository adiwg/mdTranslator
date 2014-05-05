# unpack metadata information block
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-04-24 original script - moved from module_metadata

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_responsibleParty'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_dateTime'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_resourceMaintenance'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_metadataExtension'

module AdiwgV1MetadataInfo

	def self.unpack(hMetadataInfo)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intMetadataInfo = intMetadataClass.newMetadataInfo

		# metadata - metadata identifier
		if hMetadataInfo.has_key?('metadataIdentifier')
			s = hMetadataInfo['metadataIdentifier']
			if s != ''
				intMetadataInfo[:metadataId] = s
			end
		end

		# metadata - parent metadata identifier
		if hMetadataInfo.has_key?('parentMetadataIdentifier')
			s = hMetadataInfo['parentMetadataIdentifier']
			if s != ''
				intMetadataInfo[:parentMetadataId] = s
			end
		end

		# metadata - scope - from codeList
		if hMetadataInfo.has_key?('metadataScope')
			aMetadataScope = hMetadataInfo['metadataScope']
			unless aMetadataScope.empty?
				intMetadataInfo[:metadataScope] = aMetadataScope
			end
		end

		# metadata - metadata contacts, custodians
		if hMetadataInfo.has_key?('metadataContact')
			aCust = hMetadataInfo['metadataContact']
			unless aCust.empty?
				aCust.each do |rParty|
					intMetadataInfo[:metadataCustodians] << AdiwgV1ResponsibleParty.unpack(rParty)
				end
			end
		end

		# metadata - creation date
		if hMetadataInfo.has_key?('metadataCreationDate')
			s = hMetadataInfo['metadataCreationDate']
			if s != ''
				hDateTime = AdiwgV1DateTime.unpack(s)
				hDateTime[:dateType] = 'publication'
				intMetadataInfo[:metadataCreateDate] = hDateTime
			end
		end

		# metadata - date of last metadata update
		if hMetadataInfo.has_key?('metadataLastUpdate')
			s = hMetadataInfo['metadataLastUpdate']
			if s != ''
				hDateTime = AdiwgV1DateTime.unpack(s)
				hDateTime[:dateType] = 'revision'
				intMetadataInfo[:metadataUpdateDate] = hDateTime
			end
		end

		# metadata - metadata URI
		if hMetadataInfo.has_key?('metadataUri')
			s = hMetadataInfo['metadataUri']
			if s != ''
				intMetadataInfo[:metadataURI] = s
			end
		end

		# metadata - status
		if hMetadataInfo.has_key?('metadataStatus')
			s = hMetadataInfo['metadataStatus']
			if s != ''
				intMetadataInfo[:metadataStatus] = s
			end
		end

		# metadata - metadata maintenance info
		if hMetadataInfo.has_key?('metadataMaintenance')
			hMetaMaint = hMetadataInfo['metadataMaintenance']
			unless hMetaMaint.empty?
				intMetadataInfo[:maintInfo] = AdiwgV1ResourceMaintenance.unpack(hMetaMaint)
			end
		end

		# metadata - extension info - if biological extension
		if hMetadataInfo.has_key?('resourceInfo')
		resourceInfo = hMetadataInfo['resourceInfo']
			if resourceInfo.has_key?('taxonomy')
				hTaxonomy = resourceInfo['taxonomy']
				unless hTaxonomy.empty?
					intMetadataInfo[:extensions] << AdiwgV1MetadataExtension.addExtensionISObio
				end
			end
		end

		return intMetadataInfo

	end

end
