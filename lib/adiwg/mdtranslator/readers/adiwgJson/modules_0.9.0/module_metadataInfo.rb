# unpack metadata information block
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-04-24 original script - moved from module_metadata
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-09-19 changed metadata identifier type resource identifier json 0.8.0
#   Stan Smith 2014-09-19 changed parent metadata identifier type citation json 0.8.0
#   Stan Smith 2014-11-06 removed metadataScope, moved to resourceType under resourceInfo json 0.9.0

require ADIWG::Mdtranslator.reader_module('module_responsibleParty', $response[:readerVersionUsed])
require ADIWG::Mdtranslator.reader_module('module_dateTime', $response[:readerVersionUsed])
require ADIWG::Mdtranslator.reader_module('module_resourceMaintenance', $response[:readerVersionUsed])
require ADIWG::Mdtranslator.reader_module('module_metadataExtension', $response[:readerVersionUsed])
require ADIWG::Mdtranslator.reader_module('module_resourceIdentifier', $response[:readerVersionUsed])
require ADIWG::Mdtranslator.reader_module('module_citation', $response[:readerVersionUsed])

module Adiwg_MetadataInfo

	def self.unpack(hMetadata)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intMetadataInfo = intMetadataClass.newMetadataInfo
		hMetadataInfo = hMetadata['metadataInfo']

		# metadata - metadata identifier
		if hMetadataInfo.has_key?('metadataIdentifier')
			hMetadataId = hMetadataInfo['metadataIdentifier']
			unless hMetadataId.empty?
				intMetadataInfo[:metadataId] = Adiwg_ResourceIdentifier.unpack(hMetadataId)
			end
		end

		# metadata - parent metadata identifier
		if hMetadataInfo.has_key?('parentMetadata')
			hParent = hMetadataInfo['parentMetadata']
			unless hParent.empty?
				intMetadataInfo[:parentMetadata] = Adiwg_Citation.unpack(hParent)
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
