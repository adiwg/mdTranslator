# HTML writer
# medium

# History:
# 	Stan Smith 2015-03-27 original script
#   Stan Smith 2015-09-21 added medium capacity

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
                        s = hMedium[:mediumType]
                        if !s.nil?
                            @html.em('Medium type: ')
                            @html.text!(s)
                            @html.br
                        end

                        # medium - capacity
                        s = hMedium[:mediumCapacity]
                        if !s.nil?
                            @html.em('Medium capacity: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # medium - capacity units
                        s = hMedium[:mediumCapacityUnits]
                        if !s.nil?
                            @html.em('Medium capacity units: ')
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
                            @html.section(:class=>'block') do
                                @html.text!(s)
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
