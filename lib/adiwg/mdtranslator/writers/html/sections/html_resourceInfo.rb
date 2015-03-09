

require 'html_resourceGeneral'

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

                        # resource information - general
                        @html.h3('Resource', 'id'=>'resourceInfo-general')
                        @html.details do
                            @html.summary('show ...')
                            @html.blockquote do
                                htmlResGen.writeHtml(resourceInfo)
                            end
                        end

                        # resource information - web helpers
                        @html.h3('Web page helpers', 'id'=>'resourceInfo-webHelp')
                        @html.details do
                            @html.summary('show ...')
                            @html.blockquote do

                            end
                        end

                        # resource information - contacts
                        @html.h3('Contacts', 'id'=>'resourceInfo-contacts')
                        @html.details do
                            @html.summary('show ...')
                            @html.blockquote do

                            end
                        end

                        # resource information - constraints
                        @html.h3('Constraints', 'id'=>'resourceInfo-constraints')
                        @html.details do
                            @html.summary('show ...')
                            @html.blockquote do

                            end
                        end

                        # resource information - keywords
                        @html.h3('Keywords', 'id'=>'resourceInfo-keywords')
                        @html.details do
                            @html.summary('show ...')
                            @html.blockquote do

                            end
                        end

                        # resource information - spatial info
                        @html.h3('Spatial Information', 'id'=>'resourceInfo-spatialInfo')
                        @html.details do
                            @html.summary('show ...')
                            @html.blockquote do

                            end
                        end

                        # resource information - extents
                        @html.h3('Spatial, temporal, and vertical extents', 'id'=>'resourceInfo-extents')
                        @html.details do
                            @html.summary('show ...')
                            @html.blockquote do

                            end
                        end

                        # resource information - data quality
                        @html.h3('Data Quality', 'id'=>'resourceInfo-dataQuality')
                        @html.details do
                            @html.summary('show ...')
                            @html.blockquote do

                            end
                        end


                    end # writeHtml

                end # class

            end
        end
    end
end
