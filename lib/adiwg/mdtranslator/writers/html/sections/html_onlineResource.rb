# HTML writer
# online resource

# History:
# 	Stan Smith 2015-03-23 original script

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlOnlineResource
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hOlRes)

                        #online resource - URI
                        @html.em('Online resource: ')
                        @html.blockquote do

                            # online resource - URI
                            s = hOlRes[:olResURI]
                            @html.em('URI: ')
                            @html.a(s, 'href'=>s)
                            @html.br

                            # online resource - name
                            s = hOlRes[:olResName]
                            if s
                                @html.em('Name: ')
                                @html.text!(s)
                                @html.br
                            end

                            # online resource - description
                            s = hOlRes[:olResDesc]
                            if s
                                @html.em('Description: ')
                                @html.text!(s)
                                @html.br
                            end

                            # online resource - function
                            s1 = hOlRes[:olResFunction]
                            if s1
                                @html.em('Function: ')
                                @html.text!(s1)
                            end

                            # online resource - protocol
                            s2 = hOlRes[:olResProtocol]
                            if s2
                                @html.em('Protocol: ')
                                @html.text!(s2)
                            end

                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
