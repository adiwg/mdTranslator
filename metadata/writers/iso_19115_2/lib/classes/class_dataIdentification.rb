# ISO <<Class>> MD_DataIdentification
# writer output in XML

# History:
# 	Stan Smith 2013-08-26 original script
# 	Stan Smith 2013-09-18 add descriptive keywords
# 	Stan Smith 2013-11-01 add constraints
# 	Stan Smith 2013-11-08 add extents
# 	Stan Smith 2013-11-21 add taxonomy
# 	Stan Smith 2013-11-22 add metadataxx extension
# 	Stan Smith 2013-11-25 add resource usage
# 	Stan Smith 2013-11-25 add spatial resolution

require 'builder'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/codelists/code_progress'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/codelists/code_topicCategory'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/codelists/code_spatialRepresentationType'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_citation'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_responsibleParty'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_format'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_keyword'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_browseGraphic'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_maintenanceInformation'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_useConstraints'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_legalConstraints'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_securityConstraints'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_extent'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_taxonSystem'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_usage'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_resolution'

class MD_DataIdentification

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hDataId)

		# classes used by MD_Metadata
		progressCode = MD_ProgressCode.new(@xml)
		topicCode = MD_TopicCategoryCode.new(@xml)
		spatialCode = MD_SpatialRepresentationTypeCode.new(@xml)
		citationClass = CI_Citation.new(@xml)
		rPartyClass = CI_ResponsibleParty.new(@xml)
		rFormatClass = MD_Format.new(@xml)
		keywordClass = MD_Keywords.new(@xml)
		bGraphicClass = MD_BrowseGraphic.new(@xml)
		mInfoClass = MD_MaintenanceInformation.new(@xml)
		uConClass = MD_Constraints.new(@xml)
		lConClass = MD_LegalConstraints.new(@xml)
		sConClass = MD_SecurityConstraints.new(@xml)
		extentClass = EX_Extent.new(@xml)
		taxClass = MD_TaxonSys.new(@xml)
		useClass = MD_Usage.new(@xml)
		resolutionClass = MD_Resolution.new(@xml)

		# data identification
		if hDataId.empty?
			@xml.tag!('gmd:MD_DataIdentification', {'gco:nilReason' => 'missing'})
		else

			@xml.tag!('gmd:MD_DataIdentification') do

				# data identification - citation - required
				hCitation = hDataId[:citation]
				if hCitation.empty?
					@xml.tag!('gmd:citation', {'gco:nilReason' => 'missing'})
				else
					@xml.tag!('gmd:citation') do
						citationClass.writeXML(hCitation)
					end
				end

				# data identification - abstract - required
				s = hDataId[:abstract]
				if s.nil?
					@xml.tag!('gmd:abstract', {'gco:nilReason' => 'missing'})
				else
					@xml.tag!('gmd:abstract') do
						@xml.tag!('gco:CharacterString', s)
					end
				end

				# data identification - purpose
				s = hDataId[:purpose]
				if !s.nil?
					@xml.tag!('gmd:purpose') do
						@xml.tag!('gco:CharacterString', s)
					end
				elsif $showEmpty
					@xml.tag!('gmd:purpose')
				end

				# data identification - credit
				aCredits = hDataId[:credits]
				if !aCredits.empty?
					aCredits.each do |credit|
						@xml.tag!('gmd:credit') do
							@xml.tag!('gco:CharacterString', credit)
						end
					end
				elsif $showEmpty
					@xml.tag!('gmd:credit')
				end

				# data identification - status - required
				s = hDataId[:status]
				if s.nil?
					@xml.tag!('gmd:status', {'gco:nilReason' => 'missing'})
				else
					@xml.tag!('gmd:status') do
						progressCode.writeXML(s)
					end
				end

				# data identification - point of contact
				aPOCs = hDataId[:pointsOfContact]
				if !aPOCs.empty?
					aPOCs.each do |pContact|
						@xml.tag!('gmd:pointOfContact') do
							rPartyClass.writeXML(pContact)
						end
					end
				elsif $showEmpty
					@xml.tag!('gmd:pointOfContact')
				end

				# data identification - resource maintenance
				aMaintInfo = hDataId[:resourceMaint]
				if !aMaintInfo.empty?
					aMaintInfo.each do |resMaintInfo|
						@xml.tag!('gmd:resourceMaintenance') do
							mInfoClass.writeXML(resMaintInfo)
						end
					end
				elsif $showEmpty
					@xml.tag!('gmd:resourceMaintenance')
				end

				# data identification - graphic overview
				aGOverview = hDataId[:graphicOverview]
				if !aGOverview.empty?
					aGOverview.each do |graphic|
						gLink = graphic[:bGLink]
						attributes = {}
						attributes['xlink:href'] = gLink if gLink
						@xml.tag!('gmd:graphicOverview', attributes) do
							bGraphicClass.writeXML(graphic)
						end
					end
				elsif $showEmpty
					@xml.tag!('gmd:graphicOverview')
				end

				# data identification - resource format
				aResFormats = hDataId[:resourceFormats]
				if !aResFormats.empty?
					aResFormats.each do |rFormat|
						@xml.tag!('gmd:resourceFormat') do
							rFormatClass.writeXML(rFormat)
						end
					end
				elsif $showEmpty
					@xml.tag!('gmd:resourceFormat')
				end

				# data identification - descriptive keywords
				aDesKeywords = hDataId[:descriptiveKeywords]
				if !aDesKeywords.empty?
					aDesKeywords.each do |dKeyword|
						@xml.tag!('gmd:descriptiveKeywords') do
							keywordClass.writeXML(dKeyword)
						end
					end
				elsif $showEmpty
					@xml.tag!('gmd:descriptiveKeywords')
				end

				# data identification - resource specific usage
				aResUses = hDataId[:resourceUses]
				if !aResUses.empty?
					aResUses.each do |resUse|
						@xml.tag!('gmd:resourceSpecificUsage') do
							useClass.writeXML(resUse)
						end
					end
				elsif $showEmpty
					@xml.tag!('gmd:resourceSpecificUsage')
				end

				# data identification - resource constraints - use limitations
				aUseLimits = hDataId[:useLimitations]
				if !aUseLimits.empty?
					@xml.tag!('gmd:resourceConstraints') do
						uConClass.writeXML(aUseLimits)
					end
				elsif $showEmpty
					@xml.tag!('gmd:resourceConstraints') do
						@xml.tag!('gmd:MD_Constraints')
					end
				end

				# data identification - resource constraints - legal constraints
				aLegalCons = hDataId[:legalConstraints]
				if !aLegalCons.empty?
					aLegalCons.each do |hLegalCon|
						@xml.tag!('gmd:resourceConstraints') do
							lConClass.writeXML(hLegalCon)
						end
					end
				elsif $showEmpty
					@xml.tag!('gmd:resourceConstraints') do
						@xml.tag!('gmd:MD_LegalConstraints')
					end
				end

				# data identification - resource constraints - security constraints
				# security constraints cannot be shown empty - XSD issue
				aSecurityCons = hDataId[:securityConstraints]
				unless aSecurityCons.empty?
					aSecurityCons.each do |hSecCon|
						@xml.tag!('gmd:resourceConstraints') do
							sConClass.writeXML(hSecCon)
						end
					end
				end

				# data identification - taxonomy
				hTaxonomy = hDataId[:taxonomy]
				if !hTaxonomy.empty?
					@xml.tag!('gmd:taxonomy') do
						taxClass.writeXML(hTaxonomy)
					end
				elsif $showEmpty
					@xml.tag!('gmd:taxonomy')
				end

				# data identification - spatial representation type
				aSpatialType = hDataId[:spatialRepTypes]
				if !aSpatialType.empty?
					aSpatialType.each do |spType|
						@xml.tag!('gmd:spatialRepresentationType') do
							spatialCode.writeXML(spType)
						end
					end
				elsif $showEmpty
					@xml.tag!('gmd:spatialRepresentationType')
				end

				# data identification - spatial resolution
				aSpatialRes = hDataId[:spatialResolutions]
				if !aSpatialRes.empty?
					aSpatialRes.each do |hSpRes|
						@xml.tag!('gmd:spatialResolution') do
							resolutionClass.writeXML(hSpRes)
						end
					end
				elsif $showEmpty
					@xml.tag!('gmd:spatialResolution')
				end

				# data identification - language - required - default applied
				aLanguages = hDataId[:contentLanguages]
				if !aLanguages.empty?
					aLanguages.each do |language|
						@xml.tag!('gmd:language') do
							@xml.tag!('gco:CharacterString', language)
						end
					end
				else
					@xml.tag!('gmd:language') do
						@xml.tag!('gco:CharacterString', 'eng; USA')
					end
				end

				# data identification - topic category
				aTopics = hDataId[:topicCategories]
				if !aTopics.empty?
					aTopics.each do |spType|
						@xml.tag!('gmd:topicCategory') do
							topicCode.writeXML(spType)
						end
					end
				elsif $showEmpty
					@xml.tag!('gmd:topicCategory')
				end

				# data identification - environment description
				s = hDataId[:environDescription]
				if !s.nil?
					@xml.tag!('gmd:environmentDescription') do
						@xml.tag!('gco:CharacterString', s)
					end
				elsif $showEmpty
					@xml.tag!('gmd:environmentDescription')
				end

				# data identification - extent
				aExtents = hDataId[:extents]
				if !aExtents.empty?
					aExtents.each do |hExtent|
						@xml.tag!('gmd:extent') do
							extentClass.writeXML(hExtent)
						end
					end
				elsif $showEmpty
					@xml.tag!('gmd:extent')
				end

				# data identification - supplemental info
				s = hDataId[:supplementalInfo]
				if !s.nil?
					@xml.tag!('gmd:supplementalInformation') do
						@xml.tag!('gco:CharacterString', s)
					end
				elsif $showEmpty
					@xml.tag!('gmd:supplementalInformation')
				end

			end

		end

	end

end