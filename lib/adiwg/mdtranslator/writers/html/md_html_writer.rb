# HTML writer

# History:
# 	Stan Smith 2015-03-23 original script
#   Stan Smith 2015-04-07 replaced instruct! with declare! and html to
#      ... conform with w3 html encoding declarations
#   Stan Smith 2015-06-23 replace global ($response) with passed in object (responseObj)


$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), './sections'))

require 'html_head'
require 'html_body'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlWriter
                    def initialize(html,intObj)
                        @html = html
                        @@intObj = intObj
                    end

                    def writeHtml()

                        # set html section namespace
                        $HtmlNS = ADIWG::Mdtranslator::Writers::Html

                        # classes used
                        htmlHead = $HtmlNS::MdHtmlHead.new(@html)
                        htmlBody = $HtmlNS::MdHtmlBody.new(@html)

                        # page
                        metadata = @html.declare! :DOCTYPE, :html
                        @html.html(:lang=>'en') do
                            @html.comment!('Report from mdTranslator HTML writer v1.0')

                            # head
                            htmlHead.writeHtml()

                            # body
                            htmlBody.writeHtml(@@intObj)
                        end

                        return metadata

                    end

                    def self.getContact(contactId)
                        @@intObj[:contacts].each do |hCont|
                            if hCont[:contactId] == contactId
                                return hCont
                            end
                        end
                        return nil
                    end

                end

            end
        end
    end
end