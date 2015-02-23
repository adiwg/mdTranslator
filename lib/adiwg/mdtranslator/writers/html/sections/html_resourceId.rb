

require 'html_citation'

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
                        htmlCitation = $HtmlNS::MdHtmlCitation.new(@html)

                        # identifier - required
                        @html.em('Identifier:')
                        @html.text!(hIdentifier[:identifier])

                        @html.em(' Type:')
                        @html.text!(hIdentifier[:identifierType])
                        @html.br

                        # identifier citation
                        if !hIdentifier[:identifierCitation].empty?
                            @html.blockquote do
                                htmlCitation.writeHtml(hIdentifier[:identifierCitation])
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
