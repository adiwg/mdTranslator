

require 'html_citation'

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

                        # general - resource type
                        @html.em('Resource type: ')
                        @html.text!(resourceInfo[:resourceType])
                        @html.br

                        # general - citation
                        @html.details do
                            @html.summary('citation ...')
                            @html.blockquote do
                                htmlCitation.writeHtml(resourceInfo[:citation])
                            end
                        end

                        # general - abstract - required
                        @html.details do
                            @html.summary('abstract ...')
                            @html.blockquote do
                                @html.text!(resourceInfo[:abstract])
                            end
                        end

                        # general - time period


                    end # def writeHtml

                end

            end
        end
    end
end
