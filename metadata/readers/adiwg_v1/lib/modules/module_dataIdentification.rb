# unpack data identification
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-22 original script
# 	Stan Smith 2013-11-04 extents
# 	Stan Smith 2013-11-14 legal constraints
# 	Stan Smith 2013-11-20 taxonomy
# 	Stan Smith 2013-11-25 resource specific usage
# 	Stan Smith 2013-11-26 spatial resolution

require Rails.root + 'metadataxx/internal/internal_metadata_obj'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_citation'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_resourceFormat'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_responsibleParty'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_descriptiveKeyword'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_browseGraphic'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_resourceMaintenance'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_extent'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_legalConstraint'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_securityConstraint'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_taxonomy'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_resourceSpecificUsage'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_resolution'

module AdiwgV1DataIdentification

	def self.unpack(dataInfo)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new

		# instance a new internal object for metadataxx
		intDataId = intMetadataClass.newDataId

		# data identification - citation
		if dataInfo.has_key?('citation')
			hCitation = dataInfo['citation']
			intDataId[:citation] = AdiwgV1Citation.unpack(hCitation)
		end

		# data identification - abstract
		if dataInfo.has_key?('abstract')
			s = dataInfo['abstract']
			if s != ''
				intDataId[:abstract] = s
			end
		end

		# data identification - purpose
		if dataInfo.has_key?('purpose')
			s = dataInfo['purpose']
			if s != ''
				intDataId[:purpose] = s
			end
		end

		# data identification - credit
		if dataInfo.has_key?('credit')
			aCredits = dataInfo['credit']
			unless aCredits.empty?
				aCredits.each do |credit|
					intDataId[:credits] << credit
				end
			end
		end

		# data identification - status
		if dataInfo.has_key?('status')
			s = dataInfo['status']
			if s != ''
				intDataId[:status] = s
			end
		end

		# data identification - point of contact
		if dataInfo.has_key?('pointOfContact')
			aPOC = dataInfo['pointOfContact']
			unless aPOC.empty?
				aPOC.each do |rParty|
					intDataId[:pointsOfContact] << AdiwgV1ResponsibleParty.unpack(rParty)
				end
			end
		end

		# data identification - resource maintenance
		if dataInfo.has_key?('resourceMaintenance')
			aResMaint = dataInfo['resourceMaintenance']
			unless aResMaint.empty?
				aResMaint.each do |hResource|
					intDataId[:resourceMaint] << AdiwgV1ResourceMaintenance.unpack(hResource)
				end
			end
		end

		# data identification - graphic overview
		if dataInfo.has_key?('graphicOverview')
			aBrowseGraph = dataInfo['graphicOverview']
			unless aBrowseGraph.empty?
				aBrowseGraph.each do |hBgraphic|
					intDataId[:graphicOverview] << AdiwgV1BrowseGraphic.unpack(hBgraphic)
				end
			end
		end

		# data identification - resource format
		if dataInfo.has_key?('resourceFormat')
			aResFormat = dataInfo['resourceFormat']
			unless aResFormat.empty?
				aResFormat.each do |hResFormat|
					intDataId[:resourceFormats] << AdiwgV1ResourceFormat.unpack(hResFormat)
				end
			end
		end

		# data identification - descriptive keywords
		if dataInfo.has_key?('keywords')
			aDesKeywords = dataInfo['keywords']
			unless aDesKeywords.empty?
				aDesKeywords.each do |hDesKeyword|
					intDataId[:descriptiveKeywords] << AdiwgV1DescriptiveKeyword.unpack(hDesKeyword)
				end
			end
		end

		# data identification - resource specific usage
		if dataInfo.has_key?('resourceSpecificUsage')
			aResUses = dataInfo['resourceSpecificUsage']
			unless aResUses.empty?
				aResUses.each do |hUsage|
					intDataId[:resourceUses] << AdiwgV1ResourceSpecificUsage.unpack(hUsage)
				end
			end
		end

		# data identification - resource constraints - use
		if dataInfo.has_key?('useLimitations')
			aUseLimits = dataInfo['useLimitations']
			unless aUseLimits.empty?
				aUseLimits.each do |useLimit|
					intDataId[:useLimitations] << useLimit
				end
			end
		end

		# data identification - resource constraints - legal
		if dataInfo.has_key?('legalConstraints')
			aLegalCons = dataInfo['legalConstraints']
			unless aLegalCons.empty?
				aLegalCons.each do |hLegalCon|
					intDataId[:legalConstraints] << AdiwgV1LegalConstraints.unpack(hLegalCon)
				end
			end
		end

		# data identification - resource constraints - security
		if dataInfo.has_key?('securityConstraints')
			aSecurityCons = dataInfo['securityConstraints']
			unless aSecurityCons.empty?
				aSecurityCons.each do |hSecurityCon|
					intDataId[:securityConstraints] << AdiwgV1SecurityConstraints.unpack(hSecurityCon)
				end
			end
		end

		# data identification - taxonomy
		if dataInfo.has_key?('taxonomy')
			hTaxonomy = dataInfo['taxonomy']
			unless hTaxonomy.empty?
				intDataId[:taxonomy] = AdiwgV1Taxonomy.unpack(hTaxonomy)
			end
		end

		# data identification - spatial representation type
		if dataInfo.has_key?('spatialRepresentation')
			aSpatialType = dataInfo['spatialRepresentation']
			unless aSpatialType.empty?
				aSpatialType.each do |spType|
					intDataId[:spatialRepTypes] << spType
				end
			end
		end

		# data identification - spatial resolution
		if dataInfo.has_key?('spatialResolution')
			aSpRes = dataInfo['spatialResolution']
			unless aSpRes.empty?
				aSpRes.each do |hResolution|
					intDataId[:spatialResolutions] << AdiwgV1Resolution.unpack(hResolution)
				end
			end
		end

		# data identification - language
		if dataInfo.has_key?('language')
			aLanguage = dataInfo['language']
			unless aLanguage.empty?
				aLanguage.each do |language|
					intDataId[:contentLanguages] << language
				end
			end
		end

		# data identification - topic category
		if dataInfo.has_key?('topicCategory')
			aTopics = dataInfo['topicCategory']
			unless aTopics.empty?
				aTopics.each do |topic|
					intDataId[:topicCategories] << topic
				end
			end
		end

		# data identification - environment description
		if dataInfo.has_key?('environmentalDesc')
			s = dataInfo['environmentalDesc']
			if s != ''
				intDataId[:environDescription] = s
			end
		end

		# data identification - extent
		if dataInfo.has_key?('extent')
			aExtents = dataInfo['extent']
			unless aExtents.empty?
				aExtents.each do |hExtent|
					intDataId[:extents] << AdiwgV1Extent.unpack(hExtent)
				end
			end
		end

		# data identification - supplemental info
		if dataInfo.has_key?('supplementalInfo')
			s = dataInfo['supplementalInfo']
			if s != ''
				intDataId[:supplementalInfo] = s
			end
		end

		return intDataId
	end

end
