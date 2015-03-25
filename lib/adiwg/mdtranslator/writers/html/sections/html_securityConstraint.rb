# HTML writer
# security constraint

# History:
# 	Stan Smith 2015-03-24 original script

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlSecurityConstraint
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hSecCon)

                        # security constraint - classification - required
                        @html.em('Classification: ')
                        @html.text!(hSecCon[:classCode])
                        @html.br

                        # security constraint - class system
                        s = hSecCon[:classSystem]
                        if !s.nil?
                            @html.em('Class system: ')
                            @html.text!(s)
                            @html.br
                        end

                        # security constraint - handling instructions
                        s = hSecCon[:handlingDesc]
                        if !s.nil?
                            @html.em('Handling instructions: ')
                            @html.text!(s)
                            @html.br
                        end

                        # security constraint - user note
                        s = hSecCon[:userNote]
                        if !s.nil?
                            @html.em('User note: ')
                            @html.text!(s)
                            @html.br
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
