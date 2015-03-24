# HTML writer
# dateTime

# History:
# 	Stan Smith 2015-03-23 original script

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlDateTime
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hDatetime)

                        # datetime - required
                        @html.text!(hDatetime[:dateTime].to_s)

                        # datetime type
                        s = hDatetime[:dateType]
                        if !s.nil?
                            @html.em(' Type: ')
                            @html.text!(hDatetime[:dateType])
                        end

                        # datetime resolution - set by reader
                        @html.em(' Resolution: ')
                        @html.text!(hDatetime[:dateResolution])
                        @html.br

                    end # writeHtml

                end # class

            end
        end
    end
end
