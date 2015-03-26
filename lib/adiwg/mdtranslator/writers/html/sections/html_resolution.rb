# HTML writer
# resolution

# History:
# 	Stan Smith 2015-03-26 original script

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlResolution
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hSpaceRef)

                        s = hSpaceRef[:equivalentScale]
                        if !s.nil?
                            @html.em('Equivalent scale: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # resolution - distance
                        s = hSpaceRef[:distance]
                        if !s.nil?
                            @html.em('Distance: ')
                            @html.text!(s.to_s)
                            s = hSpaceRef[:distanceUOM]
                            if !s.nil?
                                @html.em('Unit of measure: ')
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
