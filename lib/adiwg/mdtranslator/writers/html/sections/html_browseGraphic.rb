# HTML writer
# browse graphic or graphic overview

# History:
# 	Stan Smith 2015-03-24 original script

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlBrowseGraphic
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hBrowseG)

                        @html.section(:class=>'block') do

                            # browse graphic - name
                            if !hBrowseG[:bGName].nil?
                                @html.em('Name: ')
                                @html.text!(hBrowseG[:bGName])
                                @html.br
                            end

                            # browse graphic - description
                            if !hBrowseG[:bGDescription].nil?
                                @html.em('Description: ')
                                @html.text!(hBrowseG[:bGDescription])
                                @html.br
                            end

                            # browse graphic - type
                            if !hBrowseG[:bGType].nil?
                                @html.em('Type: ')
                                @html.text!(hBrowseG[:bGType])
                                @html.br
                            end

                            # browse graphic - URI
                            if !hBrowseG[:bGURI].nil?
                                s = hBrowseG[:bGURI]
                                @html.em('URI:')
                                @html.section(:class=>'block') do
                                    @html.a(s, 'href'=>s)
                                end
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
