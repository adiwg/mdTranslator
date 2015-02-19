
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), './sections'))

require 'html_head'
require 'html_body'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlWriter
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(intObj)

                        # set html section namespace
                        $HtmlNS = ADIWG::Mdtranslator::Writers::Html

                        # set contact array in a global
                        $aContacts = intObj[:contacts]

                        # classes used
                        htmlHead = $HtmlNS::MdHtmlHead.new(@html)
                        htmlBody = $HtmlNS::MdHtmlBody.new(@html)

                        # page
                        metadata = @html.instruct! :html, encoding: 'UTF-8'
                        @html.comment!('HTML version of metadata read into mdTranslation internal data store')

                        # head
                        htmlHead.writeHtml()

                        # body
                        htmlBody.writeHtml(intObj)

                        return metadata

                    end
                end

            end
        end
    end
end