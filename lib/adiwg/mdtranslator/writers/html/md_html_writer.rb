
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), './templates'))

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlWriter
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(intObj)

                        # set template namespace
                        $TempNS = ADIWG::Mdtranslator::Writers::Html

                    end
                end

            end
        end
    end
end