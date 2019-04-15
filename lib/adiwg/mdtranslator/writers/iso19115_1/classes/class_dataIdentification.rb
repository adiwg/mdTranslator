# ISO <<Class>> MD_DataIdentification
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-21 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/internal/module_codelistFun'
require_relative '../iso19115_1_writer'
require_relative 'class_codelist'
require_relative 'class_citation'
require_relative 'class_responsibility'
require_relative 'class_resolution'
require_relative 'class_extent'
require_relative 'class_maintenance'
require_relative 'class_browseGraphic'
require_relative 'class_format'
require_relative 'class_keyword'
require_relative 'class_usage'
require_relative 'class_constraint'
require_relative 'class_associatedResource'
require_relative 'class_locale'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_DataIdentification

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hMetadata)

                  # classes used
                  intMetadataClass = InternalMetadata.new
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  citationClass = CI_Citation.new(@xml, @hResponseObj)
                  responsibilityClass = CI_Responsibility.new(@xml, @hResponseObj)
                  resolutionClass = MD_Resolution.new(@xml, @hResponseObj)
                  extentClass = EX_Extent.new(@xml, @hResponseObj)
                  maintClass = MD_MaintenanceInformation.new(@xml, @hResponseObj)
                  graphicClass = MD_BrowseGraphic.new(@xml, @hResponseObj)
                  formatClass = MD_Format.new(@xml, @hResponseObj)
                  keywordClass = MD_Keywords.new(@xml, @hResponseObj)
                  useClass = MD_Usage.new(@xml, @hResponseObj)
                  constraintClass = Constraint.new(@xml, @hResponseObj)
                  associatedClass = MD_AssociatedResource.new(@xml, @hResponseObj)
                  localeClass = PT_Locale.new(@xml, @hResponseObj)
                  # resolutionClass = MD_Resolution.new(@xml, @hResponseObj)

                  # create shortcuts to sections of internal object
                  hResource = hMetadata[:resourceInfo]
                  aAssocRes = hMetadata[:associatedResources]

                  # data identification
                  @xml.tag!('mri:MD_DataIdentification') do

                     # data identification - citation {CI_Citation} (required)
                     hCitation = hResource[:citation]
                     unless hCitation.empty?
                        @xml.tag!('mri:citation') do
                           citationClass.writeXML(hCitation, 'main resource')
                        end
                     end
                     if hCitation.empty?
                        @NameSpace.issueWarning(50, 'mri:citation')
                     end

                     # data identification - abstract (required)
                     unless hResource[:abstract].nil?
                        @xml.tag!('mri:abstract') do
                           @xml.tag!('gco:CharacterString', hResource[:abstract])
                        end
                     end
                     if hResource[:abstract].nil?
                        @NameSpace.issueWarning(51, 'mri:abstract')
                     end

                     # data identification - purpose
                     unless hResource[:purpose].nil?
                        @xml.tag!('mri:purpose') do
                           @xml.tag!('gco:CharacterString', hResource[:purpose])
                        end
                     end
                     if hResource[:purpose].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:purpose')
                     end

                     # data identification - credit []
                     aCredits = hResource[:credits]
                     aCredits.each do |credit|
                        @xml.tag!('mri:credit') do
                           @xml.tag!('gco:CharacterString', credit)
                        end
                     end
                     if aCredits.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:credit')
                     end

                     # data identification - status [] {MD_ProgressCode}
                     aStatus = hResource[:status]
                     aStatus.each do |code|
                        @xml.tag!('mri:status') do
                           codelistClass.writeXML('mcc', 'iso_progress', code)
                        end
                     end
                     if aStatus.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:status')
                     end

                     # data identification - point of contact [] {CI_Responsibility}
                     aContacts = hResource[:pointOfContacts]
                     aContacts.each do |hContact|
                        unless hContact.empty?
                           @xml.tag!('mri:pointOfContact') do
                              responsibilityClass.writeXML(hContact, 'metadata information')
                           end
                        end
                     end
                     if aContacts.empty? && @hResponseObj[:writerShowTags]
                        @NameSpace.issueWarning(52, 'mri:pointOfContact')
                     end

                     # data identification - spatial representation type [] {MD_SpatialRepresentationTypeCode}
                     aSpatialTypes = hResource[:spatialRepresentationTypes]
                     aSpatialTypes.each do |code|
                        @xml.tag!('mri:spatialRepresentationType') do
                           codelistClass.writeXML('mri', 'iso_spatialRepresentation', code)
                        end
                     end
                     if aSpatialTypes.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:spatialRepresentationType')
                     end

                     # data identification - spatial resolution [] {MD_Resolution}
                     aSpatialRes = hResource[:spatialResolutions]
                     aSpatialRes.each do |hResolution|
                        @xml.tag!('mri:spatialResolution') do
                           resolutionClass.writeXML(hResolution, 'resource information')
                        end
                     end
                     if aSpatialRes.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:spatialResolution')
                     end

                     # data identification - temporal resolution [] {TM_PeriodDuration}
                     aTemporalRes = hResource[:temporalResolutions]
                     aTemporalRes.each do |hResolution|
                        @xml.tag!('mri:temporalResolution') do
                           duration = AdiwgDateTimeFun.writeDuration(hResolution)
                           @xml.tag!('gco:TM_PeriodDuration', duration)
                        end
                     end
                     if aTemporalRes.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:temporalResolution')
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
                     # only allow valid ISO 19115-1 topic categories to be written
                     aTopics.each do |topic|
                        if CodelistFun.validateItem('iso_topicCategory', topic)
                           @xml.tag!('mri:topicCategory') do
                              @xml.tag!('mri:MD_TopicCategoryCode', topic)
                           end
                        else
                           @NameSpace.issueWarning(400, 'mri:topicCategory', "#{topic}")
                        end
                     end
                     if aTopics.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:topicCategory')
                     end

                     # package mdJson time period {timePeriod} as a temporal extent
                     unless hResource[:timePeriod].empty?
                        hExtent = intMetadataClass.newExtent
                        hTempExtent = intMetadataClass.newTemporalExtent
                        hTempExtent[:timePeriod] = hResource[:timePeriod]
                        hExtent[:temporalExtents] << hTempExtent
                        hResource[:extents] << hExtent
                     end

                     # data identification - extent [] {EX_Extent}
                     aExtents = hResource[:extents]
                     aExtents.each do |hExtent|
                        @xml.tag!('mri:extent') do
                           extentClass.writeXML(hExtent)
                        end
                     end
                     if aExtents.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:extent')
                     end

                     # data identification - additional documentation [] {CI_Citation}
                     aDocuments = hMetadata[:additionalDocuments]
                     aDocuments.each do |hDoc|
                        @xml.tag!('mri:additionalDocumentation') do
                           citationClass.writeXML(hDoc)
                        end
                     end
                     if aDocuments.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:additionalDocumentation')
                     end

                     # data identification - processing level {MD_Identifier} - not implemented

                     # data identification - resource maintenance [] {MD_MaintenanceInformation}
                     aMaint = hResource[:resourceMaintenance]
                     aMaint.each do |hMaint|
                        @xml.tag!('mri:resourceMaintenance') do
                           maintClass.writeXML(hMaint, 'resource information')
                        end
                     end
                     if aMaint.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:resourceMaintenance')
                     end

                     # data identification - graphic overview []
                     aGraphics = hResource[:graphicOverviews]
                     aGraphics.each do |hGraphic|
                        @xml.tag!('mri:graphicOverview') do
                           graphicClass.writeXML(hGraphic, 'resource information')
                        end
                     end
                     if aGraphics.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:graphicOverview')
                     end

                     # data identification - resource format [] {MD_Format}
                     aFormats = hResource[:resourceFormats]
                     aFormats.each do |hFormat|
                        @xml.tag!('mri:resourceFormat') do
                           formatClass.writeXML(hFormat)
                        end
                     end
                     if aFormats.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:resourceFormat')
                     end

                     # data identification - descriptive keywords [] {MD_Keywords}
                     aKeywords = hResource[:keywords]
                     aKeywords.each do |hKeyword|
                        @xml.tag!('mri:descriptiveKeywords') do
                           keywordClass.writeXML(hKeyword)
                        end
                     end
                     if aKeywords.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mir:descriptiveKeywords')
                     end

                     # data identification - resource specific usage [] {MD_Usage}
                     aUses = hResource[:resourceUsages]
                     aUses.each do |hResUse|
                        @xml.tag!('mri:resourceSpecificUsage') do
                           useClass.writeXML(hResUse)
                        end
                     end
                     if aUses.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:resourceSpecificUsage')
                     end

                     # data identification - resource constraints [] {MD_Constraints}
                     aConstraint = hResource[:constraints]
                     aConstraint.each do |hCon|
                        @xml.tag!('mri:resourceConstraints') do
                           constraintClass.writeXML(hCon, 'resource information')
                        end
                     end
                     if aConstraint.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:resourceConstraints')
                     end

                     # data identification - associated resource [] {MD_AssociatedResource}
                     aAssocRes.each do |hAssocRes|
                        @xml.tag!('mri:associatedResource') do
                           associatedClass.writeXML(hAssocRes, 'resource information')
                        end
                     end
                     if aAssocRes.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:associatedResource')
                     end

                     # data identification - default locale {PT_Locale}
                     unless hResource[:defaultResourceLocale].empty?
                        @xml.tag!('mri:defaultLocale') do
                          localeClass.writeXML(hResource[:defaultResourceLocale], 'resource information default')
                        end
                     end
                     if hResource[:defaultResourceLocale].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:defaultLocale')
                     end

                     # data identification - other locales [] {PT_Locale}
                     aLocales = hResource[:otherResourceLocales]
                     aLocales.each do |hLocale|
                        @xml.tag!('mri:otherLocale') do
                           localeClass.writeXML(hLocale, 'resource information other')
                        end
                     end
                     if aLocales.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:otherLocale')
                     end

                     # data identification - environment description
                     unless hResource[:environmentDescription].nil?
                        @xml.tag!('mri:environmentDescription') do
                           @xml.tag!('gco:CharacterString', hResource[:environmentDescription])
                        end
                     end
                     if hResource[:environmentDescription].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:environmentDescription')
                     end

                     # data identification - supplemental info
                     unless hResource[:supplementalInfo].nil?
                        @xml.tag!('mri:supplementalInformation') do
                           @xml.tag!('gco:CharacterString', hResource[:supplementalInfo])
                        end
                     end
                     if hResource[:supplementalInfo].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:supplementalInformation')
                     end

                  end # mri:MD_DataIdentification tag
               end # writeXML
            end # MD_DataIdentification class

         end
      end
   end
end
