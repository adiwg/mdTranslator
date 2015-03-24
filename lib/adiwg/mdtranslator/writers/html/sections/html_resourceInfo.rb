# HTML writer
# resource information section

# History:
# 	Stan Smith 2015-03-23 original script

require 'html_resourceGeneral'
require 'html_resourceContact'
require 'html_resourceMaint'
require 'html_keyword'

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

                        # resource information - general
                        @html.details do
                            @html.summary('Resource Identification', {'id'=>'resourceInfo-general', 'class'=>'h3'})
                            @html.blockquote do
                                htmlResGen.writeHtml(resourceInfo)
                            end
                        end

                        # resource information - contacts
                        @html.details do
                            @html.summary('Contacts', {'id'=>'resourceInfo-contacts', 'class'=>'h3'})
                            @html.blockquote do
                                htmlResCon.writeHtml(resourceInfo)
                            end
                        end

                        # resource information - keywords
                        @html.details do
                            @html.summary('Keywords', {'id'=>'resourceInfo-keywords', 'class'=>'h3'})
                            if !resourceInfo[:descriptiveKeywords].empty?
                                @html.blockquote do
                                    resourceInfo[:descriptiveKeywords].each do |hKeyList|
                                        @html.em('List type: ')
                                        htmlKeyword.writeHtml(hKeyList)
                                    end
                                end
                            end
                        end

                        # resource information - spatial reference
                        @html.details do
                            @html.summary('Spatial Reference', {'id'=>'resourceInfo-spatialRef', 'class'=>'h3'})
                            @html.blockquote do

                            end
                        end

                        # resource information - extents
                        @html.details do
                            @html.summary('Spatial, temporal, and vertical extents', {'id'=>'resourceInfo-extents', 'class'=>'h3'})
                            @html.blockquote do

                            end
                        end

                        # resource information - data quality
                        @html.details do
                            @html.summary('Data Quality', {'id'=>'resourceInfo-dataQuality', 'class'=>'h3'})
                            @html.blockquote do

                            end
                        end

                        # resource information - constraints
                        @html.details do
                            @html.summary('Constraints', {'id'=>'resourceInfo-constraints', 'class'=>'h3'})
                            @html.blockquote do

                            end
                        end

                        # resource information - maintenance information
                        @html.details do
                            @html.summary('Maintenance information', {'id'=>'resourceInfo-maintInfo', 'class'=>'h3'})
                            if !resourceInfo[:resourceMaint].empty?
                                @html.blockquote do
                                    resourceInfo[:resourceMaint].each do |hResMaint|
                                        @html.em('Resource maintenance: ')
                                        htmlResMaint.writeHtml(hResMaint)
                                    end
                                end
                            end
                        end


                    end # writeHtml

                end # class

            end
        end
    end
end
