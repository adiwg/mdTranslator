# HTML writer
# general resource information

# History:
# 	Stan Smith 2015-03-24 original script

require 'html_citation'
require 'html_timePeriod'
require 'html_browseGraphic'
require 'html_resourceFormat'
require 'html_resourceUsage'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlResourceGeneral
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(resourceInfo)

                        # classes used
                        htmlCitation = $HtmlNS::MdHtmlCitation.new(@html)
                        htmlTimeP = $HtmlNS::MdHtmlTimePeriod.new(@html)
                        htmlBGraph = $HtmlNS::MdHtmlBrowseGraphic.new(@html)
                        htmlResForm = $HtmlNS::MdHtmlResourceFormat.new(@html)
                        htmlResUse = $HtmlNS::MdHtmlResourceUsage.new(@html)

                        # general - title - taken from citation
                        @html.em('Title: ')
                        @html.text!(resourceInfo[:citation][:citTitle])
                        @html.br

                        # general - resource type - required
                        @html.em('Resource type: ')
                        @html.text!(resourceInfo[:resourceType])
                        @html.br

                        # general - time period
                        if !resourceInfo[:timePeriod].empty?
                            @html.em('Time period: ')
                            @html.blockquote do
                                htmlTimeP.writeHtml(resourceInfo[:timePeriod])
                            end
                        end

                        #general - status
                        s = resourceInfo[:status]
                        if !s.nil?
                            @html.em('Status: ')
                            @html.text!(s)
                            @html.br
                        end

                        # general - citation
                        @html.details do
                            @html.summary('Citation', {'id'=>'resourceGen-citation', 'class'=>'h4'})
                            @html.blockquote do
                                htmlCitation.writeHtml(resourceInfo[:citation])
                            end
                        end

                        # general - abstract - required
                        @html.details do
                            @html.summary('Abstract', {'id'=>'resourceGen-abstract', 'class'=>'h4'})
                            @html.blockquote do
                                @html.text!(resourceInfo[:abstract])
                            end
                            @html.br
                        end

                        # general - purpose
                        s = resourceInfo[:purpose]
                        if !s.nil?
                            @html.em('Purpose: ')
                            @html.text!(s)
                            @html.br
                        end

                        # general - credits
                        resourceInfo[:credits].each do |credit|
                            @html.em('Contributor: ')
                            @html.text!(credit)
                            @html.br
                        end

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


                    end # def writeHtml

                end

            end
        end
    end
end
