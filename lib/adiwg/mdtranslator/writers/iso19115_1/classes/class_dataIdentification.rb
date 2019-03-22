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
# require_relative 'class_keyword'
# require_relative 'class_usage'
# require_relative 'class_useConstraints'
# require_relative 'class_legalConstraints'
# require_relative 'class_securityConstraints'
# require_relative 'class_aggregateInformation'
# require_relative 'class_taxonomy'
# require_relative 'class_resolution'

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
                  # aggInfoClass = MD_AggregateInformation.new(@xml, @hResponseObj)
                  # keywordClass = MD_Keywords.new(@xml, @hResponseObj)
                  # useClass = MD_Usage.new(@xml, @hResponseObj)
                  # uConClass = MD_Constraints.new(@xml, @hResponseObj)
                  # lConClass = MD_LegalConstraints.new(@xml, @hResponseObj)
                  # sConClass = MD_SecurityConstraints.new(@xml, @hResponseObj)
                  # taxClass = MD_TaxonSys.new(@xml, @hResponseObj)
                  # resolutionClass = MD_Resolution.new(@xml, @hResponseObj)

                  # create shortcuts to sections of internal object
                  hResource = hMetadata[:resourceInfo]
                  aAssocRes = hMetadata[:associatedResources]
                  aDocuments = hMetadata[:additionalDocuments]
                  aDistInfo = hMetadata[:distributorInfo]

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
                           codelistClass.writeXML('mri', 'iso_progress', code)
                        end
                     end
                     if aStatus.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:status')
                     end

                     # data identification - point of contact [] {CI_Responsibility}
                     aRParties = hResource[:pointOfContacts]
                     aRParties.each do |hRParty|
                        aParties = hRParty[:parties]
                        aParties.each do |hParty|
                           @xml.tag!('mri:pointOfContact') do
                              responsibilityClass.writeXML(hParty, 'resource point of contact')
                           end
                        end
                     end
                     if aRParties.empty? && @hResponseObj[:writerShowTags]
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
                        @xml.tag!('gco:temporalResolution')
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
                        @xml.tag!('gmd:additionalDocumentation') do
                           citationClass.writeXML(hDoc)
                        end
                     end
                     if aDocuments.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:additionalDocumentation')
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
                        @xml.tag!('gmd:resourceMaintenance')
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

                     # # data identification - descriptive keywords []
                     # aKeywords = hData[:keywords]
                     # aKeywords.each do |hKeyword|
                     #    @xml.tag!('gmd:descriptiveKeywords') do
                     #       keywordClass.writeXML(hKeyword)
                     #    end
                     # end
                     # if aKeywords.empty? && @hResponseObj[:writerShowTags]
                     #    @xml.tag!('gmd:descriptiveKeywords')
                     # end
                     #



                     # # data identification - associated resource []
                     # aAssocRes.each do |hAssocRes|
                     #    @xml.tag!('gmd:aggregationInfo') do
                     #       aggInfoClass.writeXML(hAssocRes)
                     #    end
                     # end
                     # if aAssocRes.empty? && @hResponseObj[:writerShowTags]
                     #    @xml.tag!('gmd:aggregationInfo')
                     # end
                     #
                     # # data identification - resource specific usage []
                     # aUses = hData[:resourceUsages]
                     # aUses.each do |hResUse|
                     #    @xml.tag!('gmd:resourceSpecificUsage') do
                     #       useClass.writeXML(hResUse)
                     #    end
                     # end
                     # if aUses.empty? && @hResponseObj[:writerShowTags]
                     #    @xml.tag!('gmd:resourceSpecificUsage')
                     # end
                     #
                     # # data identification - resource constraints {}
                     # haveCon = false
                     # aCons = hData[:constraints]
                     # aCons.each do |hCon|
                     #    @xml.tag!('gmd:resourceConstraints') do
                     #       type = hCon[:type]
                     #       if type == 'use'
                     #          uConClass.writeXML(hCon)
                     #       end
                     #       if type == 'legal'
                     #          lConClass.writeXML(hCon)
                     #       end
                     #       if type == 'security'
                     #          sConClass.writeXML(hCon)
                     #       end
                     #       haveCon = true
                     #    end
                     # end
                     #
                     # # data identification - resource constraints {}  from distribution liability statement
                     # aDistInfo.each do |hDistribution|
                     #    unless hDistribution.empty?
                     #       unless hDistribution[:liabilityStatement].nil?
                     #          @xml.tag!('gmd:resourceConstraints') do
                     #             @xml.tag!('gmd:MD_LegalConstraints') do
                     #                @xml.tag!('gmd:otherConstraints') do
                     #                   @xml.tag!('gco:CharacterString', hDistribution[:liabilityStatement])
                     #                end
                     #             end
                     #          end
                     #          haveCon = true
                     #       end
                     #    end
                     # end
                     #
                     # if !haveCon && @hResponseObj[:writerShowTags]
                     #    @xml.tag!('gmd:resourceConstraints')
                     # end
                     #
                     # # data identification - taxonomy (first)
                     # unless hData[:taxonomy].empty?
                     #    hTaxonomy = hData[:taxonomy][0]
                     #    unless hTaxonomy.empty?
                     #       @xml.tag!('gmd:taxonomy') do
                     #          taxClass.writeXML(hTaxonomy)
                     #       end
                     #    end
                     #    if hData[:taxonomy].length > 1
                     #       @NameSpace.issueNotice(53, 'main resource')
                     #       @NameSpace.issueNotice(54, 'main resource')
                     #    end
                     # end
                     # if hData[:taxonomy].empty? && @hResponseObj[:writerShowTags]
                     #    @xml.tag!('gmd:taxonomy')
                     # end
                     #
                     # # data identification - spatial representation type []
                     # aSpatialType = hData[:spatialRepresentationTypes]
                     # aSpatialType.each do |spType|
                     #    @xml.tag!('gmd:spatialRepresentationType') do
                     #       codelistClass.writeXML('gmd', 'iso_spatialRepresentation', spType)
                     #    end
                     # end
                     # if aSpatialType.empty? && @hResponseObj[:writerShowTags]
                     #    @xml.tag!('gmd:spatialRepresentationType')
                     # end
                     #
                     # # data identification - spatial resolution []
                     # aSpatialRes = hData[:spatialResolutions]
                     # aSpatialRes.each do |hSpRes|
                     #    @xml.tag!('gmd:spatialResolution') do
                     #       resolutionClass.writeXML(hSpRes)
                     #    end
                     # end
                     # if aSpatialRes.empty? && @hResponseObj[:writerShowTags]
                     #    @xml.tag!('gmd:spatialResolution')
                     # end
                     #
                     # # data identification - language [] (required)
                     # aLocale = hData[:otherResourceLocales]
                     # aLocale.insert(0, hData[:defaultResourceLocale])
                     # aLocale.each do |hLocale|
                     #    s = hLocale[:languageCode]
                     #    unless hLocale[:countryCode].nil?
                     #       s += '; ' + hLocale[:countryCode]
                     #    end
                     #    @xml.tag!('gmd:language') do
                     #       @xml.tag!('gco:CharacterString', s)
                     #    end
                     # end
                     # if aLocale.empty?
                     #    @xml.tag!('gmd:language') do
                     #       @xml.tag!('gco:CharacterString', 'eng; USA')
                     #    end
                     # end
                     #
                     # # data identification - characterSet [] (default 'utf8')
                     # charSets = 0
                     # aLocale.each do |hLocale|
                     #    s = hLocale[:characterEncoding]
                     #    unless s.nil?
                     #       @xml.tag!('gmd:characterSet') do
                     #          codelistClass.writeXML('gmd', 'iso_characterSet', s)
                     #          charSets += 1
                     #       end
                     #    end
                     # end
                     # if charSets == 0
                     #    @xml.tag!('gmd:language') do
                     #       @xml.tag!('gco:CharacterString', 'eng; USA')
                     #    end
                     # end
                     #
                     # # data identification - topic category []
                     # # <- hData.keywords where keywordType='isoTopicCategory'
                     # aTopics = []
                     # aKeywords = hData[:keywords]
                     # aKeywords.each do |hKeyword|
                     #    if hKeyword[:keywordType] == 'isoTopicCategory'
                     #       hKeyword[:keywords].each do |hKeyObj|
                     #          aTopics << hKeyObj[:keyword]
                     #       end
                     #    end
                     # end
                     # # only allow valid ISO 19115-2 topic categories to be written
                     # aAcceptable = %w(farming biota boundaries climatologyMeteorologyAtmosphere economy
                     #                   elevation environment geoscientificInformation health imageryBaseMapsEarthCover
                     #                   intelligenceMilitary inlandWaters location oceans planningCadastre society
                     #                   structure transportation utilitiesCommunication)
                     # aTopics.each do |topic|
                     #    if aAcceptable.include?(topic)
                     #       @xml.tag!('gmd:topicCategory') do
                     #          enumerationClass.writeXML('iso_topicCategory', topic)
                     #       end
                     #    end
                     # end
                     # if aTopics.empty? && @hResponseObj[:writerShowTags]
                     #    @xml.tag!('gmd:topicCategory')
                     # end
                     #
                     # # data identification - environment description
                     # s = hData[:environmentDescription]
                     # unless s.nil?
                     #    @xml.tag!('gmd:environmentDescription') do
                     #       @xml.tag!('gco:CharacterString', s)
                     #    end
                     # end
                     # if s.nil? && @hResponseObj[:writerShowTags]
                     #    @xml.tag!('gmd:environmentDescription')
                     # end
                     #
                     # # data identification - supplemental info
                     # s = hData[:supplementalInfo]
                     # unless s.nil?
                     #    @xml.tag!('gmd:supplementalInformation') do
                     #       @xml.tag!('gco:CharacterString', s)
                     #    end
                     # end
                     # if s.nil? && @hResponseObj[:writerShowTags]
                     #    @xml.tag!('gmd:supplementalInformation')
                     # end

                  end # gmd:MD_DataIdentification tag
               end # writeXML
            end # MD_DataIdentification class

         end
      end
   end
end
