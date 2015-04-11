# HTML writer
# resource information section

# History:
# 	Stan Smith 2015-03-24 original script

require 'html_resourceGeneral'
require 'html_resourceContact'
require 'html_resourceMaint'
require 'html_keyword'
require 'html_legalConstraint'
require 'html_securityConstraint'
require 'html_taxonomy'
require 'html_spatialReferenceSystem'
require 'html_resolution'
require 'html_dataLineage'
require 'html_extent'
require 'html_resourceOther'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlResourceInfo
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(resourceInfo)

                        # classes used
                        htmlResGen = $HtmlNS::MdHtmlResourceGeneral.new(@html)
                        htmlResCon = $HtmlNS::MdHtmlResourceContact.new(@html)
                        htmlResMaint = $HtmlNS::MdHtmlResourceMaintenance.new(@html)
                        htmlKeyword = $HtmlNS::MdHtmlKeyword.new(@html)
                        htmlLegalCon = $HtmlNS::MdHtmlLegalConstraint.new(@html)
                        htmlSecCon = $HtmlNS::MdHtmlSecurityConstraint.new(@html)
                        htmlTaxon = $HtmlNS::MdHtmlTaxonomy.new(@html)
                        htmlSpatialRef = $HtmlNS::MdHtmlSpatialReferenceSystem.new(@html)
                        htmlResolution = $HtmlNS::MdHtmlResolution.new(@html)
                        htmlLineage = $HtmlNS::MdHtmlDataLineage.new(@html)
                        htmlExtent = $HtmlNS::MdHtmlExtent.new(@html)
                        htmlOther = $HtmlNS::MdHtmlResourceOther.new(@html)

                        # resource information - general
                        @html.details do
                            @html.summary('Resource Identification', {'id'=>'resourceInfo-general', 'class'=>'h3'})
                            @html.section(:class=>'block') do
                                htmlResGen.writeHtml(resourceInfo)
                            end
                        end

                        # resource information - contacts
                        @html.details do
                            @html.summary('Contacts', {'id'=>'resourceInfo-contacts', 'class'=>'h3'})
                            @html.section(:class=>'block') do
                                htmlResCon.writeHtml(resourceInfo)
                            end
                        end

                        # resource information - keywords
                        @html.details do
                            @html.summary('Keywords', {'id'=>'resourceInfo-keywords', 'class'=>'h3'})
                            if !resourceInfo[:descriptiveKeywords].empty?
                                @html.section(:class=>'block') do
                                    resourceInfo[:descriptiveKeywords].each do |hKeyList|
                                        @html.em('List type: ')
                                        htmlKeyword.writeHtml(hKeyList)
                                    end
                                end
                            end
                        end

                        # resource information - taxonomy
                        @html.details do
                            @html.summary('Taxonomy', {'id'=>'resourceInfo-taxonomy', 'class'=>'h3'})
                            hTaxon = resourceInfo[:taxonomy]
                            if !hTaxon.empty?
                                @html.section(:class=>'block') do
                                    htmlTaxon.writeHtml(hTaxon)
                                end
                            end
                        end

                        # resource information - spatial reference
                        @html.details do
                            @html.summary('Spatial Reference', {'id'=>'resourceInfo-spatialRef', 'class'=>'h3'})
                            @html.section(:class=>'block') do

                                # spatial reference - spatial reference system
                                hSpatialRef = resourceInfo[:spatialReferenceSystem]
                                if !hSpatialRef.empty?
                                    @html.details do
                                        @html.summary('Spatial Reference System', {'id'=>'spatialReference-system', 'class'=>'h4'})
                                        @html.section(:class=>'block') do
                                            htmlSpatialRef.writeHtml(hSpatialRef)
                                        end
                                    end
                                end

                                # spatial reference - spatial representation types
                                aSpatialRep = resourceInfo[:spatialRepresentationTypes]
                                if !aSpatialRep.empty?
                                    @html.details do
                                        @html.summary('Spatial Representation Type', {'id'=>'spatialReference-representationType', 'class'=>'h4'})
                                        @html.section(:class=>'block') do
                                            @html.em('Types: ')
                                            @html.text!(aSpatialRep.to_s)
                                        end
                                    end
                                end

                                # spatial reference - spatial resolution
                                aSpatialRes = resourceInfo[:spatialResolutions]
                                if !aSpatialRes.empty?
                                    @html.details do
                                        @html.summary('Spatial Resolution', {'id'=>'spatialReference-resolution', 'class'=>'h4'})
                                        @html.section(:class=>'block') do
                                            aSpatialRes.each do |hResolution|
                                                htmlResolution.writeHtml(hResolution)
                                            end
                                        end
                                    end
                                end

                            end
                        end

                        # resource information - extents
                        @html.details do
                            @html.summary('Extents (Geographic, Temporal, & Vertical Space)', {'id'=>'resourceInfo-extents', 'class'=>'h3'})
                            extNum = 0
                            @html.section(:class=>'block') do
                                aExtents = resourceInfo[:extents]
                                aExtents.each do |hExtent|
                                    @html.details do
                                        @html.summary('Extent ' + extNum.to_s, {'class'=>'h4 extent'})
                                        @html.section(:class=>'block') do
                                            htmlExtent.writeHtml(hExtent, extNum)
                                            extNum += 1
                                        end
                                    end
                                end
                            end
                        end

                        # resource information - data quality
                        @html.details do
                            @html.summary('Data Quality', {'id'=>'resourceInfo-dataQuality', 'class'=>'h3'})
                            @html.section(:class=>'block') do
                                aDataQual = resourceInfo[:dataQualityInfo]
                                aDataQual.each do |hDataQual|
                                    @html.details do
                                        @html.summary('Quality statement', {'class'=>'h4'})
                                        @html.section(:class=>'block') do

                                            # data quality - scope
                                            s = hDataQual[:dataScope]
                                            if !s.nil?
                                                @html.em('Scope: ')
                                                @html.text!(s)
                                                @html.br
                                            end

                                            # data quality - lineage
                                            hLineage = hDataQual[:dataLineage]
                                            if !hLineage.empty?
                                                htmlLineage.writeHtml(hLineage)
                                            end

                                        end
                                    end
                                end
                            end
                        end

                        # resource information - constraints
                        @html.details do
                            @html.summary('Constraints', {'id'=>'resourceInfo-constraints', 'class'=>'h3'})
                            @html.section(:class=>'block') do

                                # constraints - use constraints
                                aUseCons = resourceInfo[:useConstraints]
                                if !aUseCons.empty?
                                    @html.details do
                                        @html.summary('Usage Constraints', {'class'=>'h4'})
                                        @html.section(:class=>'block') do
                                            aUseCons.each do |uCon|
                                                @html.em('Constraint: ')
                                                @html.text!(uCon)
                                                @html.br
                                            end
                                        end
                                    end
                                end

                                # constraint - legal constraint
                                aLegalCons = resourceInfo[:legalConstraints]
                                if !aLegalCons.empty?
                                    @html.details do
                                        @html.summary('Legal Constraints', {'class'=>'h4'})
                                        @html.section(:class=>'block') do
                                            aLegalCons.each do |hLegalCon|
                                                @html.em('Constraint: ')
                                                @html.section(:class=>'block') do
                                                    htmlLegalCon.writeHtml(hLegalCon)
                                                end
                                            end
                                        end
                                    end
                                end

                                # constraint - security
                                aSecCons = resourceInfo[:securityConstraints]
                                if !aSecCons.empty?
                                    @html.details do
                                        @html.summary('Security Constraints', {'class'=>'h4'})
                                        @html.section(:class=>'block') do
                                            aSecCons.each do |hSecCon|
                                                @html.em('Constraint: ')
                                                @html.section(:class=>'block') do
                                                    htmlSecCon.writeHtml(hSecCon)
                                                end
                                            end
                                        end
                                    end
                                end

                            end
                        end

                        # resource information - maintenance information
                        @html.details do
                            @html.summary('Maintenance Information', {'id'=>'resourceInfo-maintInfo', 'class'=>'h3'})
                            if !resourceInfo[:resourceMaint].empty?
                                @html.section(:class=>'block') do
                                    resourceInfo[:resourceMaint].each do |hResMaint|
                                        @html.em('Resource maintenance: ')
                                        htmlResMaint.writeHtml(hResMaint)
                                    end
                                end
                            end
                        end

                        # resource information - resource other
                        @html.details do
                            @html.summary('Other Resource Information', {'id'=>'resourceInfo-other', 'class'=>'h3'})
                            @html.section(:class=>'block') do
                                htmlOther.writeHtml(resourceInfo)
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
