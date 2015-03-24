# HTML writer
# general resource contacts

# History:
# 	Stan Smith 2015-03-23 original script

require 'html_responsibleParty'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlResourceContact
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(resourceInfo)

                        # classes used
                        htmlParty = $HtmlNS::MdHtmlResponsibleParty.new(@html)

                        # general - contacts
                        resourceInfo[:pointsOfContact].each do |hResParty|
                            htmlParty.writeHtml(hResParty)
                        end

                    end # def writeHtml

                end

            end
        end
    end
end
