# ISO <<Class>> MD_DataIdentification
# writer output in XML

# History:
# 	Stan Smith 2013-08-26 original script
# 	Stan Smith 2013-09-18 add descriptive keywords
# 	Stan Smith 2013-11-01 add constraints
# 	Stan Smith 2013-11-08 add extents
# 	Stan Smith 2013-11-21 add taxonomy
# 	Stan Smith 2013-11-22 add metadata extension
# 	Stan Smith 2013-11-25 add resource usage
# 	Stan Smith 2013-11-25 add spatial resolution
#   Stan Smith 2014-05-15 modify to support JSON schema version 0.4.0
#   Stan Smith 2014-05-21 added aggregate information section
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-10-29 add resource time period as a extent temporal element
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#   Stan Smith 2015-06-12 added support for declaring multiple resource character sets
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

require_relative 'class_codelist'
require_relative 'class_enumerationList'
require_relative 'class_citation'
require_relative 'class_responsibleParty'
require_relative 'class_maintenanceInformation'
require_relative 'class_browseGraphic'
require_relative 'class_format'
require_relative 'class_keyword'
require_relative 'class_usage'
require_relative 'class_useConstraints'
require_relative 'class_legalConstraints'
require_relative 'class_securityConstraints'
require_relative 'class_aggregateInformation'
require_relative 'class_taxonSystem'
require_relative 'class_resolution'
require_relative 'class_extent'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_DataIdentification

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hDataId, aAssocRes)

                        # classes used
                        codelistClass =  MD_Codelist.new(@xml, @responseObj)
                        enumerationClass =  MD_EnumerationList.new(@xml, @responseObj)
                        intMetadataClass = InternalMetadata.new
                        citationClass =  CI_Citation.new(@xml, @responseObj)
                        rPartyClass =  CI_ResponsibleParty.new(@xml, @responseObj)
                        mInfoClass =  MD_MaintenanceInformation.new(@xml, @responseObj)
                        bGraphicClass =  MD_BrowseGraphic.new(@xml, @responseObj)
                        rFormatClass =  MD_Format.new(@xml, @responseObj)
                        keywordClass =  MD_Keywords.new(@xml, @responseObj)
                        useClass =  MD_Usage.new(@xml, @responseObj)
                        uConClass =  MD_Constraints.new(@xml, @responseObj)
                        lConClass =  MD_LegalConstraints.new(@xml, @responseObj)
                        sConClass =  MD_SecurityConstraints.new(@xml, @responseObj)
                        aggInfoClass =  MD_AggregateInformation.new(@xml, @responseObj)
                        taxClass =  MD_TaxonSys.new(@xml, @responseObj)
                        resolutionClass =  MD_Resolution.new(@xml, @responseObj)
                        extentClass =  EX_Extent.new(@xml, @responseObj)

                        # data identification
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
                            elsif @responseObj[:writerShowTags]
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
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:credit')
                            end

                            # data identification - status - required
                            s = hDataId[:status]
                            if s.nil?
                                @xml.tag!('gmd:status', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:status') do
                                    codelistClass.writeXML('iso_progress',s)
                                end
                            end

                            # data identification - point of contact
                            aPOCs = hDataId[:pointsOfContact]
                            if !aPOCs.empty?
                                aPOCs.each do |hPContact|
                                    @xml.tag!('gmd:pointOfContact') do
                                        rPartyClass.writeXML(hPContact)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:pointOfContact')
                            end

                            # data identification - resource maintenance
                            aMaintInfo = hDataId[:resourceMaint]
                            if !aMaintInfo.empty?
                                aMaintInfo.each do |hResMaintInfo|
                                    @xml.tag!('gmd:resourceMaintenance') do
                                        mInfoClass.writeXML(hResMaintInfo)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:resourceMaintenance')
                            end

                            # data identification - graphic overview
                            aGOverview = hDataId[:graphicOverview]
                            if !aGOverview.empty?
                                aGOverview.each do |graphic|
                                    gLink = graphic[:bGURI]
                                    attributes = {}
                                    attributes['xlink:href'] = gLink if gLink
                                    @xml.tag!('gmd:graphicOverview', attributes) do
                                        bGraphicClass.writeXML(graphic)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:graphicOverview')
                            end

                            # data identification - resource format
                            aResFormats = hDataId[:resourceFormats]
                            if !aResFormats.empty?
                                aResFormats.each do |hResFormat|
                                    @xml.tag!('gmd:resourceFormat') do
                                        rFormatClass.writeXML(hResFormat)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:resourceFormat')
                            end

                            # data identification - descriptive keywords
                            aDesKeywords = hDataId[:descriptiveKeywords]
                            if !aDesKeywords.empty?
                                aDesKeywords.each do |hDKeyword|
                                    @xml.tag!('gmd:descriptiveKeywords') do
                                        keywordClass.writeXML(hDKeyword)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:descriptiveKeywords')
                            end

                            # data identification - resource specific usage
                            aResUses = hDataId[:resourceUses]
                            if !aResUses.empty?
                                aResUses.each do |hResUse|
                                    @xml.tag!('gmd:resourceSpecificUsage') do
                                        useClass.writeXML(hResUse)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:resourceSpecificUsage')
                            end

                            # data identification - resource constraints - use constraints
                            aUseLimits = hDataId[:useConstraints]
                            if !aUseLimits.empty?
                                @xml.tag!('gmd:resourceConstraints') do
                                    uConClass.writeXML(aUseLimits)
                                end
                            elsif @responseObj[:writerShowTags]
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
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:resourceConstraints') do
                                    @xml.tag!('gmd:MD_LegalConstraints')
                                end
                            end

                            # data identification - resource constraints - security constraints
                            # empty tag cannot be shown for security constraints - XSD issue
                            aSecurityCons = hDataId[:securityConstraints]
                            unless aSecurityCons.empty?
                                aSecurityCons.each do |hSecCon|
                                    @xml.tag!('gmd:resourceConstraints') do
                                        sConClass.writeXML(hSecCon)
                                    end
                                end
                            end

                            # data identification - aggregate information
                            if !aAssocRes.empty?
                                aAssocRes.each do |hAssocRes|
                                    @xml.tag!('gmd:aggregationInfo') do
                                        aggInfoClass.writeXML(hAssocRes)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:aggregationInfo')
                            end

                            # data identification - taxonomy
                            hTaxonomy = hDataId[:taxonomy]
                            if !hTaxonomy.empty?
                                @xml.tag!('gmd:taxonomy') do
                                    taxClass.writeXML(hTaxonomy)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:taxonomy')
                            end

                            # data identification - spatial representation type
                            aSpatialType = hDataId[:spatialRepresentationTypes]
                            if !aSpatialType.empty?
                                aSpatialType.each do |spType|
                                    @xml.tag!('gmd:spatialRepresentationType') do
                                        codelistClass.writeXML('iso_spatialRepresentation',spType)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
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
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:spatialResolution')
                            end

                            # data identification - language - required - default of english applied
                            aLanguages = hDataId[:resourceLanguages]
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

                            # data identification - characterSet - default 'utf8'
                            aCharSets = hDataId[:resourceCharacterSets]
                            if !aCharSets.empty?
                                aCharSets.each do |charSet|
                                    @xml.tag!('gmd:characterSet') do
                                        codelistClass.writeXML('iso_characterSet',charSet)
                                    end
                                end
                            else
                                @xml.tag!('gmd:characterSet') do
                                    codelistClass.writeXML('iso_characterSet','utf8')
                                end
                            end

                            # data identification - topic category
                            aTopics = hDataId[:topicCategories]
                            if !aTopics.empty?
                                aTopics.each do |spType|
                                    @xml.tag!('gmd:topicCategory') do
                                        enumerationClass.writeXML('iso_topicCategory',spType)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:topicCategory')
                            end

                            # data identification - environment description
                            s = hDataId[:environmentDescription]
                            if !s.nil?
                                @xml.tag!('gmd:environmentDescription') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:environmentDescription')
                            end

                            # data identification - extent
                            # if resource time period, represent the time period as
                            # a temporal element in the first extent
                            needTag = true
                            hTimePeriod = hDataId[:timePeriod]
                            if !hTimePeriod.empty?
                                hTempEle = intMetadataClass.newTemporalElement
                                hTempEle[:timePeriod] = hTimePeriod
                                hExt = intMetadataClass.newExtent
                                hExt[:extDesc] = 'Temporal span of the resource (data or project)'
                                hExt[:extTempElements] << hTempEle
                                @xml.tag!('gmd:extent') do
                                    extentClass.writeXML(hExt)
                                end
                                needTag = false
                            end

                            # add the remaining geographic, temporal, and veritcal extents
                            aExtents = hDataId[:extents]
                            if !aExtents.empty?
                                aExtents.each do |hExtent|
                                    @xml.tag!('gmd:extent') do
                                        extentClass.writeXML(hExtent)
                                    end
                                end
                            elsif @responseObj[:writerShowTags] && needTag
                                @xml.tag!('gmd:extent')
                            end

                            # data identification - supplemental info
                            s = hDataId[:supplementalInfo]
                            if !s.nil?
                                @xml.tag!('gmd:supplementalInformation') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:supplementalInformation')
                            end

                        end

                    end

                end

            end
        end
    end
end
