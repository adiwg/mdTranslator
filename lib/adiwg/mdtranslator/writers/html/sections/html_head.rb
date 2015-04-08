# HTML writer
# html head

# History:
# 	Stan Smith 2015-03-23 original script
#   Stan Smith 2015-04-07 added metadata tag to head

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlHead
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml()
                        @html.head do
                            @html.meta({'http-equiv'=>'Content-Type','content'=>'text/html; charset=utf-8'})
                            @html.title('ADIWG mdTranslator HTML writer output')

                            # add inline css
                            # read css from file
                            path = File.join(File.dirname(__FILE__), 'html_inlineCss.css')
                            file = File.open(path, 'r')
                            css = file.read
                            file.close

                            @html.style do
                                @html.text!(css)
                            end

                        end
                    end

                end

            end
        end
    end
end
