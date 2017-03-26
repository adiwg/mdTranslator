# HTML writer
# resource information

# History:
#  Stan Smith 2017-03-25 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-24 original script

require_relative 'html_resourceType'
# require_relative 'html_resourceGeneral'
# require_relative 'html_resourceContact'
# require_relative 'html_maintenance'
# require_relative 'html_keyword'
# require_relative 'html_legalConstraint'
# require_relative 'html_securityConstraint'
# require_relative 'html_taxonomy'
# require_relative 'html_spatialReferenceSystem'
# require_relative 'html_resolution'
# require_relative 'html_dataLineage'
# require_relative 'html_extent'
# require_relative 'html_resourceOther'
# require_relative 'html_gridInfo'
# require_relative 'html_coverageInfo'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_ResourceInfo

               def initialize(html)
                  @html = html
               end

               def writeHtml(hResource)

                  # classes used
                  typeClass = Html_ResourceType.new(@html)
                  # htmlResGen = MdHtmlResourceGeneral.new(@html)
                  # htmlResCon = MdHtmlResourceContact.new(@html)
                  # htmlResMaint = Html_Maintenance.new(@html)
                  # htmlKeyword = MdHtmlKeyword.new(@html)
                  # htmlLegalCon = MdHtmlLegalConstraint.new(@html)
                  # htmlSecCon = MdHtmlSecurityConstraint.new(@html)
                  # htmlTaxon = MdHtmlTaxonomy.new(@html)
                  # htmlSpatialRef = MdHtmlSpatialReferenceSystem.new(@html)
                  # htmlResolution = MdHtmlResolution.new(@html)
                  # htmlLineage = MdHtmlDataLineage.new(@html)
                  # htmlExtent = MdHtmlExtent.new(@html)
                  # htmlOther = MdHtmlResourceOther.new(@html)
                  # htmlGrid = MdHtmlGridInfo.new(@html)
                  # htmlCover = MdHtmlCoverageInfo.new(@html)

                  # resource - type [] {resourceType}
                  hResource[:resourceTypes].each do |hType|
                     typeClass.writeHtml(hType)
                  end



                  # # resource information - general
                  # @html.details do
                  #    @html.summary('Resource Identification', {'id' => 'hResource-general', 'class' => 'h3'})
                  #    @html.section(:class => 'block') do
                  #       htmlResGen.writeHtml(hResource)
                  #    end
                  # end
                  #
                  # # resource information - contacts
                  # @html.details do
                  #    @html.summary('Contacts', {'id' => 'hResource-contacts', 'class' => 'h3'})
                  #    @html.section(:class => 'block') do
                  #       htmlResCon.writeHtml(hResource)
                  #    end
                  # end
                  #
                  # # resource information - keywords
                  # unless hResource[:descriptiveKeywords].empty?
                  #    @html.details do
                  #       @html.summary('Keywords', {'id' => 'hResource-keywords', 'class' => 'h3'})
                  #       @html.section(:class => 'block') do
                  #          hResource[:descriptiveKeywords].each do |hKeyList|
                  #             @html.em('List type: ')
                  #             htmlKeyword.writeHtml(hKeyList)
                  #          end
                  #       end
                  #    end
                  # end
                  #
                  # # resource information - taxonomy
                  # unless hResource[:taxonomy].empty?
                  #    @html.details do
                  #       @html.summary('Taxonomy', {'id' => 'hResource-taxonomy', 'class' => 'h3'})
                  #       hTaxon = hResource[:taxonomy]
                  #       @html.section(:class => 'block') do
                  #          htmlTaxon.writeHtml(hTaxon)
                  #       end
                  #    end
                  # end
                  #
                  # # resource information - spatial reference
                  # unless hResource[:spatialReferenceSystem].empty? &&
                  #    hResource[:spatialRepresentationTypes].empty? &&
                  #    hResource[:spatialResolutions].empty?
                  #    @html.details do
                  #       @html.summary('Spatial Reference', {'id' => 'hResource-spatialRef', 'class' => 'h3'})
                  #       @html.section(:class => 'block') do
                  #
                  #          # spatial reference - spatial reference system
                  #          hSpatialRef = hResource[:spatialReferenceSystem]
                  #          if !hSpatialRef.empty?
                  #             @html.details do
                  #                @html.summary('Spatial Reference System', {'id' => 'spatialReference-system', 'class' => 'h4'})
                  #                @html.section(:class => 'block') do
                  #                   htmlSpatialRef.writeHtml(hSpatialRef)
                  #                end
                  #             end
                  #          end
                  #
                  #          # spatial reference - spatial representation types
                  #          aSpatialRep = hResource[:spatialRepresentationTypes]
                  #          if !aSpatialRep.empty?
                  #             @html.details do
                  #                @html.summary('Spatial Representation Type', {'id' => 'spatialReference-representationType', 'class' => 'h4'})
                  #                @html.section(:class => 'block') do
                  #                   @html.em('Types: ')
                  #                   @html.text!(aSpatialRep.to_s)
                  #                end
                  #             end
                  #          end
                  #
                  #          # spatial reference - spatial resolution
                  #          aSpatialRes = hResource[:spatialResolutions]
                  #          if !aSpatialRes.empty?
                  #             @html.details do
                  #                @html.summary('Spatial Resolution', {'id' => 'spatialReference-resolution', 'class' => 'h4'})
                  #                @html.section(:class => 'block') do
                  #                   aSpatialRes.each do |hResolution|
                  #                      htmlResolution.writeHtml(hResolution)
                  #                   end
                  #                end
                  #             end
                  #          end
                  #
                  #       end
                  #    end
                  # end
                  #
                  # # resource information - extents
                  # unless hResource[:extents].empty?
                  #    @html.details do
                  #       @html.summary('Extents (Geographic, Temporal, & Vertical Space)', {'id' => 'hResource-extents', 'class' => 'h3'})
                  #       extNum = 0
                  #       @html.section(:class => 'block') do
                  #          aExtents = hResource[:extents]
                  #          aExtents.each do |hExtent|
                  #             @html.details do
                  #                @html.summary('Extent ' + extNum.to_s, {'class' => 'h4 extent'})
                  #                @html.section(:class => 'block extent-section') do
                  #                   htmlExtent.writeHtml(hExtent, extNum)
                  #                   extNum += 1
                  #                end
                  #             end
                  #          end
                  #       end
                  #    end
                  # end
                  #
                  # # resource information - grid information
                  # unless hResource[:gridInfo].empty?
                  #    @html.details do
                  #       @html.summary('Grid Information ', {'id' => 'hResource-gridInfo', 'class' => 'h3'})
                  #       @html.section(:class => 'block') do
                  #          aGridInfo = hResource[:gridInfo]
                  #          aGridInfo.each do |hGrid|
                  #             @html.details do
                  #                @html.summary('Grid', {:class => 'h4'})
                  #                @html.section(:class => 'block') do
                  #                   htmlGrid.writeHtml(hGrid)
                  #                end
                  #             end
                  #          end
                  #       end
                  #    end
                  # end
                  #
                  # # resource information - coverage information
                  # unless hResource[:coverageInfo].empty?
                  #    @html.details do
                  #       @html.summary('Coverage Information ', {'id' => 'hResource-coverageInfo', 'class' => 'h3'})
                  #       @html.section(:class => 'block') do
                  #          aCoverage = hResource[:coverageInfo]
                  #          aCoverage.each do |hCover|
                  #
                  #             # get coverage type
                  #             coverType = hCover[:coverageType]
                  #             if coverType.nil?
                  #                coverType = 'Unknown type'
                  #             end
                  #             # get coverage name
                  #             coverName = hCover[:coverageName]
                  #             if coverName.nil?
                  #                coverName = 'Coverage'
                  #             end
                  #             @html.details do
                  #                @html.summary(coverName + ' (' + coverType + ')', {:class => 'h4'})
                  #                @html.section(:class => 'block') do
                  #                   htmlCover.writeHtml(hCover)
                  #                end
                  #             end
                  #
                  #          end
                  #       end
                  #    end
                  # end
                  #
                  # # resource information - data quality
                  # unless hResource[:dataQualityInfo].empty?
                  #    @html.details do
                  #       @html.summary('Data Quality', {'id' => 'hResource-dataQuality', 'class' => 'h3'})
                  #       @html.section(:class => 'block') do
                  #          aDataQual = hResource[:dataQualityInfo]
                  #          aDataQual.each do |hDataQual|
                  #             @html.details do
                  #                @html.summary('Quality statement', {'class' => 'h4'})
                  #                @html.section(:class => 'block') do
                  #
                  #                   # data quality - scope
                  #                   s = hDataQual[:dataScope]
                  #                   if !s.nil?
                  #                      @html.em('Scope: ')
                  #                      @html.text!(s)
                  #                      @html.br
                  #                   end
                  #
                  #                   # data quality - lineage
                  #                   hLineage = hDataQual[:dataLineage]
                  #                   if !hLineage.empty?
                  #                      htmlLineage.writeHtml(hLineage)
                  #                   end
                  #
                  #                end
                  #             end
                  #          end
                  #       end
                  #    end
                  # end
                  #
                  # # resource information - constraints
                  # unless hResource[:useConstraints].empty? &&
                  #    hResource[:legalConstraints].empty? &&
                  #    hResource[:securityConstraints].empty?
                  #    @html.details do
                  #       @html.summary('Constraints', {'id' => 'hResource-constraints', 'class' => 'h3'})
                  #       @html.section(:class => 'block') do
                  #
                  #          # constraints - use constraints
                  #          aUseCons = hResource[:useConstraints]
                  #          if !aUseCons.empty?
                  #             @html.details do
                  #                @html.summary('Usage Constraints', {'class' => 'h4'})
                  #                @html.section(:class => 'block') do
                  #                   aUseCons.each do |uCon|
                  #                      @html.em('Constraint: ')
                  #                      @html.text!(uCon)
                  #                      @html.br
                  #                   end
                  #                end
                  #             end
                  #          end
                  #
                  #          # constraint - legal constraint
                  #          aLegalCons = hResource[:legalConstraints]
                  #          if !aLegalCons.empty?
                  #             @html.details do
                  #                @html.summary('Legal Constraints', {'class' => 'h4'})
                  #                @html.section(:class => 'block') do
                  #                   aLegalCons.each do |hLegalCon|
                  #                      @html.em('Constraint: ')
                  #                      @html.section(:class => 'block') do
                  #                         htmlLegalCon.writeHtml(hLegalCon)
                  #                      end
                  #                   end
                  #                end
                  #             end
                  #          end
                  #
                  #          # constraint - security
                  #          aSecCons = hResource[:securityConstraints]
                  #          if !aSecCons.empty?
                  #             @html.details do
                  #                @html.summary('Security Constraints', {'class' => 'h4'})
                  #                @html.section(:class => 'block') do
                  #                   aSecCons.each do |hSecCon|
                  #                      @html.em('Constraint: ')
                  #                      @html.section(:class => 'block') do
                  #                         htmlSecCon.writeHtml(hSecCon)
                  #                      end
                  #                   end
                  #                end
                  #             end
                  #          end
                  #
                  #       end
                  #    end
                  # end
                  #
                  # # resource information - maintenance information
                  # unless hResource[:resourceMaint].empty?
                  #    @html.details do
                  #       @html.summary('Maintenance Information', {'id' => 'hResource-maintInfo', 'class' => 'h3'})
                  #       @html.section(:class => 'block') do
                  #          hResource[:resourceMaint].each do |hResMaint|
                  #             @html.em('Resource maintenance: ')
                  #             htmlResMaint.writeHtml(hResMaint)
                  #          end
                  #       end
                  #    end
                  # end
                  #
                  # # resource information - resource other
                  # @html.details do
                  #    @html.summary('Other Resource Information', {'id' => 'hResource-other', 'class' => 'h3'})
                  #    @html.section(:class => 'block') do
                  #       htmlOther.writeHtml(hResource)
                  #    end
                  # end

               end # writeHtml
            end # Html_ResourceInfo

         end
      end
   end
end
