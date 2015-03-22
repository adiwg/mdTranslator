

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
