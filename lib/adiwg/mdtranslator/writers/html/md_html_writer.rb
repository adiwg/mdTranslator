module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlWriter
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(intObj)
                        @html.instruct! :html, encoding: 'UTF-8'
                        @html.comment!('HTML version of metadata content submitted to mdTranslator')

                    end
                end

            end
        end
    end
end