

require 'html_dateTime'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlCitation
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hCitation)

                        # classes used
                        htmlDateTime = $HtmlNS::MdHtmlDateTime.new(@html)

                        # citation title - required
                        @html.em('Title: ')
                        @html.text!(hCitation[:citTitle])
                        @html.br

                        # citation data
                        aDates = hCitation[:citDate]
                        aDates.each do |hDatetime|
                            @html.em('Date: ')
                            htmlDateTime.writeHtml(hDatetime)
                        end

                        # citation edition
                        s = hCitation[:citEdition]
                        if s
                            @html.em('Edition: ')
                            @html.text!(s)
                            @html.br
                        end

                        # citation resource ids - resource identifier


                    end # writeHtml

                end # class

            end
        end
    end
end
