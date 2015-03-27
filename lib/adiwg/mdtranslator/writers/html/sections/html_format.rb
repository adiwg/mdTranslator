# HTML writer
# format

# History:
# 	Stan Smith 2015-03-27 original script

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlFormat
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hFormat)

                        # resource format - format name
                        s = hFormat[:formatName]
                        if !s.nil?
                            @html.em('Resource format: ')
                            @html.text!(s)
                            s = hFormat[:formatVersion]
                            if !s.nil?
                                @html.em('Version: ')
                                @html.text!(s)
                            end
                            @html.br
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
