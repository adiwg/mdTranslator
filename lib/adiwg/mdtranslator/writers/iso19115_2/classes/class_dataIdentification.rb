# ISO <<Class>> MD_DataIdentification
# 19115-2 writer output in XML

# History:
#  Stan Smith 2019-03-22 replaced Enumeration class with method
#  Stan Smith 2018-10-26 refactor for mdJson schema 2.6.0
#  Stan Smith 2018-05-25 block non-ISO19115-2 topic categories
#  Stan Smith 2018-04-09 add error and warning messaging
#  Stan Smith 2018-04-06 changed taxonomy to an array
#  Stan Smith 2018-01-05 deprecated topicCategory[]
#  Stan Smith 2018-01-05 get topics from keywords where type='isoTopicCategory'
#  Stan Smith 2016-12-13 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-30 added support for translating locale into language and characterSet
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2015-06-12 added support for declaring multiple resource character sets
#  Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-10-29 add resource time period as a temporalExtent element
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#  Stan Smith 2014-05-21 added aggregate information section
#  Stan Smith 2014-05-15 modify to support JSON schema version 0.4.0
# 	Stan Smith 2013-11-25 add spatial resolution
# 	Stan Smith 2013-11-25 add resource usage
# 	Stan Smith 2013-11-22 add metadata extension
# 	Stan Smith 2013-11-21 add taxonomy
# 	Stan Smith 2013-11-08 add extents
# 	Stan Smith 2013-11-01 add constraints
# 	Stan Smith 2013-09-18 add descriptive keywords
# 	Stan Smith 2013-08-26 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/internal/module_codelistFun'
require_relative '../iso19115_2_writer'
require_relative 'class_codelist'
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
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hMetadata)

                  # classes used
                  intMetadataClass = InternalMetadata.new
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  citationClass = CI_Citation.new(@xml, @hResponseObj)
                  rPartyClass = CI_ResponsibleParty.new(@xml, @hResponseObj)
                  mInfoClass = MD_MaintenanceInformation.new(@xml, @hResponseObj)
                  bGraphicClass = MD_BrowseGraphic.new(@xml, @hResponseObj)
                  rFormatClass = MD_Format.new(@xml, @hResponseObj)
                  keywordClass = MD_Keywords.new(@xml, @hResponseObj)
                  useClass = MD_Usage.new(@xml, @hResponseObj)
                  uConClass = MD_Constraints.new(@xml, @hResponseObj)
                  lConClass = MD_LegalConstraints.new(@xml, @hResponseObj)
                  sConClass = MD_SecurityConstraints.new(@xml, @hResponseObj)
                  aggInfoClass = MD_AggregateInformation.new(@xml, @hResponseObj)
                  taxClass = MD_TaxonSys.new(@xml, @hResponseObj)
                  resolutionClass = MD_Resolution.new(@xml, @hResponseObj)
                  extentClass = EX_Extent.new(@xml, @hResponseObj)

                  # create shortcuts to sections of internal object
                  hResource = hMetadata[:resourceInfo]
                  aAssocRes = hMetadata[:associatedResources]
                  aDistInfo = hMetadata[:distributorInfo]

                  # data identification
                  @xml.tag!('gmd:MD_DataIdentification') do

                     # data identification - citation {CI_Citation} (required)
                     hCitation = hResource[:citation]
                     unless hCitation.empty?
                        @xml.tag!('gmd:citation') do
                           citationClass.writeXML(hCitation, 'main resource')
                        end
                     end
                     if hCitation.empty?
                        @NameSpace.issueWarning(50, 'gmd:citation')
                     end

                     # data identification - abstract (required)
                     s = hResource[:abstract]
                     unless s.nil?
                        @xml.tag!('gmd:abstract') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil?
                        @NameSpace.issueWarning(51, 'gmd:abstract')
                     end

                     # data identification - purpose
                     s = hResource[:purpose]
                     unless s.nil?
                        @xml.tag!('gmd:purpose') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:purpose')
                     end

                     # data identification - time period {timePeriod}
                     # package as a temporal extent
                     unless hResource[:timePeriod].empty?
                        hExtent = intMetadataClass.newExtent
                        hTempExtent = intMetadataClass.newTemporalExtent
                        hTempExtent[:timePeriod] = hResource[:timePeriod]
                        hExtent[:temporalExtents] << hTempExtent
                        hResource[:extents] << hExtent
                     end

                     # data identification - credit []
                     aCredits = hResource[:credits]
                     aCredits.each do |credit|
                        @xml.tag!('gmd:credit') do
                           @xml.tag!('gco:CharacterString', credit)
                        end
                     end
                     if aCredits.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:credit')
                     end

                     # data identification - status []
                     aStatus = hResource[:status]
                     aStatus.each do |code|
                        @xml.tag!('gmd:status') do
                           codelistClass.writeXML('gmd', 'iso_progress', code)
                        end
                     end
                     if aStatus.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:status')
                     end

                     # data identification - point of contact
                     aRParties = hResource[:pointOfContacts]
                     aRParties.each do |hRParty|
                        role = hRParty[:roleName]
                        aParties = hRParty[:parties]
                        aParties.each do |hParty|
                           @xml.tag!('gmd:pointOfContact') do
                              rPartyClass.writeXML(role, hParty, 'resource point of contact')
                           end
                        end
                     end
                     if aRParties.empty? && @hResponseObj[:writerShowTags]
                        @NameSpace.issueWarning(52, 'gmd:pointOfContact')
                     end

                     # data identification - resource maintenance []
                     aMaint = hResource[:resourceMaintenance]
                     aMaint.each do |hMaint|
                        @xml.tag!('gmd:resourceMaintenance') do
                           mInfoClass.writeXML(hMaint, 'main resource')
                        end
                     end
                     if aMaint.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:resourceMaintenance')
                     end

                     # data identification - graphic overview []
                     aGraphics = hResource[:graphicOverviews]
                     aGraphics.each do |hGraphic|
                        @xml.tag!('gmd:graphicOverview') do
                           bGraphicClass.writeXML(hGraphic, 'main resource')
                        end
                     end
                     if aGraphics.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:graphicOverview')
                     end

                     # data identification - resource format []
                     aFormats = hResource[:resourceFormats]
                     aFormats.each do |hResFormat|
                        @xml.tag!('gmd:resourceFormat') do
                           rFormatClass.writeXML(hResFormat)
                        end
                     end
                     if aFormats.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:resourceFormat')
                     end

                     # data identification - descriptive keywords []
                     aKeywords = hResource[:keywords]
                     aKeywords.each do |hKeyword|
                        @xml.tag!('gmd:descriptiveKeywords') do
                           keywordClass.writeXML(hKeyword)
                        end
                     end
                     if aKeywords.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:descriptiveKeywords')
                     end

                     # data identification - resource specific usage []
                     aUses = hResource[:resourceUsages]
                     aUses.each do |hResUse|
                        @xml.tag!('gmd:resourceSpecificUsage') do
                           useClass.writeXML(hResUse)
                        end
                     end
                     if aUses.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:resourceSpecificUsage')
                     end

                     # data identification - resource constraints {}
                     haveCon = false
                     aCons = hResource[:constraints]
                     aCons.each do |hCon|
                        @xml.tag!('gmd:resourceConstraints') do
                           type = hCon[:type]
                           if type == 'use'
                              uConClass.writeXML(hCon)
                           end
                           if type == 'legal'
                              lConClass.writeXML(hCon)
                           end
                           if type == 'security'
                              sConClass.writeXML(hCon)
                           end
                           haveCon = true
                        end
                     end

                     # data identification - resource constraints {}  from distribution liability statement
                     aDistInfo.each do |hDistribution|
                        unless hDistribution.empty?
                           unless hDistribution[:liabilityStatement].nil?
                              @xml.tag!('gmd:resourceConstraints') do
                                 @xml.tag!('gmd:MD_LegalConstraints') do
                                    @xml.tag!('gmd:otherConstraints') do
                                       @xml.tag!('gco:CharacterString', hDistribution[:liabilityStatement])
                                    end
                                 end
                              end
                              haveCon = true
                           end
                        end
                     end

                     if !haveCon && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:resourceConstraints')
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

                     # data identification - taxonomy (first)
                     unless hResource[:taxonomy].empty?
                        hTaxonomy = hResource[:taxonomy][0]
                        unless hTaxonomy.empty?
                           @xml.tag!('gmd:taxonomy') do
                              taxClass.writeXML(hTaxonomy)
                           end
                        end
                        if hResource[:taxonomy].length > 1
                           @NameSpace.issueNotice(53, 'main resource')
                           @NameSpace.issueNotice(54, 'main resource')
                        end
                     end
                     if hResource[:taxonomy].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:taxonomy')
                     end

                     # data identification - spatial representation type []
                     aSpatialType = hResource[:spatialRepresentationTypes]
                     aSpatialType.each do |spType|
                        @xml.tag!('gmd:spatialRepresentationType') do
                           codelistClass.writeXML('gmd', 'iso_spatialRepresentation', spType)
                        end
                     end
                     if aSpatialType.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:spatialRepresentationType')
                     end

                     # data identification - spatial resolution []
                     aSpatialRes = hResource[:spatialResolutions]
                     aSpatialRes.each do |hSpRes|
                        @xml.tag!('gmd:spatialResolution') do
                           resolutionClass.writeXML(hSpRes)
                        end
                     end
                     if aSpatialRes.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:spatialResolution')
                     end

                     # data identification - language [] (required)
                     aLocale = hResource[:otherResourceLocales]
                     aLocale.insert(0, hResource[:defaultResourceLocale])
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
                              codelistClass.writeXML('gmd', 'iso_characterSet', s)
                              charSets += 1
                           end
                        end
                     end
                     if charSets == 0
                        @xml.tag!('gmd:language') do
                           @xml.tag!('gco:CharacterString', 'eng; USA')
                        end
                     end

                     # data identification - topic category [] {MD_TopicCategoryCode}
                     # get from hData.keywords where keywordType='isoTopicCategory'
                     aTopics = []
                     aKeywords = hResource[:keywords]
                     aKeywords.each do |hKeyword|
                        if hKeyword[:keywordType] == 'isoTopicCategory'
                           hKeyword[:keywords].each do |hKeyObj|
                              aTopics << hKeyObj[:keyword]
                           end
                        end
                     end
                     # only allow valid ISO 19115-2 topic categories to be written
                     aTopics.each do |topic|
                        if CodelistFun.validateItem('iso_topicCategory', topic)
                           @xml.tag!('gmd:topicCategory') do
                              @xml.tag!('gmd:MD_TopicCategoryCode', topic)
                           end
                        else
                           @NameSpace.issueWarning(380, 'gmd:topicCategory', "#{topic}")
                        end
                     end
                     if aTopics.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:topicCategory')
                     end

                     # data identification - environment description
                     s = hResource[:environmentDescription]
                     unless s.nil?
                        @xml.tag!('gmd:environmentDescription') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:environmentDescription')
                     end

                     # data identification - extent []
                     aExtents = hResource[:extents]
                     aExtents.each do |hExtent|
                        @xml.tag!('gmd:extent') do
                           extentClass.writeXML(hExtent)
                        end
                     end
                     if aExtents.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:extent')
                     end

                     # data identification - supplemental info
                     s = hResource[:supplementalInfo]
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
