# HTML writer
# vertical element

# History:
# 	Stan Smith 2015-04-03 original script

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlVerticalElement
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hVertEle)

                        # vertical element - min value
                        n = hVertEle[:minValue]
                        if !n.nil?
                            @html.em('Minimum value: ')
                            @html.text!(n.to_s)
                            @html.br
                        end

                        # vertical element - max value
                        n = hVertEle[:maxValue]
                        if !n.nil?
                            @html.em('Maximum value: ')
                            @html.text!(n.to_s)
                            @html.br
                        end

                        # vertical element - coordinate reference system name
                        s = hVertEle[:crsTitle]
                        if !s.nil?
                            @html.em('Coordinate Reference System: ')
                            @html.text!(s)
                            @html.br
                        end

                        # vertical element - coordinate reference system URI
                        s = hVertEle[:crsURI]
                        if !s.nil?
                            @html.em('Coordinate Reference System URI: ')
                            @html.blockquote do
                                @html.a(s)
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
