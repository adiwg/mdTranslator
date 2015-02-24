

require 'html_citation'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlMetadataInfo
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hMetaInfo)

                        # classes used
                        htmlCitation = $HtmlNS::MdHtmlCitation.new(@html)

                        # metadata identifier
                        @html.h3('Metadata Identifier', 'id'=>'metadata-identifier')
                        @html.blockquote do
                            @html.em('Identifier:')
                            @html.text!(hMetaInfo[:metadataId][:identifier])
                            @html.br

                            @html.em('Identifier type:')
                            @html.text!(hMetaInfo[:metadataId][:identifierType])
                            @html.br
                        end

                        # parent metadata - citation
                        @html.h3('Parent Metadata', 'id'=>'metadata-parent-identifier')
                        @html.blockquote do
                            htmlCitation.writeHtml(hMetaInfo[:parentMetadata])
                        end

                        # metadata custodians
                        

                    end # writeHtml

                end # class

            end
        end
    end
end
