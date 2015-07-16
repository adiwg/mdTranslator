# HTML writer
# general resource information

# History:
# 	Stan Smith 2015-03-24 original script
#   Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS

require_relative 'html_citation'
require_relative 'html_timePeriod'
require_relative 'html_browseGraphic'
require_relative 'html_resourceFormat'
require_relative 'html_resourceUsage'

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
                        htmlCitation = MdHtmlCitation.new(@html)
                        htmlTimeP = MdHtmlTimePeriod.new(@html)
                        htmlBGraph = MdHtmlBrowseGraphic.new(@html)
                        htmlResForm = MdHtmlResourceFormat.new(@html)
                        htmlResUse = MdHtmlResourceUsage.new(@html)

                        # general - title - taken from citation
                        @html.em('Title: ')
                        @html.text!(resourceInfo[:citation][:citTitle])
                        @html.br

                        # general - resource type - required
                        @html.em('Resource type: ')
                        @html.text!(resourceInfo[:resourceType])
                        @html.br

                        # general - topic categories
                        aTopics = resourceInfo[:topicCategories]
                        if !aTopics.empty?
                            @html.em('Topic categories: ')
                            @html.text!(aTopics.to_s)
                            @html.br
                        end

                        # general - time period
                        if !resourceInfo[:timePeriod].empty?
                            @html.em('Time period: ')
                            @html.section(:class=>'block') do
                                htmlTimeP.writeHtml(resourceInfo[:timePeriod])
                            end
                        end

                        # general - status
                        s = resourceInfo[:status]
                        if !s.nil?
                            @html.em('Status: ')
                            @html.text!(s)
                            @html.br
                        end

                        # general - languages
                        aLangs = resourceInfo[:resourceLanguages]
                        if !aLangs.empty?
                            @html.em('Resource Languages: ')
                            @html.text!(aLangs.to_s)
                            @html.br
                        end

                        # general - character sets
                        aCharSets = resourceInfo[:resourceCharacterSets]
                        if !aCharSets.empty?
                            @html.em('Resource character sets: ')
                            @html.text!(aCharSets.to_s)
                            @html.br
                        end

                        # general - citation
                        @html.details do
                            @html.summary('Citation', {'id'=>'resourceGen-citation', 'class'=>'h4'})
                            @html.section(:class=>'block') do
                                htmlCitation.writeHtml(resourceInfo[:citation])
                            end
                        end

                        # general - abstract - required
                        @html.details do
                            @html.summary('Abstract', {'id'=>'resourceGen-abstract', 'class'=>'h4'})
                            @html.tag!("section",resourceInfo[:abstract], :class=>'block pre-line')
                        end

                        # general - purpose
                        s = resourceInfo[:purpose]
                        if !s.nil?
                            @html.em('Purpose: ')
                            @html.section(:class=>'block') do
                                @html.text!(s)
                            end
                        end

                        # general - credits
                        resourceInfo[:credits].each do |credit|
                            @html.em('Contributor: ')
                            @html.text!(credit)
                            @html.br
                        end

                    end # def writeHtml

                end

            end
        end
    end
end
