

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlDateTime
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hDatetime)

                        # datetime
                        @html.text!(hDatetime[:dateTime].to_s)

                        # datetime type
                        @html.em(' Type: ')
                        @html.text!(hDatetime[:dateType])

                        # datetime resolution
                        @html.em(' Resolution: ')
                        @html.text!(hDatetime[:dateResolution])
                        @html.br

                    end # writeHtml

                end # class

            end
        end
    end
end
