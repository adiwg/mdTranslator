

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlMetadataInfo
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(metaInfo)

                        # metadata identifier
                        @html.h3('Metadata Identifier', 'id'=>'metadata-identifier')
                        @html.blockquote do
                            @html.em('Identifier:')
                            @html.text!(metaInfo[:metadataId][:identifier])
                            @html.br

                            @html.em('Identifier type:')
                            @html.text!(metaInfo[:metadataId][:identifierType])
                            @html.br
                        end

                        # parent metadata - citation
                        @html.h3('Parent Metadata', 'id'=>'metadata-parent-identifier')


                    end # writeHtml

                end # class

            end
        end
    end
end
