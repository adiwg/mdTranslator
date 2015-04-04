# HTML writer
# other resource information

# History:
# 	Stan Smith 2015-04-03 original script

require 'html_browseGraphic'
require 'html_resourceFormat'
require 'html_resourceUsage'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlResourceOther
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(resourceInfo)

                        # classes used
                        htmlBGraph = $HtmlNS::MdHtmlBrowseGraphic.new(@html)
                        htmlResForm = $HtmlNS::MdHtmlResourceFormat.new(@html)
                        htmlResUse = $HtmlNS::MdHtmlResourceUsage.new(@html)

                        # general - graphic overview
                        resourceInfo[:graphicOverview].each do |hBrowseG|
                            @html.em('Browse graphic: ')
                            htmlBGraph.writeHtml(hBrowseG)
                        end

                        # general - formats
                        resourceInfo[:resourceFormats].each do |hBrowseG|
                            htmlResForm.writeHtml(hBrowseG)
                        end

                        # general - languages
                        resourceInfo[:resourceLanguages].each do |language|
                            @html.em('Resource language: ')
                            @html.text!(language)
                            @html.br
                        end

                        # general - resource uses
                        aUse = resourceInfo[:resourceUses]
                        if !aUse.empty?
                            @html.details do
                                @html.summary('Resource specific usage', {'id'=>'resourceGen-usage', 'class'=>'h4'})
                                @html.blockquote do
                                    aUse.each do |hUsage|
                                        @html.em('Resource usage: ')
                                        @html.blockquote do
                                            htmlResUse.writeHtml(hUsage)
                                        end
                                    end
                                end
                                @html.br
                            end
                        end

                        # general - environment description
                        s = resourceInfo[:environmentDescription]
                        if !s.nil?
                            @html.em('Environment description: ')
                            @html.text!(s)
                            @html.br
                        end

                        # general - supplemental information
                        s = resourceInfo[:supplementalInfo]
                        if !s.nil?
                            @html.em('Supplemental information: ')
                            @html.blockquote do
                                @html.text!(s)
                            end
                        end

                    end # def writeHtml

                end

            end
        end
    end
end
