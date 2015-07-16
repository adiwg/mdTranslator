# HTML writer
# responsible party

# History:
# 	Stan Smith 2015-03-24 original script
#   Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS

require_relative 'html_contact'

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
                        htmlContact = MdHtmlContact.new(@html)

                        @html.details do
                            @html.summary(hResParty[:roleName], {'class'=>'h5'})
                            @html.section(:class=>'block') do
                                htmlContact.writeHtml(hResParty[:contactId])
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
