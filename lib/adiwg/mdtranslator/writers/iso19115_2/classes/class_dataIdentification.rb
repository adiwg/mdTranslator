# ISO <<Class>> MD_DataIdentification
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-12-13 refactored for mdTranslator/mdJson 2.0
#   Stan Smith 2015-07-30 added support for translating locale into language and characterSet
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#   Stan Smith 2015-06-12 added support for declaring multiple resource character sets
#   Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-10-29 add resource time period as a extent temporal element
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-05-21 added aggregate information section
#   Stan Smith 2014-05-15 modify to support JSON schema version 0.4.0
# 	Stan Smith 2013-11-25 add spatial resolution
# 	Stan Smith 2013-11-25 add resource usage
# 	Stan Smith 2013-11-22 add metadata extension
# 	Stan Smith 2013-11-21 add taxonomy
# 	Stan Smith 2013-11-08 add extents
# 	Stan Smith 2013-11-01 add constraints
# 	Stan Smith 2013-09-18 add descriptive keywords
# 	Stan Smith 2013-08-26 original script

require_relative 'class_codelist'
require_relative 'class_enumerationList'
require_relative 'class_citation'
require_relative 'class_responsibleParty'
require_relative 'class_maintenance'
require_relative 'class_browseGraphic'
require_relative 'class_format'
require_relative 'class_keyword'
require_relative 'class_usage'
require_relative 'class_useConstraints'
require_relative 'class_legalConstraints'
require_relative 'class_securityConstraints'
require_relative 'class_aggregateInformation'
require_relative 'class_taxonomy'
require_relative 'class_resolution'
require_relative 'class_extent'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_DataIdentification

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hData, aAssocRes)

                        # classes used
                        codelistClass =  MD_Codelist.new(@xml, @hResponseObj)
                        enumerationClass =  MD_EnumerationList.new(@xml, @hResponseObj)
                        citationClass =  CI_Citation.new(@xml, @hResponseObj)
                        rPartyClass =  CI_ResponsibleParty.new(@xml, @hResponseObj)
                        mInfoClass =  MD_MaintenanceInformation.new(@xml, @hResponseObj)
                        bGraphicClass =  MD_BrowseGraphic.new(@xml, @hResponseObj)
                        rFormatClass =  MD_Format.new(@xml, @hResponseObj)
                        keywordClass =  MD_Keywords.new(@xml, @hResponseObj)
                        useClass =  MD_Usage.new(@xml, @hResponseObj)
                        uConClass =  MD_Constraints.new(@xml, @hResponseObj)
                        lConClass =  MD_LegalConstraints.new(@xml, @hResponseObj)
                        sConClass =  MD_SecurityConstraints.new(@xml, @hResponseObj)
                        aggInfoClass =  MD_AggregateInformation.new(@xml, @hResponseObj)
                        taxClass =  MD_TaxonSys.new(@xml, @hResponseObj)
                        resolutionClass =  MD_Resolution.new(@xml, @hResponseObj)
                        extentClass =  EX_Extent.new(@xml, @hResponseObj)

                        # data identification
                        @xml.tag!('gmd:MD_DataIdentification') do

                            # data identification - citation {CI_Citation} (required)
                            hCitation = hData[:citation]
                            unless hCitation.empty?
                                @xml.tag!('gmd:citation') do
                                    citationClass.writeXML(hCitation)
                                end
                            end
                            if hCitation.empty?
                                @xml.tag!('gmd:citation', {'gco:nilReason' => 'missing'})
                            end

                            # data identification - abstract (required)
                            s = hData[:abstract]
                            unless s.nil?
                                @xml.tag!('gmd:abstract') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end
                            if s.nil?
                                @xml.tag!('gmd:abstract', {'gco:nilReason' => 'missing'})
                            end

                            # data identification - purpose
                            s = hData[:purpose]
                            unless s.nil?
                                @xml.tag!('gmd:purpose') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end
                            if s.nil? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:purpose')
                            end

                            # data identification - credit []
                            aCredits = hData[:credits]
                            aCredits.each do |credit|
                                @xml.tag!('gmd:credit') do
                                    @xml.tag!('gco:CharacterString', credit)
                                end
                            end
                            if aCredits.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:credit')
                            end

                            # data identification - status []
                            aStatus = hData[:status]
                            aStatus.each do |code|
                                @xml.tag!('gmd:status') do
                                    codelistClass.writeXML('iso_progress', code)
                                end
                            end
                            if aStatus.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:status')
                            end

                            # data identification - point of contact
                            aRParties = hCitation[:pointOfContacts]
                            aRParties.each do |hRParty|
                                role = hRParty[:roleName]
                                aParties = hRParty[:party]
                                aParties.each do |hParty|
                                    @xml.tag!('gmd:pointOfContact') do
                                        rPartyClass.writeXML(role, hParty)
                                    end
                                end
                            end
                            if aRParties.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:pointOfContact', {'gco:nilReason' => 'missing'})
                            end

                            # data identification - resource maintenance []
                            aMaint = hData[:resourceMaintenance]
                            aMaint.each do |hMaint|
                                @xml.tag!('gmd:resourceMaintenance') do
                                    mInfoClass.writeXML(hMaint)
                                end
                            end
                            if aMaint.empty && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:resourceMaintenance')
                            end

                            # data identification - graphic overview []
                            aGraphics = hData[:graphicOverviews]
                            aGraphics.each do |hGraphic|
                                @xml.tag!('gmd:graphicOverview', attributes) do
                                    bGraphicClass.writeXML(hGraphic)
                                end
                            end
                            if aGraphics.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:graphicOverview')
                            end

                            # data identification - resource format []
                            aFormats = hData[:resourceFormats]
                            aFormats.each do |hResFormat|
                                @xml.tag!('gmd:resourceFormat') do
                                    rFormatClass.writeXML(hResFormat)
                                end
                            end
                            if aFormats.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:resourceFormat')
                            end

                            # data identification - descriptive keywords []
                            aKeywords = hData[:keywords]
                            aKeywords.each do |hKeyword|
                                @xml.tag!('gmd:descriptiveKeywords') do
                                    keywordClass.writeXML(hKeyword)
                                end
                            end
                            if aKeywords.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:descriptiveKeywords')
                            end

                            # data identification - resource specific usage []
                            aUses = hData[:resourceUsages]
                            aUses.each do |hResUse|
                                @xml.tag!('gmd:resourceSpecificUsage') do
                                    useClass.writeXML(hResUse)
                                end
                            end
                            if aUses.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:resourceSpecificUsage')
                            end

                            # data identification - resource constraints - use constraints []
                            aUseCons = hData[:useConstraints][:constraints]
                            unless aUseCons.nil?
                                @xml.tag!('gmd:resourceConstraints') do
                                    uConClass.writeXML(aUseCons)
                                end
                            end
                            if aUseCons.nil? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:resourceConstraints') do
                                    @xml.tag!('gmd:MD_Constraints')
                                end
                            end

                            # data identification - resource constraints - legal constraints []
                            aLegalCons = hData[:useConstraints][:legalConstraints]
                            unless aLegalCons.nil?
                                @xml.tag!('gmd:resourceConstraints') do
                                    lConClass.writeXML(aLegalCons)
                                end
                            end
                            if aUseCons.nil? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:resourceConstraints') do
                                    @xml.tag!('gmd:MD_LegalConstraints')
                                end
                            end

                            # data identification - resource constraints - security constraints []
                            # empty tag cannot be shown for security constraints - XSD issue
                            aSecurityCons = hData[:useConstraints][:securityConstraints]
                            unless aSecurityCons.nil?
                                @xml.tag!('gmd:resourceConstraints') do
                                    sConClass.writeXML(aSecurityCons)
                                end
                            end
                            if aSecurityCons.nil? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:resourceConstraints') do
                                    @xml.tag!('gmd:MD_SecurityConstraints')
                                end
                            end

                            # data identification - aggregate information []
                            aAssocRes.each do |hAssocRes|
                                @xml.tag!('gmd:aggregationInfo') do
                                    aggInfoClass.writeXML(hAssocRes)
                                end
                            end
                            if aAssocRes.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:aggregationInfo')
                            end

                            # data identification - taxonomy
                            hTaxonomy = hData[:taxonomy]
                            unless hTaxonomy.empty?
                                @xml.tag!('gmd:taxonomy') do
                                    taxClass.writeXML(hTaxonomy)
                                end
                            end
                            if hTaxonomy.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:taxonomy')
                            end

                            # data identification - spatial representation type []
                            aSpatialType = hData[:spatialRepresentationTypes]
                            aSpatialType.each do |spType|
                                @xml.tag!('gmd:spatialRepresentationType') do
                                    codelistClass.writeXML('iso_spatialRepresentation',spType)
                                end
                            end
                            if aSpatialType.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:spatialRepresentationType')
                            end

                            # data identification - spatial resolution []
                            aSpatialRes = hData[:spatialResolutions]
                            aSpatialRes.each do |hSpRes|
                                @xml.tag!('gmd:spatialResolution') do
                                    resolutionClass.writeXML(hSpRes)
                                end
                            end
                            if aSpatialType.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:spatialResolution')
                            end

                            # data identification - language [] (required)
                            aLocale = hData[:otherResourceLocales]
                            aLocale.insert(0, hData[:defaultResourceLocale])
                            aLocale.each do |hLocale|
                                s = hLocale[:languageCode]
                                unless hLocale[:countryCode].nil?
                                    s += '; ' + hLocale[:countryCode]
                                end
                                @xml.tag!('gmd:language') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end
                            if aLocale.empty?
                                @xml.tag!('gmd:language') do
                                    @xml.tag!('gco:CharacterString', 'eng; USA')
                                end
                            end

                            # data identification - characterSet [] (default 'utf8')
                            charSets = 0
                            aLocale.each do |hLocale|
                                s = hLocale[:characterEncoding]
                                unless s.nil?
                                    @xml.tag!('gmd:characterSet') do
                                        codelistClass.writeXML('iso_characterSet', s)
                                        charSets += 1
                                    end
                                end
                            end
                            if charSets == 0
                                @xml.tag!('gmd:language') do
                                    @xml.tag!('gco:CharacterString', 'eng; USA')
                                end
                            end

                            # data identification - topic category []
                            aTopics = hData[:topicCategories]
                            aTopics.each do |spType|
                                @xml.tag!('gmd:topicCategory') do
                                    enumerationClass.writeXML('iso_topicCategory', spType)
                                end
                            end
                            if aTopics.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:topicCategory')
                            end

                            # data identification - environment description
                            s = hData[:environmentDescription]
                            unless s.nil?
                                @xml.tag!('gmd:environmentDescription') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end
                            if s.nil? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:environmentDescription')
                            end

                            # data identification - extent []
                            aExtents = hData[:extents]
                            aExtents.each do |hExtent|
                                @xml.tag!('gmd:extent') do
                                    extentClass.writeXML(hExtent)
                                end
                            end
                            if aExtents.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:extent')
                            end

                            # data identification - supplemental info
                            s = hData[:supplementalInfo]
                            unless s.nil?
                                @xml.tag!('gmd:supplementalInformation') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end
                            if s.nil? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:supplementalInformation')
                            end

                        end # gmd:MD_DataIdentification tag
                    end # writeXML
                end # MD_DataIdentification class

            end
        end
    end
end
