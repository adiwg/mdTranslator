# HTML writer
# medium

# History:
# 	Stan Smith 2015-03-27 original script

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlMedium
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hMedium)

                        # medium - name
                        s = hMedium[:mediumName]
                        if !s.nil?
                            @html.em('Medium name: ')
                            @html.text!(s)
                            @html.br
                        end

                        # medium - format
                        s = hMedium[:mediumFormat]
                        if !s.nil?
                            @html.em('Medium format: ')
                            @html.text!(s)
                            @html.br
                        end

                        # medium - note
                        s = hMedium[:mediumNote]
                        if !s.nil?
                            @html.em('Medium note: ')
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
