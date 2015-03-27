# HTML writer
# data dictionary domain member

# History:
# 	Stan Smith 2015-03-26 original script

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlDomainMember
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hDItem)

                        # domain member - common name
                        s = hDItem[:itemName]
                        if !s.nil?
                            @html.em('Common name: ')
                            @html.text!(s)
                            @html.br
                        end

                        # domain member - value
                        s = hDItem[:itemValue]
                        if !s.nil?
                            @html.em('Domain value: ')
                            @html.text!(s)
                            @html.br
                        end

                        # domain member - definition
                        s = hDItem[:itemDefinition]
                        if !s.nil?
                            @html.em('Definition: ')
                            @html.blockquote do
                                @html.text!(s)
                            end
                        end


                    end # writeHtml

                end # class

            end
        end
    end
end
