# HTML writer
# resource format

# History:
# 	Stan Smith 2015-03-24 original script

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlResourceFormat
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hResFormat)

                        # resource format - name - required
                        @html.em('Resource Format: ')
                        @html.text!(hResFormat[:formatName])

                        # resource format - version
                        s = hResFormat[:formatVersion]
                        if !s.nil?
                            @html.em(' Version: ')
                            @html.text!(s)
                        end

                        @html.br

                    end # writeHtml

                end # class

            end
        end
    end
end
