# HTML writer
# associated resource

# History:
# 	Stan Smith 2015-08-21 original script

require_relative 'html_citation'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlAssociatedResource
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hAssRes)

                        # classes used
                        htmlCitation = MdHtmlCitation.new(@html)

                        # associated resource - resource type
                        s = hAssRes[:resourceType]
                        if !s.nil?
                            @html.em('Resource type: ')
                            @html.text!(s)
                            @html.br
                        end

                        # associated resource - association type
                        s = hAssRes[:associationType]
                        if !s.nil?
                            @html.em('Association type: ')
                            @html.text!(s)
                            @html.br
                        end

                        # associated resource - initiative type
                        s = hAssRes[:initiativeType]
                        if !s.nil?
                            @html.em('Initiative type: ')
                            @html.text!(s)
                            @html.br
                        end

                        # associated resource - citation
                        hCitation = hAssRes[:resourceCitation]
                        if !hCitation.empty?
                            @html.em('Resource citation: ')
                            @html.section(:class=>'block') do
                                htmlCitation.writeHtml(hCitation)
                            end
                        end

                        # associated resource - metadata citation
                        hCitation = hAssRes[:metadataCitation]
                        if !hCitation.empty?
                            @html.em('Metadata citation: ')
                            @html.section(:class=>'block') do
                                htmlCitation.writeHtml(hCitation)
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
