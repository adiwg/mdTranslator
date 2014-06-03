# unpack data identification
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-22 original script
# 	Stan Smith 2013-11-04 extents
# 	Stan Smith 2013-11-14 legal constraints
# 	Stan Smith 2013-11-20 taxonomy
# 	Stan Smith 2013-11-25 resource specific usage
# 	Stan Smith 2013-11-26 spatial resolution
#   Stan Smith 2014-04-25 revised to support json schema version 0.3.0
#   Stan Smith 2014-05-28 added resource identifier to citation json schema 0.5.0

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_citation'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_resourceIdentifier'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_responsibleParty'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_resourceFormat'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_descriptiveKeyword'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_resourceMaintenance'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_resourceSpecificUsage'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_browseGraphic'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_legalConstraint'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_securityConstraint'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_taxonomy'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_resolution'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_extent'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_dataQuality'

module AdiwgV1ResourceInfo

	def self.unpack(hResourceInfo)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intResInfo = intMetadataClass.newResourceInfo

		# resource information - citation
		if hResourceInfo.has_key?('citation')
			hCitation = hResourceInfo['citation']
			intResInfo[:citation] = AdiwgV1Citation.unpack(hCitation)

			# resource information - resource identifier
			# resource identifiers reference the citation,
			# ... they are only valid if there is a citation
			if hResourceInfo.has_key?('resourceIdentifier')
				aResID = hResourceInfo['resourceIdentifier']
				unless aResID.empty?
					aResID.each do |resID|
						intResInfo[:citation][:citResourceIDs] << AdiwgV1ResourceIdentifier.unpack(resID)
					end
				end
			end
		end

		# resource information - point of contact
		if hResourceInfo.has_key?('pointOfContact')
			aPOC = hResourceInfo['pointOfContact']
			unless aPOC.empty?
				aPOC.each do |rParty|
					intResInfo[:pointsOfContact] << AdiwgV1ResponsibleParty.unpack(rParty)
				end
			end
		end

		# resource information - abstract
		if hResourceInfo.has_key?('abstract')
			s = hResourceInfo['abstract']
			if s != ''
				intResInfo[:abstract] = s
			end
		end

		# resource information - short abstract
		if hResourceInfo.has_key?('shortAbstract')
			s = hResourceInfo['shortAbstract']
			if s != ''
				intResInfo[:shortAbstract] = s
			end
		end

		# resource information - status
		if hResourceInfo.has_key?('status')
			s = hResourceInfo['status']
			if s != ''
				intResInfo[:status] = s
			end
		end

		# resource information - has mappable location
		if hResourceInfo.has_key?('hasMapLocation')
			s = hResourceInfo['hasMapLocation']
			if s != ''
				intResInfo[:hasMapLocation?] = s
			end
		end

		# resource information - has data available
		if hResourceInfo.has_key?('hasDataAvailable')
			s = hResourceInfo['hasDataAvailable']
			if s != ''
				intResInfo[:hasDataAvailable?] = s
			end
		end

		# resource information - language
		if hResourceInfo.has_key?('language')
			aLanguage = hResourceInfo['language']
			unless aLanguage.empty?
				aLanguage.each do |language|
					intResInfo[:resourceLanguages] << language
				end
			end
		end

		# resource information - purpose
		if hResourceInfo.has_key?('purpose')
			s = hResourceInfo['purpose']
			if s != ''
				intResInfo[:purpose] = s
			end
		end

		# resource information - credit
		if hResourceInfo.has_key?('credit')
			aCredits = hResourceInfo['credit']
			unless aCredits.empty?
				aCredits.each do |credit|
					intResInfo[:credits] << credit
				end
			end
		end

		# resource information - topic category
		if hResourceInfo.has_key?('topicCategory')
			aTopics = hResourceInfo['topicCategory']
			unless aTopics.empty?
				aTopics.each do |topic|
					intResInfo[:topicCategories] << topic
				end
			end
		end

		# resource information - environment description
		if hResourceInfo.has_key?('environmentDescription')
			s = hResourceInfo['environmentDescription']
			if s != ''
				intResInfo[:environmentDescription] = s
			end
		end

		# resource information - resource format
		if hResourceInfo.has_key?('resourceNativeFormat')
			aResFormat = hResourceInfo['resourceNativeFormat']
			unless aResFormat.empty?
				aResFormat.each do |hResFormat|
					intResInfo[:resourceFormats] << AdiwgV1ResourceFormat.unpack(hResFormat)
				end
			end
		end

		# resource information - descriptive keywords
		if hResourceInfo.has_key?('keyword')
			aDesKeywords = hResourceInfo['keyword']
			unless aDesKeywords.empty?
				aDesKeywords.each do |hDesKeyword|
					intResInfo[:descriptiveKeywords] << AdiwgV1DescriptiveKeyword.unpack(hDesKeyword)
				end
			end
		end

		# resource information - resource maintenance
		if hResourceInfo.has_key?('resourceMaintenance')
			aResMaint = hResourceInfo['resourceMaintenance']
			unless aResMaint.empty?
				aResMaint.each do |hResource|
					intResInfo[:resourceMaint] << AdiwgV1ResourceMaintenance.unpack(hResource)
				end
			end
		end

		# resource information - resource specific usage
		if hResourceInfo.has_key?('resourceSpecificUsage')
			aResUses = hResourceInfo['resourceSpecificUsage']
			unless aResUses.empty?
				aResUses.each do |hUsage|
					intResInfo[:resourceUses] << AdiwgV1ResourceSpecificUsage.unpack(hUsage)
				end
			end
		end

		# resource information - graphic overview
		if hResourceInfo.has_key?('graphicOverview')
			aBrowseGraph = hResourceInfo['graphicOverview']
			unless aBrowseGraph.empty?
				aBrowseGraph.each do |hBGraphic|
					intResInfo[:graphicOverview] << AdiwgV1BrowseGraphic.unpack(hBGraphic)
				end
			end
		end

		# resource information - use constraints
		if hResourceInfo.has_key?('constraint')
			hConstraint = hResourceInfo['constraint']

			# resource information - resource constraints - use
			if hConstraint.has_key?('useLimitation')
				aUseLimits = hConstraint['useLimitation']
				unless aUseLimits.empty?
					aUseLimits.each do |useLimit|
						intResInfo[:useConstraints] << useLimit
					end
				end
			end

			# resource information - resource constraints - legal
			if hConstraint.has_key?('legalConstraint')
				aLegalCons = hConstraint['legalConstraint']
				unless aLegalCons.empty?
					aLegalCons.each do |hLegalCon|
						intResInfo[:legalConstraints] << AdiwgV1LegalConstraints.unpack(hLegalCon)
					end
				end
			end

			# resource information - resource constraints - security
			if hConstraint.has_key?('securityConstraint')
				aSecurityCons = hConstraint['securityConstraint']
				unless aSecurityCons.empty?
					aSecurityCons.each do |hSecurityCon|
						intResInfo[:securityConstraints] << AdiwgV1SecurityConstraints.unpack(hSecurityCon)
					end
				end
			end

		end

		# resource information - taxonomy
		if hResourceInfo.has_key?('taxonomy')
			hTaxonomy = hResourceInfo['taxonomy']
			unless hTaxonomy.empty?
				intResInfo[:taxonomy] = AdiwgV1Taxonomy.unpack(hTaxonomy)
			end
		end

		# resource information - spatial reference systems
		if hResourceInfo.has_key?('spatialDatum')
			aSpatialDatum = hResourceInfo['spatialDatum']
			unless aSpatialDatum.empty?
				aSpatialDatum.each do |spDatum|
					intResInfo[:spatialReferenceSystems] << spDatum
				end
			end
		end

		# resource information - spatial representation type
		if hResourceInfo.has_key?('spatialRepresentation')
			aSpatialType = hResourceInfo['spatialRepresentation']
			unless aSpatialType.empty?
				aSpatialType.each do |spType|
					intResInfo[:spatialRepresentationTypes] << spType
				end
			end
		end

		# resource information - spatial resolution
		if hResourceInfo.has_key?('spatialResolution')
			aSpRes = hResourceInfo['spatialResolution']
			unless aSpRes.empty?
				aSpRes.each do |hResolution|
					intResInfo[:spatialResolutions] << AdiwgV1Resolution.unpack(hResolution)
				end
			end
		end

		# resource information - extent
		if hResourceInfo.has_key?('extent')
			aExtents = hResourceInfo['extent']
			unless aExtents.empty?
				aExtents.each do |hExtent|
					intResInfo[:extents] << AdiwgV1Extent.unpack(hExtent)
				end
			end
		end

		# resource information - data quality information
		if hResourceInfo.has_key?('dataQualityInfo')
			aDataQual = hResourceInfo['dataQualityInfo']
			unless aDataQual.empty?
				aDataQual.each do |hDQ|
					intResInfo[:dataQualityInfo] << AdiwgV1DataQuality.unpack(hDQ)
				end
			end
		end

		# resource information - supplemental info
		if hResourceInfo.has_key?('supplementalInfo')
			s = hResourceInfo['supplementalInfo']
			if s != ''
				intResInfo[:supplementalInfo] = s
			end
		end

		return intResInfo
	end

end
