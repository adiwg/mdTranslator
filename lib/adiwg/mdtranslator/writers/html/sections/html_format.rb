# HTML writer
# format

# History:
# 	Stan Smith 2015-03-27 original script
#   Stan Smith 2015-09-21 added compression method element

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlFormat
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hFormat)

                        # resource format - format name, version, compression method
                        s = hFormat[:formatName]
                        if !s.nil?
                            @html.em('Resource format: ')
                            @html.text!(s)
                            s = hFormat[:formatVersion]
                            if !s.nil?
                                @html.em('Version: ')
                                @html.text!(s)
                            end
                            s = hFormat[:compressionMethod]
                            if !s.nil?
                                @html.em('Compression: ')
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
