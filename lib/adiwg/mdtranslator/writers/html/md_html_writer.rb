# HTML writer

# History:
# 	Stan Smith 2015-03-23 original script
#   Stan Smith 2015-04-07 replaced instruct! with declare! and html to
#      ... conform with w3 html encoding declarations
#   Stan Smith 2015-06-23 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS

require_relative 'sections/html_head'
require_relative 'sections/html_body'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlWriter
                    def initialize(html,intObj, paramsObj)
                        @html = html
                        @@intObj = intObj
                        @paramsObj = paramsObj
                    end

                    def writeHtml()

                        # classes used
                        htmlHead = MdHtmlHead.new(@html, @paramsObj)
                        htmlBody = MdHtmlBody.new(@html)

                        # page
                        metadata = @html.declare! :DOCTYPE, :html
                        @html.html(:lang=>'en') do
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