# HTML writer
# classed data item

# History:
# 	Stan Smith 2015-08-21 original script

module ADIWG
    module Mdtranslator
        module Writers
            module SimpleHtml

                class MdHtmlClassedDataItem
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hClassItem)

                        # classed data item - name
                        s = hClassItem[:className]
                        if !s.nil?
                            @html.em('Item name: ')
                            @html.text!(s)
                            @html.br
                        end

                        # classed data item - description
                        s = hClassItem[:classDescription]
                        if !s.nil?
                            @html.em('Item description: ')
                            @html.text!(s)
                            @html.br
                        end

                        # classed data item - value
                        s = hClassItem[:classValue]
                        if !s.nil?
                            @html.em('Item value: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
