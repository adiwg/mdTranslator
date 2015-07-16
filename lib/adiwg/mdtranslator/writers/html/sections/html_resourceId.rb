# HTML writer
# resource identifier

# History:
# 	Stan Smith 2015-03-24 original script
#   Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS

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

                        s = hIdentifier[:identifierType]
                        if !s.nil?
                            @html.em(' Type:')
                            @html.text!(s)
                        end

                        @html.br

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
