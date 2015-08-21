# HTML writer
# resource identifier

# History:
# 	Stan Smith 2015-03-24 original script
#   Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
#   Stan Smith 2015-08-21 expanded to handle RS_Identifier

require_relative 'html_citation'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlResourceId
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hIdentifier)

                        # classes used
                        htmlCitation = MdHtmlCitation.new(@html)

                        # identifier - required
                        @html.em('Identifier:')
                        @html.text!(hIdentifier[:identifier])
                        @html.br

                        # identifier - type
                        s = hIdentifier[:identifierType]
                        if !s.nil?
                            @html.em(' Type:')
                            @html.text!(s)
                            @html.br
                        end

                        # identifier - namespace
                        s = hIdentifier[:identifierNamespace]
                        if !s.nil?
                            @html.em(' Namespace:')
                            @html.text!(s)
                            @html.br
                        end

                        # identifier - version
                        s = hIdentifier[:identifierVersion]
                        if !s.nil?
                            @html.em(' Version:')
                            @html.text!(s)
                            @html.br
                        end

                        # identifier - description
                        s = hIdentifier[:identifierDescription]
                        if !s.nil?
                            @html.em(' Description:')
                            @html.text!(s)
                            @html.br
                        end

                        # identifier citation
                        if !hIdentifier[:identifierCitation].empty?
                            @html.section(:class=>'block') do
                                htmlCitation.writeHtml(hIdentifier[:identifierCitation])
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
