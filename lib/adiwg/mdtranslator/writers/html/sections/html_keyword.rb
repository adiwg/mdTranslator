# HTML writer
# descriptive keywords

# History:
# 	Stan Smith 2015-03-23 original script
#   Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS

require_relative 'html_citation'

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
                        htmlCitation = MdHtmlCitation.new(@html)

                        # descriptive keywords - type
                        s = hKeyList[:keywordType]
                        if !s.nil?
                            @html.text!(s)
                            @html.br
                        end

                        @html.section(:class=>'block') do

                            # descriptive keywords - keywords - required
                            @html.em('Keywords: ')
                            @html.ul do
                                hKeyList[:keyword].each do |keyword|
                                    @html.li(keyword)
                                end
                            end

                            # descriptive keywords - citation
                            hCitation = hKeyList[:keyTheCitation]
                            if !hCitation.empty?
                                @html.em('Thesaurus citation: ')
                                @html.br
                                @html.section(:class=>'block') do
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
