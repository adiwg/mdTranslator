# HTML writer
# descriptive keywords

# History:
# 	Stan Smith 2015-03-23 original script

require 'html_citation'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlKeyword
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hKeyList)

                        # classes used
                        htmlCitation = $HtmlNS::MdHtmlCitation.new(@html)

                        # descriptive keywords - type
                        s = hKeyList[:keywordType]
                        if !s.nil?
                            @html.text!(s)
                            @html.br
                        end

                        @html.blockquote do

                            # descriptive keywords - keywords - required
                            @html.em('Keywords: ')
                            @html.text!(hKeyList[:keyword].to_s)
                            @html.br

                            # descriptive keywords - citation
                            hCitation = hKeyList[:keyTheCitation]
                            if !hCitation.empty?
                                @html.em('Thesaurus citation: ')
                                @html.br
                                @html.blockquote do
                                    htmlCitation.writeHtml(hCitation)
                                end
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
