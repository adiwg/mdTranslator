# HTML writer
# responsible party

# History:
# 	Stan Smith 2015-03-23 original script

require 'html_contact'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlResponsibleParty
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hResParty)

                        # classes used
                        htmlContact = $HtmlNS::MdHtmlContact.new(@html)

                        # responsible party - role
                        @html.em('Role: ')
                        @html.text!(hResParty[:roleName])
                        @html.br

                        # responsible party - contact info
                        @html.blockquote do
                            htmlContact.writeHtml(hResParty[:contactId])
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
