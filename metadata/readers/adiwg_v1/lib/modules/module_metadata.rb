# unpack metadata
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-22 original script
#   Stan Smith 2013-09-23 added distributor info section
#   Stan Smith 2013-11-26 added metadata maintenance section
#   Stan Smith 2013-11-26 added hierarchy section
#   Stan Smith 2013-11-26 added data quality section
#   Stan Smith 2013-12-27 added parent identifier

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_dataIdentification'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_responsibleParty'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_distributionInfo'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_metadataExtension'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_resourceMaintenance'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_dataQuality'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_dateTime'


module AdiwgV1Metadata

	def self.unpack(metadata)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new

		# instance a new internal object for metadata
		intMetadata = intMetadataClass.newMetadata

		# metadata - file identifier
		if metadata.has_key?('fileIdentifier')
			s = metadata['fileIdentifier']
			if s != ''
				intMetadata[:fileIdentifier] = s
			end
		end

		# metadata - parent identifier
		if metadata.has_key?('parentIdentifier')
			s = metadata['parentIdentifier']
			if s != ''
				intMetadata[:parentIdentifier] = s
			end
		end

		# metadata - language
			# fixed to US English and handled in the writer

		# metadata - character set
			# fixed to utf8 and handled in the writer

		# metadata - hierarchy
		if metadata.has_key?('hierarchyLevel')
			aHierarchy = metadata['hierarchyLevel']
			unless aHierarchy.empty?
				intMetadata[:hierarchies] = aHierarchy
			end
		end

		# metadata - metadata contacts, custodians
		if metadata.has_key?('contact')
			aCust = metadata['contact']
			unless aCust.empty?
				aCust.each do |rParty|
					intMetadata[:metadataCustodians] << AdiwgV1ResponsibleParty.unpack(rParty)
				end
			end
		end

		# metadata - date stamp
		if metadata.has_key?('dateStamp')
			s = metadata['dateStamp']
			if s != ''
				intMetadata[:metadataDate] = AdiwgV1DateTime.unpack(s)
			end
		end

		# metadata - dataset URI
		if metadata.has_key?('dataSetURI')
			s = metadata['dataSetURI']
			if s != ''
				intMetadata[:datasetURI] = s
			end
		end

		# metadata - reference system info
		if metadata.has_key?('spatialReference')
			aRSystems = metadata['spatialReference']
			unless aRSystems.empty?
				aRSystems.each do |s|
					intMetadata[:referenceSystems] << s
				end
			end

		end

		# metadata - extension info - biological extension
		if metadata.has_key?('identificationInfo')
			dataInfo = metadata['identificationInfo']
			if dataInfo.has_key?('taxonomy')
				hTaxonomy = dataInfo['taxonomy']
				unless hTaxonomy.empty?
					intMetadata[:extensions] << AdiwgV1MetadataExtension.addExtensionISObio
				end
			end
		end

		# metadata - data identification info
		if metadata.has_key?('identificationInfo')
			dataInfo = metadata['identificationInfo']
			intMetadata[:dataIdentification] = AdiwgV1DataIdentification.unpack(dataInfo)
		end

		# metadata - content info

		# metadata - distribution info
		if metadata.has_key?('distributionInfo')
			aDistributors = metadata['distributionInfo']
			unless aDistributors.empty?
				aDistributors.each do |hDistributor|
					intMetadata[:distributorInfo] << AdiwgV1DistributionInfo.unpack(hDistributor)
				end
			end
		end

		# metadata - data quality info
		if metadata.has_key?('dataQualityInfo')
			aDataQual = metadata['dataQualityInfo']
			unless aDataQual.empty?
				aDataQual.each do |hDQ|
					intMetadata[:dataQualityInfo] << AdiwgV1DataQuality.unpack(hDQ)
				end
			end
		end

		# metadata - metadata maintenance info
		if metadata.has_key?('metadataMaintenance')
			hMetaMaint = metadata['metadataMaintenance']
			unless hMetaMaint.empty?
				intMetadata[:maintInfo] = AdiwgV1ResourceMaintenance.unpack(hMetaMaint)
			end
		end

		return intMetadata
	end

end
