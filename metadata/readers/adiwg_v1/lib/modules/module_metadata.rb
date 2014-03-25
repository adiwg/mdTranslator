# unpack metadataxx
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-22 original script
#   Stan Smith 2013-09-23 added distributor info section
#   Stan Smith 2013-11-26 added metadataxx maintenance section
#   Stan Smith 2013-11-26 added hierarchy section
#   Stan Smith 2013-11-26 added data quality section
#   Stan Smith 2013-12-27 added parent identifier

require Rails.root + 'metadataxx/internal/internal_metadata_obj'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_dataIdentification'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_responsibleParty'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_distributionInfo'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_metadataExtension'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_resourceMaintenance'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_dataQuality'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_dateTime'


module AdiwgV1Metadata

	def self.unpack(metadata)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new

		# instance a new internal object for metadataxx
		intMetadata = intMetadataClass.newMetadata

		# metadataxx - file identifier
		if metadata.has_key?('fileIdentifier')
			s = metadata['fileIdentifier']
			if s != ''
				intMetadata[:fileIdentifier] = s
			end
		end

		# metadataxx - parent identifier
		if metadata.has_key?('parentIdentifier')
			s = metadata['parentIdentifier']
			if s != ''
				intMetadata[:parentIdentifier] = s
			end
		end

		# metadataxx - language
			# fixed to US English and handled in the writer

		# metadataxx - character set
			# fixed to utf8 and handled in the writer

		# metadataxx - hierarchy
		if metadata.has_key?('hierarchyLevel')
			aHierarchy = metadata['hierarchyLevel']
			unless aHierarchy.empty?
				intMetadata[:hierarchies] = aHierarchy
			end
		end

		# metadataxx - metadataxx contacts, custodians
		if metadata.has_key?('contact')
			aCust = metadata['contact']
			unless aCust.empty?
				aCust.each do |rParty|
					intMetadata[:metadataCustodians] << AdiwgV1ResponsibleParty.unpack(rParty)
				end
			end
		end

		# metadataxx - date stamp
		if metadata.has_key?('dateStamp')
			s = metadata['dateStamp']
			if s != ''
				intMetadata[:metadataDate] = AdiwgV1DateTime.unpack(s)
			end
		end

		# metadataxx - dataset URI
		if metadata.has_key?('dataSetURI')
			s = metadata['dataSetURI']
			if s != ''
				intMetadata[:datasetURI] = s
			end
		end

		# metadataxx - reference system info
		if metadata.has_key?('spatialReference')
			aRSystems = metadata['spatialReference']
			unless aRSystems.empty?
				aRSystems.each do |s|
					intMetadata[:referenceSystems] << s
				end
			end

		end

		# metadataxx - extension info - biological extension
		if metadata.has_key?('identificationInfo')
			dataInfo = metadata['identificationInfo']
			if dataInfo.has_key?('taxonomy')
				hTaxonomy = dataInfo['taxonomy']
				unless hTaxonomy.empty?
					intMetadata[:extensions] << AdiwgV1MetadataExtension.addExtensionISObio
				end
			end
		end

		# metadataxx - data identification info
		if metadata.has_key?('identificationInfo')
			dataInfo = metadata['identificationInfo']
			intMetadata[:dataIdentification] = AdiwgV1DataIdentification.unpack(dataInfo)
		end

		# metadataxx - content info

		# metadataxx - distribution info
		if metadata.has_key?('distributionInfo')
			aDistributors = metadata['distributionInfo']
			unless aDistributors.empty?
				aDistributors.each do |hDistributor|
					intMetadata[:distributorInfo] << AdiwgV1DistributionInfo.unpack(hDistributor)
				end
			end
		end

		# metadataxx - data quality info
		if metadata.has_key?('dataQualityInfo')
			aDataQual = metadata['dataQualityInfo']
			unless aDataQual.empty?
				aDataQual.each do |hDQ|
					intMetadata[:dataQualityInfo] << AdiwgV1DataQuality.unpack(hDQ)
				end
			end
		end

		# metadataxx - metadataxx maintenance info
		if metadata.has_key?('metadataMaintenance')
			hMetaMaint = metadata['metadataMaintenance']
			unless hMetaMaint.empty?
				intMetadata[:maintInfo] = AdiwgV1ResourceMaintenance.unpack(hMetaMaint)
			end
		end

		return intMetadata
	end

end
