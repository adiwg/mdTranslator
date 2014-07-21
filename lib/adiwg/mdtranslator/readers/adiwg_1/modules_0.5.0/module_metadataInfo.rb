# unpack metadata information block
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-04-24 original script - moved from module_metadata
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module

require ADIWG::Mdtranslator.reader_module('module_responsibleParty', $jsonVersion)
require ADIWG::Mdtranslator.reader_module('module_dateTime', $jsonVersion)
require ADIWG::Mdtranslator.reader_module('module_resourceMaintenance', $jsonVersion)
require ADIWG::Mdtranslator.reader_module('module_metadataExtension', $jsonVersion)

module Adiwg_MetadataInfo

	def self.unpack(hMetadata)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intMetadataInfo = intMetadataClass.newMetadataInfo
		hMetadataInfo = hMetadata['metadataInfo']

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
					intMetadataInfo[:metadataCustodians] << Adiwg_ResponsibleParty.unpack(rParty)
				end
			end
		end

		# metadata - creation date
		if hMetadataInfo.has_key?('metadataCreationDate')
			s = hMetadataInfo['metadataCreationDate']
			if s != ''
				hDateTime = Adiwg_DateTime.unpack(s)
				hDateTime[:dateType] = 'publication'
				intMetadataInfo[:metadataCreateDate] = hDateTime
			end
		end

		# metadata - date of last metadata update
		if hMetadataInfo.has_key?('metadataLastUpdate')
			s = hMetadataInfo['metadataLastUpdate']
			if s != ''
				hDateTime = Adiwg_DateTime.unpack(s)
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
				intMetadataInfo[:maintInfo] = Adiwg_ResourceMaintenance.unpack(hMetaMaint)
			end
		end

		# metadata - extension info - if biological extension
		if hMetadata.has_key?('resourceInfo')
		resourceInfo = hMetadata['resourceInfo']
			if resourceInfo.has_key?('taxonomy')
				hTaxonomy = resourceInfo['taxonomy']
				unless hTaxonomy.empty?
					intMetadataInfo[:extensions] << Adiwg_MetadataExtension.addExtensionISObio
				end
			end
		end

		return intMetadataInfo

	end

end
