

require 'html_dattime'

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
                        htmlDatetime = $HtmlNS::MdHtmlDatetime.new(@html)

                        # citation title - required
                        @html.em('Title: ')
                        @html.text!(hCitation[:citTitle])
                        @html.br

                        # citation data
                        aDates = hCitation[:citDate]
                        aDates.each do |hDatetime|
                            @html.em('Date: ')
                            htmlDatetime.writeHtml(hDatetime)
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
